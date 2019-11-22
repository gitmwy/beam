package com.ksh.beam.system.controller.meeting;

import com.ksh.beam.common.annotion.SysLog;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.meeting.Auditor;
import com.ksh.beam.system.entity.meeting.Meeting;
import com.ksh.beam.system.service.MeetingDetailService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

/**
 * 会议管理
 */
@Api(value = "MeetingDetailController", tags = {"会议管理"})
@RequestMapping("/meeting/detail")
@RestController
public class MeetingDetailController {

    @Autowired
    private MeetingDetailService meetingDetailService;

    @ApiOperation("会议列表分页")
    @GetMapping(value = "/page/list")
    @RequiresPermissions("meeting:detail:list")
    public R pageList(Meeting meeting) {
        return meetingDetailService.selectPageList(meeting);
    }

    @ApiOperation("会议详细信息")
    @GetMapping(value = "/info")
    @RequiresPermissions("meeting:detail:info")
    public R info(@RequestParam(required = false) Long meetingId) {
        Assert.notNull(meetingId, "请选择要查看的会议");
        return meetingDetailService.getInfo(meetingId);
    }

    @SysLog(value = "会议数据导出")
    @ApiOperation(value = "会议数据导出")
    @RequiresPermissions("meeting:detail:export")
    @GetMapping("/export")
    public void export(Meeting meeting, HttpServletResponse response) {
        meetingDetailService.exportData(meeting, response);
    }

    @SysLog(value = "审核会议")
    @ApiOperation("审核会议")
    @PostMapping(value = "/auditor")
    public R auditor(@RequestBody @Valid Auditor auditor) {
        return meetingDetailService.saveAuditor(auditor);
    }
}
