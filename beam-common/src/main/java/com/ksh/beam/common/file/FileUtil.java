package com.ksh.beam.common.file;

import com.ksh.beam.common.exception.BeamException;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletResponse;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.DecimalFormat;

/**
 * 文件工具
 */
public class FileUtil {

    private static final Logger logger = LoggerFactory.getLogger(FileUtil.class);

    /**
     * 文件下载
     */
    public static void downloadFile(InputStream is, HSSFWorkbook workbook, String fileName, HttpServletResponse response) {
        BufferedInputStream bis = null;
        try (OutputStream os = response.getOutputStream()){
            //设置响应
            response.reset();
            response.setContentType("application/x-download;charset=utf-8");
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(fileName, "UTF-8"));
            response.setHeader("Pragma", "No-cache");
            if(null != workbook && null == is){
                workbook.write(os);
            }else{
                bis = new BufferedInputStream(is);
                byte[] b=new byte[bis.available()+1000];
                int i;
                while((i=bis.read(b))!=-1) {
                    os.write(b, 0, i);
                }
            }
            os.flush();
        } catch (IOException e) {
            logger.error("下载文件关闭流失败", e);
        }finally {
            try {
                if(null != is){
                    is.close();
                }
                if(null != bis){
                    bis.close();
                }
            } catch (IOException e) {
                logger.error("下载文件关闭流失败", e);
            }
        }
    }

    /**
     * 删除目录
     */
    public static boolean deleteDir(File dir) {
        if (dir.isDirectory()) {
            String[] children = dir.list();
            for (String child : children) {
                boolean success = deleteDir(new File(dir, child));
                if (!success) {
                    return false;
                }
            }
        }
        return dir.delete();
    }

    /**
     * 复制文件
     */
    public static void copy(File src, File dst) throws Exception {
        int BUFFER_SIZE = 4096;
        try (InputStream is = new BufferedInputStream(new FileInputStream(src), BUFFER_SIZE);
             OutputStream os = new BufferedOutputStream(new FileOutputStream(dst), BUFFER_SIZE)
        ) {
            byte[] buffer = new byte[BUFFER_SIZE];
            int len;
            while ((len = is.read(buffer)) > 0) {
                os.write(buffer, 0, len);
            }
        }
    }

    /**
     * 获取文件大小
     */
    public static String getFileSize(long size) {
        double cache = size / 1024f;
        String unit = "KB";
        if (cache >= 1024f) {
            cache /= 1024f;
            unit = "MB";
        }
        if (cache >= 1024f) {
            cache /= 1024f;
            unit = "GB";
        }
        if (cache >= 1024f) {
            cache /= 1024f;
            unit = "TB";
        }
        return new DecimalFormat("0.00").format(cache) + unit;
    }

    /**
     * 根据URL路径下载
     */
    public static void urlDownload(String downloadUrl, String fileName, HttpServletResponse response) {
        fileName = new String (fileName.getBytes(StandardCharsets.UTF_8),StandardCharsets.ISO_8859_1);
        //响应头的设置
        response.reset();
        response.setContentType("application/force-download");
        response.addHeader("Content-Disposition","attachment;fileName=" + fileName);
        response.setContentType("application/octet-stream;charset=utf-8");
        BufferedInputStream bis = null;
        OutputStream os = null;
        try {
                URL url = new URL(downloadUrl);
                URLConnection conn = url.openConnection();
                conn.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");
                InputStream is = conn.getInputStream();
                int length = conn.getContentLength();
                response.setHeader("Content-Length", ""+length);
                bis = new BufferedInputStream(is);
                os = response.getOutputStream();
                byte[] buff = new byte[1024*10];
                int len;
                while ((len=bis.read(buff))>-1) {
                    os.write(buff,0,len);
                }
        } catch (Exception e) {
            logger.error("下载文件关闭流失败", e);
            throw new BeamException("下载文件失败");
        }finally{
            // 关闭流
            try {
                if (os != null) {
                    os.flush();
                    os.close();
                }
                if (bis != null) {
                    bis.close();
                }
            } catch (IOException e) {
                logger.error("下载文件关闭流失败", e);
            }
        }
    }
}