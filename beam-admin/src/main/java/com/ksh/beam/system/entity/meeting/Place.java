package com.ksh.beam.system.entity.meeting;

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
 * 会议场所
 */
@Data
@NoArgsConstructor
@TableName("meeting_place")
public class Place extends RestEntity<Long> {

    @TableId
    private Long id;

    @NotNull(message = "会议类型不能为空")
    @TableField(value = "type_id")
    private Long typeId;

    @NotBlank(message = "会议场所不能为空")
    @TableField(value = "place")
    private String place;

    @TableField(exist = false)
    private String typeName;

    @Override
    protected Serializable pkVal() {
        return this.id;
    }
}
