package com.ksh.beam.system.entity.sys;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ksh.beam.common.base.entity.RestEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * 角色
 */
@Data
@NoArgsConstructor
@TableName("sys_role")
public class Role extends RestEntity<Long> {

    @TableId
    private Long id;

    // 角色名称
    @NotBlank(message = "角色名称不能为空")
    @TableField(value = "role_name")
    private String roleName;

    // 备注
    @TableField(value = "remark")
    private String remark;

    @TableField(exist = false)
    private Long[] menuIds;

    //1：超级管理员，否则为空
    @TableField(exist = false)
    private String adminRole;

    @Override
    public Long getId() {
        return id;
    }

    @Override
    public void setId(Long id) {
        this.id = id;
    }

    @Override
    protected Serializable pkVal() {
        return this.id;
    }
}
