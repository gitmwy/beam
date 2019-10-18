package com.ksh.beam.system.entity.meeting;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ksh.beam.common.base.entity.AbstractEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

/**
 * 会议文件
 */
@Data
@NoArgsConstructor
@TableName("meeting_scene")
public class Scene extends AbstractEntity<Long> {

    @TableId
    private Long id;

    @TableField(value = "meeting_id")
    private Long meetingId;

    @TableField(value = "file_type")
    private String fileType;

    @TableField(value = "upload_time")
    private Date uploadTime;

    @TableField(value = "uploader_id")
    private Long uploaderId;

    @TableField(value = "file_path")
    private String filePath;

    @TableField(value = "file_name")
    private String fileName;

    @TableField(value = "real_name")
    private String realName;

    @Override
    protected Serializable pkVal() {
        return this.id;
    }
}
