package com.ksh.beam.system.controller.sys;

import com.ksh.beam.common.factory.impl.ConstantFactory;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.sys.ScheduleJob;
import com.ksh.beam.system.service.ScheduleJobService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.quartz.CronExpression;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

/**
 * 定时任务
 */
@RestController
@RequestMapping("/sys/schedule")
public class ScheduleJobController {

    @Autowired
    private ScheduleJobService scheduleJobService;

    /**
     * 定时任务列表
     */
    @RequestMapping("/page/list")
    @RequiresPermissions("sys:schedule:list")
    public R pageList(ScheduleJob scheduleJobEntity) {
        return  scheduleJobService.selectPageList(scheduleJobEntity);
    }

    /**
     * 新增定时任务
     */
    @RequestMapping("/add")
    @RequiresPermissions("sys:schedule:add")
    public R add(@RequestBody @Valid ScheduleJob scheduleJob) {
        if (!CronExpression.isValidExpression(scheduleJob.getCronExpression())) {
            return R.fail("cron表达式有误");
        }
        return scheduleJobService.saveScheduleJob(scheduleJob);
    }

    /**
     * 编辑定时任务
     */
    @RequestMapping("/edit")
    @RequiresPermissions("sys:schedule:edit")
    public R edit(@RequestBody @Valid ScheduleJob scheduleJob) {
        if (!CronExpression.isValidExpression(scheduleJob.getCronExpression())) {
            return R.fail("cron表达式有误");
        }
        return scheduleJobService.update(scheduleJob);
    }

    /**
     * 删除定时任务
     */
    @RequestMapping("/del")
    @RequiresPermissions("sys:schedule:del")
    public R del(@RequestBody Long[] jobIds) {
        Assert.notEmpty(jobIds, "请选择要删除的定时任务");
        return scheduleJobService.deleteBatch(jobIds);
    }

    /**
     * 立即执行任务
     */
    @RequestMapping("/run")
    @RequiresPermissions("sys:schedule:run")
    public R run(@RequestBody Long[] jobIds) {
        Assert.notEmpty(jobIds, "请选择要立即执行的定时任务");
        return scheduleJobService.run(jobIds);
    }

    /**
     * 暂停定时任务
     */
    @RequestMapping("/pause")
    @RequiresPermissions("sys:schedule:pause")
    public R pause(@RequestBody Long[] jobIds) {
        Assert.notEmpty(jobIds, "请选择要暂停的定时任务");
        return scheduleJobService.pause(jobIds);
    }

    /**
     * 恢复定时任务
     */
    @RequestMapping("/resume")
    @RequiresPermissions("sys:schedule:resume")
    public R resume(@RequestBody Long[] jobIds) {
        Assert.notEmpty(jobIds, "请选择要恢复的定时任务");
        return scheduleJobService.resume(jobIds);
    }

    /**
     * 获取定时任务状态下拉框
     */
    @GetMapping("/status/list")
    public R statusList() {
        return R.ok(ConstantFactory.me().getDictListByCode("schedule_status"));
    }
}
