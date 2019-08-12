package com.ksh.beam.system.entity.user;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ksh.beam.common.base.entity.RestEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * 角色表
 */
@Data
@NoArgsConstructor
@TableName("user_role")
public class Role extends RestEntity<Long> {

    @TableId
    private Long id;

    @NotBlank(message = "角色名称不能为空")
    @TableField(value = "role_name")
    private String roleName;

    @NotNull(message = "角色等级不能为空")
    @TableField(value = "level")
    private Integer level;

    @TableField(value = "level_name")
    private String levelName;

    @Override
    protected Serializable pkVal() {
        return this.id;
    }
}
