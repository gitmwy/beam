package com.ksh.beam.common.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ksh.beam.common.base.entity.AbstractEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 系统配置信息
 */
@Data
@NoArgsConstructor
@TableName("sys_config")
public class SysConfig extends AbstractEntity<Long> {

	@TableId
	private Long id;

	private String paramKey;

	private String paramValue;

	private Integer status;

	private String remark;

	@Override
	protected Serializable pkVal() {
		return this.id;
	}

}
