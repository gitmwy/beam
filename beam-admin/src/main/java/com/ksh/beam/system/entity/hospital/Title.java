package com.ksh.beam.system.entity.hospital;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ksh.beam.common.base.entity.RestEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 医院职称表
 */
@Data
@NoArgsConstructor
@TableName("hospital_title")
public class Title extends RestEntity<Long> {

    @TableId
    private Long id;

    @TableField(value = "name")
    private String name;

    @Override
    protected Serializable pkVal() {
        return this.id;
    }
}