package com.ksh.beam.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ksh.beam.sys.entity.sys.ScheduleJob;

import java.util.Map;

/**
 * 定时任务
 */
public interface ScheduleJobMapper extends BaseMapper<ScheduleJob> {
	
	/**
	 * 批量更新状态
	 */
	int updateBatch(Map<String, Object> map);
}
