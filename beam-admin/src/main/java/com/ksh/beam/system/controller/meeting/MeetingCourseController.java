package com.ksh.beam.system.controller.meeting;

import com.ksh.beam.common.annotion.SysLog;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.meeting.MeetingCourse;
import com.ksh.beam.system.service.MeetingCourseService;
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
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;

/**
 * 会议课件
 */
@Api(value = "MeetingCourseController", tags = {"MeetingCourse接口"})
@RestController
@RequestMapping("/meeting/course")
public class MeetingCourseController {

    @Autowired
    private MeetingCourseService meetingCourseService;

    @ApiOperation("会议课件分页")
    @GetMapping(value = "/page/list")
    @RequiresPermissions("meeting:course:list")
    public R pageList(MeetingCourse meetingCourse) {
        return meetingCourseService.selectPageList(meetingCourse);
    }

    @SysLog(value = "会议课件上传")
    @ApiOperation(value = "会议课件上传")
    @PostMapping("/ftpUpload")
    @RequiresPermissions("meeting:course:ftpUpload")
    public R ftpUpload(@RequestPart("file") MultipartFile file, @RequestParam(value = "fileType", required = false) String fileType) {
        Assert.notNull(fileType, "fileType不能为空");
        Assert.notNull(file, "请选择要上传的资源");
        return meetingCourseService.saveCoursePerms(file, fileType);
    }

    @SysLog(value = "会议课件删除")
    @ApiOperation("会议课件删除")
    @PostMapping(value = "/del")
    @RequiresPermissions("meeting:course:del")
    public R del(@RequestBody Long[] userIds) {
        Assert.notEmpty(userIds, "请选择要删除的资源");
        return meetingCourseService.deleteCourse(userIds);
    }

    @SysLog(value = "会议课件下载")
    @ApiOperation(value = "会议课件下载")
    @RequiresPermissions("meeting:course:download")
    @GetMapping("/download")
    public void download(@RequestParam(required = false) Long id, HttpServletResponse response){
        Assert.notNull(id, "请选择要下载的资源");
        meetingCourseService.downloadFile(id, response);
    }
}
