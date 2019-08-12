package com.ksh.beam.system.entity.meeting;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ksh.beam.common.base.entity.RestEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
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

    @NotBlank(message = "类型名称不能为空")
    @TableField(value = "type_name")
    private String typeName;

    @Override
    protected Serializable pkVal() {
        return this.id;
    }
}
