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
public class MeetingCourse extends RestEntity<Long> {

    @TableId
    private Long id;

    @TableField(value = "course_name")
    private String courseName;

    @TableField(value = "file_name")
    private String fileName;

    @TableField(value = "file_path")
    private String filePath;

    @TableField(value = "file_size")
    private String fileSize;

    @TableField(value = "download_times")
    private Integer downloadTimes;


    @Override
    protected Serializable pkVal() {
        return this.id;
    }
}
