package com.ksh.beam.system.entity.hospital;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ksh.beam.common.base.entity.RestEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * 医院列表
 */
@Data
@NoArgsConstructor
@TableName("hospital_detail")
public class Hospital extends RestEntity<Long> {

    @TableId
    private Long id;

    @TableField(value = "code")
    private String code;

    @NotBlank(message = "医院名不能为空")
    @TableField(value = "name")
    private String name;

    @TableField(value = "address")
    private String address;

    @NotBlank(message = "医院级别不能为空")
    @TableField(value = "level")
    private String level;

    @TableField(value = "province_name")
    private String provinceName;

    @TableField(value = "province_code")
    private String provinceCode;

    @TableField(value = "city_name")
    private String cityName;

    @TableField(value = "city_code")
    private String cityCode;

    @TableField(value = "county_name")
    private String countyName;

    @TableField(value = "county_code")
    private String countyCode;

    @TableField(value = "managers_id")
    private Long managersId;

    @TableField(value = "area_id")
    private String areaId;

    @TableField(exist = false)
    private String areaName;

    @Override
    protected Serializable pkVal() {
        return this.id;
    }
}
