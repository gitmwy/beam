package com.ksh.beam.system.entity.meeting;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ksh.beam.common.base.entity.RestEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 会议课件
 */
@Data
@NoArgsConstructor
@TableName("meeting_course")
public class Course extends RestEntity<Long> {

    @TableId
    private Long id;

    @TableField(value = "course_name")
    private String courseName;

    @TableField(value = "course_url")
    private String courseUrl;

    @TableField(value = "course_size")
    private String courseSize;

    @TableField(value = "course_times")
    private Integer courseTimes;

    @Override
    protected Serializable pkVal() {
        return null;
    }
}
