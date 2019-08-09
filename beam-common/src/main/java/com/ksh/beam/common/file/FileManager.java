package com.ksh.beam.common.file;

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
import java.net.URLEncoder;
import java.text.DecimalFormat;

/**
 * 文件工具
 */
public class FileManager {

    private static final Logger logger = LoggerFactory.getLogger(FileManager.class);

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
            logger.error("下载文件失败", e);
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
}