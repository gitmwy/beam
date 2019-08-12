package com.ksh.beam.system.entity.meeting;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ksh.beam.common.base.entity.RestEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 会议问卷
 */
@Data
@NoArgsConstructor
@TableName("meeting_question")
public class Question extends RestEntity<Long> {

    @TableId
    private Long id;

    @TableField(value = "question_name")
    private String questionName;

    @TableField(value = "file_name")
    private String fileName;

    @TableField(value = "file_path")
    private String filePath;

    @TableField(value = "download_times")
    private Integer downloadTimes;


    @Override
    protected Serializable pkVal() {
        return this.id;
    }
}
