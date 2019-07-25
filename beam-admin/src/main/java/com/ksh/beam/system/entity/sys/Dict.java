package com.ksh.beam.system.entity.sys;

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
 * 字典表
 */
@Data
@NoArgsConstructor
@TableName("sys_dict")
public class Dict extends RestEntity<Long> {

    // 主键id
    @TableId
    private Long id;

    // 父级字典
    @NotNull(message = "父级字典不能为空")
    @TableField(value = "pid")
    private Long pid;

    // 名称
    @NotBlank(message = "名称不能为空")
    @TableField(value = "name")
    private String name;

    // 描述
    @TableField(value = "des")
    private String des;

    // 编码
    @NotBlank(message = "编码不能为空")
    @TableField(value = "code")
    private String code;

    // 排序
    @TableField(value = "sort")
    private Integer sort;

    // 编码
    @TableField(exist = false)
    private String keyword;

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