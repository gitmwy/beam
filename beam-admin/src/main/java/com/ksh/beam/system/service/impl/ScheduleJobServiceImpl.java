package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.quartz.ScheduleUtils;
import com.ksh.beam.common.quartz.state.QuartzConstant;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.ToolUtil;
import com.ksh.beam.system.dao.ScheduleJobMapper;
import com.ksh.beam.system.entity.sys.ScheduleJob;
import com.ksh.beam.system.service.ScheduleJobService;
import com.ksh.beam.system.wrapper.ScheduleWrapper;
import org.quartz.CronTrigger;
import org.quartz.Scheduler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("scheduleJobService")
public class ScheduleJobServiceImpl extends ServiceImpl<ScheduleJobMapper, ScheduleJob> implements ScheduleJobService {

    @Qualifier("schedulerFactoryBean")
    @Autowired
    private Scheduler scheduler;

    /**
     * 项目启动时，初始化定时器
     */
    @PostConstruct
    public void init() {
        List<ScheduleJob> scheduleJobList = this.list(null);
        for (ScheduleJob scheduleJob : scheduleJobList) {
            CronTrigger cronTrigger = ScheduleUtils.getCronTrigger(scheduler, scheduleJob.getId());
            //如果不存在，则创建
            if (cronTrigger == null) {
                ScheduleUtils.createScheduleJob(scheduler, scheduleJob);
            } else {
                ScheduleUtils.updateScheduleJob(scheduler, scheduleJob);
            }
        }
    }

    @Override
    public R selectPageList(ScheduleJob scheduleJob) {
        QueryWrapper<ScheduleJob> qw = new QueryWrapper<>();
        if (ToolUtil.isNotEmpty(scheduleJob.getStatus())) {
            qw.eq("status", scheduleJob.getStatus());
        }
        if (ToolUtil.isNotEmpty(scheduleJob.getBeanName())) {
            qw.like("bean_name", scheduleJob.getBeanName());
        }
        IPage<com.ksh.beam.common.quartz.ScheduleJob> page = this.page(new Page(scheduleJob.getCurrentPage(), scheduleJob.getPageSize()), qw);
        return R.ok(new ScheduleWrapper(page).wrap());
    }

    @Override
    public R saveScheduleJob(ScheduleJob scheduleJob) {
        scheduleJob.setCreateTime(new Date());
        scheduleJob.setStatus(QuartzConstant.ScheduleStatus.NORMAL.getValue());
        this.saveOrUpdate(scheduleJob);
        ScheduleUtils.createScheduleJob(scheduler, scheduleJob);
        return R.ok();
    }

    @Override
    public R update(ScheduleJob scheduleJob) {
        ScheduleUtils.updateScheduleJob(scheduler, scheduleJob);
        this.updateById(scheduleJob);
        return R.ok();
    }

    @Override
    public R deleteBatch(Long[] jobIds) {
        for (Long jobId : jobIds) {
            ScheduleUtils.deleteScheduleJob(scheduler, jobId);
        }
        //删除数据
        this.removeByIds(Arrays.asList(jobIds));
        return R.ok();
    }

    @Override
    public int updateBatch(Long[] jobIds, int status) {
        Map<String, Object> map = new HashMap<>();
        map.put("list", Arrays.asList(jobIds));
        map.put("status", status);
        return baseMapper.updateBatch(map);
    }

    @Override
    public R run(Long[] jobIds) {
        for (Long jobId : jobIds) {
            ScheduleUtils.run(scheduler, this.getById(jobId));
        }
        return R.ok();
    }

    @Override
    public R pause(Long[] jobIds) {
        for (Long jobId : jobIds) {
            ScheduleUtils.pauseJob(scheduler, jobId);
        }
        updateBatch(jobIds, QuartzConstant.ScheduleStatus.PAUSE.getValue());
        return R.ok();
    }

    @Override
    public R resume(Long[] jobIds) {
        for (Long jobId : jobIds) {
            ScheduleUtils.resumeJob(scheduler, jobId);
        }
        updateBatch(jobIds, QuartzConstant.ScheduleStatus.NORMAL.getValue());
        return R.ok();
    }
}
