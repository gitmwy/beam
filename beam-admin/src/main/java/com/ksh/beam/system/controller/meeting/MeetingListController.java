package com.ksh.beam.system.controller.meeting;

import com.ksh.beam.common.annotion.SysLog;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.meeting.MeetingList;
import com.ksh.beam.system.service.MeetingListService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;

/**
 * 会议列表
 */
@Api(value = "MeetingListController", tags = {"MeetingList接口"})
@RequestMapping("/meeting/list")
@RestController
public class MeetingListController {

    @Autowired
    private MeetingListService meetingService;

    @SysLog(value = "会议列表分页")
    @ApiOperation("分页")
    @GetMapping(value = "/page/list")
    @RequiresPermissions("meeting:list")
    public R pageList(MeetingList meeting) {
        return meetingService.selectPageList(meeting);
    }

    @SysLog(value = "会议列表导出")
    @ApiOperation(value = "导出")
    @RequiresPermissions("meeting:list:export")
    @GetMapping("/export")
    public void export(MeetingList meeting, HttpServletResponse response) {
        meetingService.exportData(meeting, response);
    }
}
