package com.ksh.beam.system.entity.meeting;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ksh.beam.common.base.entity.AbstractEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 会议列表
 */
@Data
@NoArgsConstructor
@TableName("meeting_detail")
public class Detail extends AbstractEntity<Long> {

    @TableId
    private Long id;

    @TableField(value = "code")
    private String code;

    @TableField(value = "meeting_time")
    private Date meetingTime;

    @TableField(value = "meeting_type")
    private Integer meetingType;

    @TableField(value = "hospital_id")
    private Long hospitalId;

    @TableField(value = "course_id")
    private Long courseId;

    @TableField(value = "question_id")
    private Long questionId;

    @TableField(value = "speakers_id")
    private Long speakersId;

    @TableField(value = "applicant_id")
    private Long applicantId;

    @TableField(value = "auditor_id")
    private Long auditorId;

    @TableField(value = "pre_cost")
    private BigDecimal preCost;

    @TableField(value = "labor_cost")
    private BigDecimal laborCost;

    @TableField(value = "activity_cost")
    private BigDecimal activityCost;

    @TableField(value = "pre_persons")
    private Integer prePersons;

    @TableField(value = "real_persons")
    private Integer realPersons;

    @TableField(value = "applicant_time")
    private Date applicantTime;

    @TableField(value = "source")
    private String source;

    @TableField(value="status")
    private String status;

    @TableField(value="address")
    private String address;

    @TableField(value="topic")
    private String topic;

    @TableField(exist = false)
    private String hospitalName;

    @TableField(exist = false)
    private String hospitalAddress;

    @TableField(exist = false)
    private String courseName;

    @TableField(exist = false)
    private String speakersName;

    @TableField(exist = false)
    private String startTime;

    @TableField(exist = false)
    private String endTime;

    @Override
    protected Serializable pkVal() {
        return this.id;
    }
}
