package com.ksh.beam.system.entity.hospital;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ksh.beam.common.base.entity.RestEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 医生列表
 */
@Data
@NoArgsConstructor
@TableName("hospital_doctor")
public class Doctor extends RestEntity<Long> {

    @TableId
    private Long id;

    @TableField(value = "name")
    private String name;

    @TableField(value = "phone")
    private String phone;

    @TableField(value = "hospital_id")
    private Long hospitalId;

    @TableField(value = "department")
    private String department;

    @TableField(value = "position")
    private String position;

    @TableField(value = "title")
    private String title;

    @TableField(value = "sex")
    private Integer sex;

    @TableField(value = "flag")
    private Integer flag;

    @TableField(exist = false)
    private String sexName;

    @Override
    protected Serializable pkVal() {
        return this.id;
    }
}
