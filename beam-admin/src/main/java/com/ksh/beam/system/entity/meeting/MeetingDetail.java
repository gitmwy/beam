package com.ksh.beam.system.entity.meeting;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ksh.beam.common.base.entity.RestEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

/**
 * 会议列表
 */
@Data
@NoArgsConstructor
@TableName("meeting_detail")
public class MeetingDetail extends RestEntity<Long> {

    @TableId
    private Long id;

    @TableField(value = "code")
    private Long code;

    @TableField(value = "meeting_time")
    private Date meetingTime;

    @TableField(value = "hospital_name")
    private String hospitalName;

    @TableField(value = "city")
    private String city;

    @TableField(value = "courseware")
    private String courseware;

    @TableField(value = "speakers")
    private String speakers;

    @TableField(value = "application_time")
    private Date applicationTime;

    @TableField(value = "source")
    private String source;

    @TableField(value = "operation")
    private String operation;

    @TableField(value="flag")
    private String flag;

    @TableField(exist = false)
    private String startTime;

    @TableField(exist = false)
    private String endTime;

    @Override
    protected Serializable pkVal() {
        return this.id;
    }
}
