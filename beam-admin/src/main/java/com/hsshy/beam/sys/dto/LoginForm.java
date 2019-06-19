package com.hsshy.beam.sys.dto;

import lombok.Data;

/**
 * 登陆实体类
 **/
@Data
public class LoginForm {

    private String username;
    private String password;
    private String kaptcha;
}
