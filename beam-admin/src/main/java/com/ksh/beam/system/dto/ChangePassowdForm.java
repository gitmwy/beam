package com.ksh.beam.system.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * 登陆实体类
 **/
@Data
public class ChangePassowdForm {

    @NotBlank(message = "旧密码不能为空")
    private String oldPwd;
    @NotBlank(message = "新密码不能为空")
    private String newPwd;
    @NotBlank(message = "再次输入的新密码不能为空")
    private String password_confirm;
}
