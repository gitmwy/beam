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
@TableName("meeting_cloud")
public class Cloud extends AbstractEntity<Long> {

    @TableId
    private Long id;

    @TableField(value = "meeting_id")
    private Long meetingId;

    @TableField(value = "meeting_code")
    private String meetingCode;

    @TableField(value = "type")
    private String type;

    @TableField(value = "upload_time")
    private Date uploadTime;

    @TableField(value = "user_id")
    private Long userId;

    @TableField(value = "url")
    private String url;

    @TableField(value = "name")
    private String name;

    @Override
    protected Serializable pkVal() {
        return this.id;
    }
}
