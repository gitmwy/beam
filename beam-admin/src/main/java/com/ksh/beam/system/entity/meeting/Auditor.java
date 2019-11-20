package com.ksh.beam.system.entity.meeting;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ksh.beam.common.base.entity.AbstractEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Date;

/**
 * 审核记录
 */
@Data
@NoArgsConstructor
@TableName("meeting_auditor")
public class Auditor extends AbstractEntity<Long> {

    @TableId
    private Long id;

    @NotNull(message = "会议ID不能为空")
    @TableField(value = "meeting_id")
    private Long meetingId;

    @TableField(value = "auditor_name")
    private String auditorName;

    @TableField(value = "auditor_time")
    private Date auditorTime;

    @TableField(value = "auditor_text")
    private String auditorText;

    @NotBlank(message = "审核状态不能为空")
    @TableField(value = "auditor_status")
    private String auditorStatus;

    @TableField(value = "auditor_channel")
    private String auditorChannel;

    @Override
    protected Serializable pkVal() {
        return this.id;
    }
}
