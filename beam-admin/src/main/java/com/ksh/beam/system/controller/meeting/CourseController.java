package com.ksh.beam.system.controller.meeting;

import com.ksh.beam.common.annotion.SysLog;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.meeting.Course;
import com.ksh.beam.system.service.CourseService;
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
@Api(value = "CourseController", tags = {"Course接口"})
@RestController
@RequestMapping("/meeting/course")
public class CourseController {

    @Autowired
    private CourseService courseService;

    @SysLog(value = "会议课件分页")
    @ApiOperation("分页")
    @GetMapping(value = "/page/list")
    @RequiresPermissions("meeting:course:list")
    public R pageList(Course course) {
        return courseService.selectPageList(course);
    }

    @SysLog(value = "会议课件上传")
    @ApiOperation(value = "上传")
    @PostMapping("/ftpUpload")
    @RequiresPermissions("meeting:course:ftpUpload")
    public R ftpUpload(@RequestPart("file") MultipartFile file, @RequestParam(value = "fileType") String fileType) {
        Assert.notNull(fileType, "fileType不能为空");
        Assert.notNull(file, "请选择要上传的资源");
        return courseService.saveCoursePerms(file, fileType);
    }

    @SysLog(value = "会议课件删除")
    @ApiOperation("删除")
    @PostMapping(value = "/del")
    @RequiresPermissions("meeting:course:del")
    public R del(@RequestBody Long[] userIds) {
        Assert.notEmpty(userIds, "请选择要删除的资源");
        return courseService.deleteCourse(userIds);
    }

    @SysLog(value = "会议课件下载")
    @ApiOperation(value = "下载")
    @RequiresPermissions("meeting:course:download")
    @GetMapping("/download")
    public void download(@RequestParam Long id, HttpServletResponse response){
        Assert.notNull(id, "请选择要下载的资源");
        courseService.downloadFile(id, response);
    }
}