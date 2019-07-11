package com.ksh.beam.system.controller.meeting;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.ksh.beam.common.annotion.SysLog;
import com.ksh.beam.common.enumeration.RetEnum;
import com.ksh.beam.common.exception.BeamException;
import com.ksh.beam.common.util.FtpUtil;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.ToolUtil;
import com.ksh.beam.system.entity.meeting.Course;
import com.ksh.beam.system.service.CourseService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;
import java.util.UUID;

/**
 * 会议课件
 */
@Api(value = "CourseController", tags = {"会议课件接口"})
@RestController
@RequestMapping("/meeting/course")
public class CourseController {

    @Autowired
    private FtpUtil ftpUtil;

    @Autowired
    private CourseService courseService;

    @SysLog(value = "会议课件分页")
    @ApiOperation("会议课件分页")
    @GetMapping(value = "/page/list")
    @RequiresPermissions("meeting:course:list")
    public R pageList(Course course) {
        IPage page = courseService.selectPageList(course);
        return R.ok(page);
    }

    @SysLog(value = "会议课件上传")
    @ApiOperation(value = "会议课件上传")
    @PostMapping("/ftpUpload")
    @RequiresPermissions("meeting:course:ftpUpload")
    public Object ftpUploadFile(@RequestPart("file") MultipartFile file, @RequestParam(value = "fileType") String fileType) {
        String fileName = UUID.randomUUID().toString() + "." + ToolUtil.getFileSuffix(file.getOriginalFilename());
        try {
            Map<String, String> maps = ftpUtil.uploadToFtp(file, fileName, fileType);
            maps.put("fileName", file.getOriginalFilename());
            return courseService.saveCoursePerms(maps);
        } catch (Exception e) {
            e.printStackTrace();
            throw new BeamException(RetEnum.FTPUPLOAD_ERROR);
        }
    }

    @ApiOperation("删除")
    @PostMapping(value = "/del")
    @RequiresPermissions("meeting:course:del")
    public R del(@RequestBody Course courses) {


        return R.ok();
    }
}
