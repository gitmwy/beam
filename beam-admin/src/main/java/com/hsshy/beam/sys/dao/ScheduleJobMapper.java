package com.hsshy.beam.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hsshy.beam.sys.entity.ScheduleJobEntity;

import java.util.Map;

/**
 * 定时任务
 */
public interface ScheduleJobMapper extends BaseMapper<ScheduleJobEntity> {
	
	/**
	 * 批量更新状态
	 */
	int updateBatch(Map<String, Object> map);
}
