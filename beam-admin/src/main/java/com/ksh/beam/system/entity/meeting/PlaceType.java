package com.ksh.beam.system.entity.meeting;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ksh.beam.common.base.entity.RestEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 会议场所类型表
 */
@Data
@NoArgsConstructor
@TableName("meeting_place_type")
public class PlaceType extends RestEntity<Long> {

    @TableId
    private Long id;

    @TableField(value = "type_name")
    private String typeName;

    @Override
    protected Serializable pkVal() {
        return this.id;
    }
}
