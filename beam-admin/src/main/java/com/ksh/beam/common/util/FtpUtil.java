package com.ksh.beam.common.util;

import com.ksh.beam.common.utils.FileUtil;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPConnectionClosedException;
import org.apache.commons.net.ftp.FTPFile;
import org.apache.commons.net.ftp.FTPReply;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

/**
 * 文件上传下载工具类
 */
@Configuration
public class FtpUtil {

    private static final Logger logger = LoggerFactory.getLogger(FtpUtil.class);
    private static final String IMG = "img";
    private static final String VIDEO = "video";
    private static final String COURSE = "course";

    @Value("${ftp.username}")
    private String userName;

    @Value("${ftp.password}")
    private String passWord;

    @Value("${ftp.host}")
    private String ip;

    @Value("${ftp.port}")
    private int port;

    @Value("${ftp.img-path}")
    private String imgPath;

    @Value("${ftp.video-path}")
    private String videoPath;

    @Value("${ftp.course-path}")
    private String coursePath;

    private FTPClient ftpClient = new FTPClient();

    /**
     * 功能：上传文件附件到文件服务器
     */
    public Map<String, String> uploadToFtp(MultipartFile file, String fileName, String fileType) throws Exception {
        try (InputStream is = file.getInputStream()) {
            // 建立连接
            connectToServer();
            //改变文件路径
            String path = "";
            if (IMG.equals(fileType)) {
                path = imgPath;
            } else if (VIDEO.equals(fileType)) {
                path = videoPath;
            } else if (COURSE.equals(fileType)) {
                path = coursePath;
            }
            ftpClient.changeWorkingDirectory(path);
            // 设置传输二进制文件
            setFileType(FTP.BINARY_FILE_TYPE);
            // 设置文件名字的编码格式为iso-8859-1，因为FTP上传的时候默认编码为iso-8859-1，解决文件名字乱码的问题
            fileName = new String(fileName.getBytes("GBK"), StandardCharsets.ISO_8859_1);
            if (!FTPReply.isPositiveCompletion(ftpClient.getReplyCode())) {
                ftpClient.disconnect();
                throw new IOException("ftp连接失败：" + ip);
            }
            //设置被动模式
            ftpClient.enterLocalPassiveMode();
            // 输出操作结果信息
            if (ftpClient.storeFile(fileName, is)) {
                logger.info("ftp上传成功");
            } else {
                logger.info("ftp上传失败");
            }
            // 关闭连接
            closeConnect();
            //获取文件属性
            Map<String, String> maps = new HashMap<>();
            maps.put("fileUrl", path + fileName);
            maps.put("fileSize", FileUtil.getFileSize(file.getSize()));
            return maps;
        } catch (FTPConnectionClosedException e) {
            logger.error("ftp连接被关闭", e);
            throw e;
        } catch (Exception e) {
            logger.error("ftp上传失败 ", e);
            throw e;
        } finally {
            if (ftpClient.isConnected()) {
                closeConnect();
            }
        }
    }

    /**
     * 功能：根据文件名称，下载文件流
     */
    public InputStream downloadFile(String filename)
            throws IOException {
        InputStream in = null;
        try {
            // 建立连接
            connectToServer();
            ftpClient.enterLocalPassiveMode();
            // 设置传输二进制文件
            setFileType(FTP.BINARY_FILE_TYPE);
            int reply = ftpClient.getReplyCode();
            if (!FTPReply.isPositiveCompletion(reply)) {
                ftpClient.disconnect();
                throw new IOException("failed to connect to the FTP Server:" + ip);
            }
            ftpClient.changeWorkingDirectory(imgPath);

            // ftp文件获取文件
            in = ftpClient.retrieveFileStream(filename);

        } catch (FTPConnectionClosedException e) {
            logger.error("ftp连接被关闭！", e);
            throw e;
        } catch (Exception e) {
            logger.error("ERR : upload file " + filename + " from ftp : failed!", e);
        }
        return in;
    }

    /**
     * 设置传输文件的类型[文本文件或者二进制文件]
     */
    private void setFileType(int fileType) {
        try {
            ftpClient.setFileType(fileType);
        } catch (Exception e) {
            logger.error("ftp设置传输文件的类型时失败！", e);
        }
    }

    /**
     * 功能：关闭连接
     */
    public void closeConnect() {
        try {
            if (ftpClient != null) {
                ftpClient.logout();
                ftpClient.disconnect();
            }
        } catch (Exception e) {
            logger.error("ftp连接关闭失败！", e);
        }
    }

    /**
     * 连接到ftp服务器
     */
    private void connectToServer() throws Exception {
        if (!ftpClient.isConnected()) {
            try {
                ftpClient = new FTPClient();
                ftpClient.connect(ip, port);
                ftpClient.login(userName, passWord);

                if (!FTPReply.isPositiveCompletion(ftpClient.getReplyCode())) {
                    ftpClient.disconnect();
                    logger.info("connectToServer FTP server refused connection.");
                }
            } catch (FTPConnectionClosedException ex) {
                logger.error("服务器:IP：" + ip + "没有连接数！there are too many connected users,please try later", ex);
                throw ex;
            } catch (Exception e) {
                logger.error("登录ftp服务器【" + ip + "】失败", e);
                throw e;
            }
        }
    }

    public boolean existDirectory(String path) throws IOException {
        boolean flag = false;
        FTPFile[] ftpFileArr = ftpClient.listFiles(path);
        for (FTPFile ftpFile : ftpFileArr) {
            if (ftpFile.isDirectory()
                    && ftpFile.getName().equalsIgnoreCase(path)) {
                flag = true;
                break;
            }
        }
        return flag;
    }

    /**
     * 创建FTP文件夹目录
     */
    public boolean createDirectory(String pathName) {
        boolean isSuccess = false;
        try {
            isSuccess = ftpClient.makeDirectory(pathName);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    /**
     * 带点的
     */
    public static String getExtention(String fileName) {
        int pos = fileName.lastIndexOf(".");
        return fileName.substring(pos);
    }

    /**
     * 不带点
     */
    public static String getNoPointExtention(String fileName) {
        int pos = fileName.lastIndexOf(".");
        return fileName.substring(pos + 1);
    }
}
