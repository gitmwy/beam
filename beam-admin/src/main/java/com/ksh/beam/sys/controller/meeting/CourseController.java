package com.ksh.beam.sys.controller.meeting;

import com.ksh.beam.common.annotion.SysLog;
import com.ksh.beam.common.enumeration.RetEnum;
import com.ksh.beam.common.exception.BeamException;
import com.ksh.beam.common.util.FtpUtil;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.ToolUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.UUID;

@Api(value = "CourseController", tags = {"会议课件接口"})
@RestController
@RequestMapping("/course")
public class CourseController {

    @Autowired
    private FtpUtil ftpUtil;

    @SysLog(value = "FTP文件上传")
    @ApiOperation(value = "FTP文件上传")
    @PostMapping("/ftpUpload")
    public Object ftpUploadFile(@RequestPart("file") MultipartFile file, @RequestParam(value = "fileType") String fileType) {
        String fileName = UUID.randomUUID().toString() + "." + ToolUtil.getFileSuffix(file.getOriginalFilename());
        try {
            String url = ftpUtil.uploadToFtp(file, fileName, fileType);



            return R.ok();
        } catch (Exception e) {
            e.printStackTrace();
            throw new BeamException(RetEnum.FTPUPLOAD_ERROR);
        }
    }
}
