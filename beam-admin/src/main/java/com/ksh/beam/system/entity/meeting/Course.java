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

    @TableField(value = "name")
    private String name;

    @TableField(value = "url")
    private String url;

    @TableField(value = "size")
    private String size;

    @TableField(value = "times")
    private Integer times;


    @Override
    protected Serializable pkVal() {
        return this.id;
    }
}
