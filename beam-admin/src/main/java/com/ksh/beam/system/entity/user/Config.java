package com.ksh.beam.system.entity.user;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 配置表
 */
@Data
@NoArgsConstructor
@TableName("user_config")
public class Config implements Serializable {

    private static final long serialVersionUID = -3504418053853304999L;

    @TableId
    private Long id;

    @TableField(value = "config_id")
    private Integer configId;

    @TableField(value = "param_key")
    private String paramKey;

    @TableField(value = "param_value")
    private String paramValue;

    @TableField(value = "status")
    private Integer status;
}
