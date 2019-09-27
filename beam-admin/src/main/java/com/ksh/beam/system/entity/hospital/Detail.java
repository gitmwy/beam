package com.ksh.beam.system.entity.hospital;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ksh.beam.common.base.entity.RestEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 医院列表
 */
@Data
@NoArgsConstructor
@TableName("hospital_detail")
public class Detail extends RestEntity<Long> {

    @TableId
    private Long id;

    @TableField(value = "code")
    private String code;

    @TableField(value = "name")
    private String name;

    @TableField(value = "province_id")
    private Long provinceId;

    @TableField(value = "city_id")
    private Long cityId;

    @TableField(value = "managers_id")
    private Long managersId;

    @TableField(value = "county_id")
    private Long countyId;

    @Override
    protected Serializable pkVal() {
        return this.id;
    }
}
