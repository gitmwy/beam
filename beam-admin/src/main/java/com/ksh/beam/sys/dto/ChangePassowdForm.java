package com.ksh.beam.sys.dto;

import lombok.Data;

import javax.validation.constraints.NotNull;

/**
 * 登陆实体类
 **/
@Data
public class ChangePassowdForm {

    @NotNull(message = "旧密码不能为空")
    private String oldPwd;
    @NotNull(message = "新密码不能为空")
    private String newPwd;
    @NotNull(message = "再次输入的新密码不能为空")
    private String password_confirm;
}
