package com.ksh.beam.system.entity.hospital;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ksh.beam.common.base.entity.RestEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

/**
 * 医院医生列表
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

    @TableField(value = "nickname")
    private String nickname;

    @TableField(value = "hospital_id")
    private Long hospitalId;

    @TableField(value = "hospital_dept_id")
    private Long hospitalDeptId;

    @TableField(value = "hospital_position_id")
    private Long hospitalPositionId;

    @TableField(value = "hospital_title_id")
    private Long hospitalTitleId;

    @TableField(value = "reg_time")
    private Date regTime;

    @TableField(value = "flag")
    private Integer flag;

    @Override
    protected Serializable pkVal() {
        return this.id;
    }
}
