package com.ksh.beam.system.dto;

import lombok.Data;

/**
 * 登陆实体类
 **/
@Data
public class LoginForm {

    private String username;
    private String password;
    private String captcha; //图形验证
    private boolean confirmSuccess; //滑动验证
}
