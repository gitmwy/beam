package com.ksh.beam.common.file;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPConnectionClosedException;
import org.apache.commons.net.ftp.FTPFile;
import org.apache.commons.net.ftp.FTPReply;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

/**
 * ftp工具
 */
public class FtpUtil extends FtpService{

    private static final Logger logger = LoggerFactory.getLogger(FtpUtil.class);

    private FTPClient ftpClient = new FTPClient();

    public FtpUtil(FtpConfig config){
        this.config = config;
    }

    /**
     * 上传文件附件到ftp服务器
     */
    public Map<String, String> ftpUpload(MultipartFile file, String fileName, String fileType) {
        Map<String, String> maps = null;
        try(InputStream is = file.getInputStream()) {
            // 建立连接
            connectToServer();
            ftpClient.enterLocalPassiveMode();
            setFileType();
            //改变文件路径
            String path = "beam/";
            if (!existDirectory(path)) {
                createDirectory(path);
            }
            ftpClient.changeWorkingDirectory(path);
            // 设置文件名字的编码格式为iso-8859-1，因为FTP上传的时候默认编码为iso-8859-1，解决文件名字乱码的问题
            fileName = new String(fileName.getBytes("GBK"), StandardCharsets.ISO_8859_1);
            // 输出操作结果信息
            if (ftpClient.storeFile(fileName, is)) {
                //获取文件属性
                maps = new HashMap<>();
                maps.put("fileName", fileName);
                maps.put("filePath", path);
                maps.put("fileSize", FileUtil.getFileSize(file.getSize()));
            }
        } catch (Exception e) {
            logger.error("上传文件失败", e);
        }finally {
            if (ftpClient.isConnected()) {
                closeConnect();
            }
        }
        return maps;
    }

    /**
     * 功能：根据文件名称，下载文件流
     */
    public void ftpDownload(String path, String ftpFileName, String fileName, HttpServletResponse response) {
        try {
            // 建立连接
            connectToServer();
            ftpClient.enterLocalPassiveMode();
            setFileType();
            ftpClient.changeWorkingDirectory(path);
            ftpFileName = new String(ftpFileName.getBytes("GBK"), StandardCharsets.ISO_8859_1);
            InputStream is = ftpClient.retrieveFileStream(ftpFileName);
            FileUtil.downloadFile(is, null, fileName, response);
        } catch (Exception e) {
            logger.error("下载文件失败", e);
        } finally {
            if (ftpClient.isConnected()) {
                closeConnect();
            }
        }
    }

    /**
     * 删除文件
     * @param path     FTP服务器保存目录
     * @param fileName 要删除的文件名称
     */
    public boolean ftpDelete(String path, String fileName) {
        boolean flag = false;
        try {
            connectToServer();
            //切换FTP目录
            ftpClient.changeWorkingDirectory(path);
            ftpClient.dele(fileName);
            flag = true;
        } catch (Exception e) {
            logger.error("删除文件失败", e);
        } finally {
            if (ftpClient.isConnected()) {
                closeConnect();
            }
        }
        return flag;
    }

    /**
     * 设置传输文件的类型[文本文件或者二进制文件]
     */
    private void setFileType() {
        try {
            ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
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
            String ip = config.getFtpIp();
            try {
                ftpClient = new FTPClient();
                ftpClient.connect(ip, config.getFtpPort());
                ftpClient.login(config.getFtpUsername(), config.getFtpPassword());
                //判断是否连接成功
                if (!FTPReply.isPositiveCompletion(ftpClient.getReplyCode())) {
                    ftpClient.disconnect();
                    throw new Exception("ftp连接失败");
                }
            } catch (FTPConnectionClosedException e) {
                logger.error("服务器:IP：" + ip + "没有连接数", e);
                throw e;
            } catch (Exception e) {
                logger.error("登录ftp服务器【" + ip + "】失败", e);
                throw e;
            }
        }
    }

    public boolean existDirectory(String path) {
        boolean flag = false;
        FTPFile[] ftpFileArr = new FTPFile[0];
        try {
            ftpFileArr = ftpClient.listFiles(path);
        } catch (IOException e) {
            e.printStackTrace();
        }
        for (FTPFile ftpFile : ftpFileArr) {
            if (ftpFile.isDirectory() && ftpFile.getName().equalsIgnoreCase(path)) {
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
}
