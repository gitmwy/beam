package com.ksh.beam.system.entity.user;

import com.baomidou.mybatisplus.annotation.FieldStrategy;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ksh.beam.common.base.entity.RestEntity;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.List;

/**
 * 区域表
 */
@Data
@NoArgsConstructor
@TableName("user_area")
@Accessors(chain = true)
public class Area extends RestEntity<Long> {

    @TableId
    private Long id;

    @TableField(value = "parent_id", strategy = FieldStrategy.IGNORED)
    private Long parentId;

    @TableField(value = "area_name")
    @NotBlank(message = "区域名称不能为空")
    private String areaName;

    @NotNull(message = "区域等级不能为空")
    @TableField(value = "level")
    private Integer level;

    @TableField(value = "level_name")
    private String levelName;

    @TableField(value = "option_areas")
    private String optionAreas;

    @TableField(value = "option_status")
    private Integer optionStatus;

    @TableField(exist = false)
    private List<?> children;

    @Override
    protected Serializable pkVal() {
        return this.id;
    }
}
