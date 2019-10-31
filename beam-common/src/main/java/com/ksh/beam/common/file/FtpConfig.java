package com.ksh.beam.common.file;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

@Data
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
}
