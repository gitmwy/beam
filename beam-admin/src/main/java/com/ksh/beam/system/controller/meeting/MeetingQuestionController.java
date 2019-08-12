package com.ksh.beam.system.controller.meeting;

import com.ksh.beam.common.annotion.SysLog;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.meeting.Question;
import com.ksh.beam.system.service.MeetingQuestionService;
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
 * 会议问卷
 */
@Api(value = "MeetingQuestionController", tags = {"MeetingQuestion接口"})
@RestController
@RequestMapping("/meeting/question")
public class MeetingQuestionController {

    @Autowired
    private MeetingQuestionService meetingQuestionService;

    @ApiOperation("问卷分页")
    @GetMapping(value = "/page/list")
    @RequiresPermissions("meeting:question:list")
    public R pageList(Question question) {
        return meetingQuestionService.selectPageList(question);
    }

    @SysLog(value = "问卷上传")
    @ApiOperation(value = "问卷上传")
    @PostMapping("/upload")
    @RequiresPermissions("meeting:question:upload")
    public R upload(@RequestPart("file") MultipartFile file, @RequestParam(value = "fileType", required = false) String fileType) {
        Assert.notNull(fileType, "fileType不能为空");
        Assert.notNull(file, "请选择要上传的资源");
        return meetingQuestionService.saveQuestion(file, fileType);
    }

    @SysLog(value = "问卷删除")
    @ApiOperation("问卷删除")
    @PostMapping(value = "/del")
    @RequiresPermissions("meeting:question:del")
    public R del(@RequestBody Long[] userIds) {
        Assert.notEmpty(userIds, "请选择要删除的资源");
        return meetingQuestionService.deleteQuestion(userIds);
    }

    @SysLog(value = "问卷下载")
    @ApiOperation(value = "问卷下载")
    @RequiresPermissions("meeting:question:download")
    @GetMapping("/download")
    public void download(@RequestParam(required = false) Long id, HttpServletResponse response){
        Assert.notNull(id, "请选择要下载的资源");
        meetingQuestionService.downloadFile(id, response);
    }
}
