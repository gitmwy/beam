package com.ksh.beam.system.entity.user;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ksh.beam.common.base.entity.RestEntity;
import com.ksh.beam.common.constant.RegexConstant;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.Date;

/**
 * 用户列表
 */
@Data
@NoArgsConstructor
@TableName("user_detail")
public class User extends RestEntity<Long> {

    @TableId
    private Long id;

    @TableField(value = "job_code")
    private String jobCode;

    @TableField(value = "openid")
    private String openid;

    @TableField(value = "avatar")
    private String avatar;

    @TableField(value = "nickname")
    private String nickname;

    @NotBlank(message = "姓名不能为空")
    @TableField(value = "username")
    private String username;

    @NotBlank(message = "手机号不能为空")
    @Size(max = 11)
    @Pattern(regexp = RegexConstant.PHONE_REGEX, message = "请输入正确的手机号")
    @TableField(value = "phone")
    private String phone;

    @TableField(value = "password")
    private String password;

    @TableField(value = "salt")
    private String salt;

    @TableField(value = "area_id")
    private Long areaId;

    @TableField(value = "role_id")
    private Long roleId;

    @TableField(value = "status")
    private Integer status;

    @TableField(value = "bound_time")
    private Date boundTime;

    @TableField(exist = false)
    private String areaName;

    @TableField(exist = false)
    private String roleName;

    @TableField(exist = false)
    private Integer areaLevel;

    @TableField(exist = false)
    private Integer roleLevel;

    @Override
    protected Serializable pkVal() {
        return this.id;
    }
}
