
package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.sys.ScheduleJob;

/**
 * 定时任务
 */
public interface ScheduleJobService extends IService<ScheduleJob> {

	R selectPageList(ScheduleJob scheduleJob);

	/**
	 * 保存定时任务
	 */
	R saveScheduleJob(ScheduleJob scheduleJob);
	
	/**
	 * 更新定时任务
	 */
	R update(ScheduleJob scheduleJob);
	
	/**
	 * 批量删除定时任务
	 */
	R deleteBatch(Long[] jobIds);
	
	/**
	 * 批量更新定时任务状态
	 */
	int updateBatch(Long[] jobIds, int status);
	
	/**
	 * 立即执行
	 */
	R run(Long[] jobIds);
	
	/**
	 * 暂停运行
	 */
	R pause(Long[] jobIds);
	
	/**
	 * 恢复运行
	 */
	R resume(Long[] jobIds);
}
