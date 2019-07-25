package com.ksh.beam.system.entity.sys;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ksh.beam.common.base.entity.RestEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * 定时任务
 */
@Data
@NoArgsConstructor
@TableName("schedule_job")
public class ScheduleJob extends RestEntity<Long> {

	private static final long serialVersionUID = 1L;
	
	/**
	 * 任务调度参数key
	 */
    public static final String JOB_PARAM_KEY = "JOB_PARAM_KEY";
	
	/**
	 * 任务id
	 */
	@TableId
	private Long id;

	/**
	 * spring bean名称
	 */
	@NotBlank(message = "bean名称不能为空")
	private String beanName;
	
	/**
	 * 方法名
	 */
	@NotBlank(message = "方法名不能为空")
	private String methodName;
	
	/**
	 * 参数
	 */
	private String params;
	
	/**
	 * cron表达式
	 */
	@NotBlank(message = "cron表达式不能为空")
	private String cronExpression;

	/**
	 * 任务状态
	 */
	@NotNull(message = "任务状态不能为空")
	private Integer status;

	/**
	 * 备注
	 */
	private String remark;

	@Override
	public Long getId() {
		return id;
	}

	@Override
	public void setId(Long id) {
		this.id = id;
	}


	@Override
	protected Serializable pkVal() {
		return this.id;
	}


}
