package com.ksh.beam.common.file;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

public class FtpConfig implements Serializable{
    private static final long serialVersionUID = 1L;

    @NotBlank(message="ftpIp不能为空")
    private String ftpIp;
    @NotBlank(message="ftp短空不能为空")
    private Integer ftpPort;
    @NotBlank(message="ftp用户名不能为空")
    private String ftpUsername;
    @NotBlank(message="ftp密码不能为空")
    private String ftpPassword;
    @NotBlank(message="图片路径不能为空")
    private String imgPath;
    @NotBlank(message="视频路径不能为空")
    private String videoPath;
    @NotBlank(message="课件路径不能为空")
    private String coursePath;

    public String getFtpIp() {
        return ftpIp;
    }

    public void setFtpIp(String ftpIp) {
        this.ftpIp = ftpIp;
    }

    public Integer getFtpPort() {
        return ftpPort;
    }

    public void setFtpPort(Integer ftpPort) {
        this.ftpPort = ftpPort;
    }

    public String getFtpUsername() {
        return ftpUsername;
    }

    public void setFtpUsername(String ftpUsername) {
        this.ftpUsername = ftpUsername;
    }

    public String getFtpPassword() {
        return ftpPassword;
    }

    public void setFtpPassword(String ftpPassword) {
        this.ftpPassword = ftpPassword;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    public String getVideoPath() {
        return videoPath;
    }

    public void setVideoPath(String videoPath) {
        this.videoPath = videoPath;
    }

    public String getCoursePath() {
        return coursePath;
    }

    public void setCoursePath(String coursePath) {
        this.coursePath = coursePath;
    }
}
