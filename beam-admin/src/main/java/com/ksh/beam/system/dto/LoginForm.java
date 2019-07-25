package com.ksh.beam.system.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * 登陆实体类
 **/
@Data
public class LoginForm {

    @NotBlank(message = "用户名不能为空")
    private String username;

    @NotBlank(message = "密码不能为空")
    private String password;

//    @NotBlank(message = "验证码不能为空")
//    private String captcha;

    private boolean confirmSuccess;
}
