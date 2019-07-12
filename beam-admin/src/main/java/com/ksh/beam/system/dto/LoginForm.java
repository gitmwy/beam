package com.ksh.beam.system.dto;

import lombok.Data;

/**
 * 登陆实体类
 **/
@Data
public class LoginForm {

    private String username;
    private String password;
    private String captcha;
}
