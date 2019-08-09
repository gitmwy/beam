package com.ksh.beam.system.controller.common;

import com.ksh.beam.common.util.OSSFactory;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.ToolUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.Objects;
import java.util.UUID;

/**
 * 文件管理
 */
@Api(value = "FileManagerController", tags = {"FileManager接口"})
@RequestMapping("/file")
@RestController
public class FileManagerController {

    @ApiOperation(value = "对象存储文件上传")
    @PostMapping("/upload")
    public Object upload(@RequestPart("file") MultipartFile file) {
        Assert.notNull(file, "请选择要上传的文件");
        String fileName = UUID.randomUUID().toString() + "." + ToolUtil.getFileSuffix(file.getOriginalFilename());
        try {
            String url = Objects.requireNonNull(OSSFactory.buildCloud()).upload(file.getBytes(), fileName);
            return R.ok(url);
        } catch (Exception e) {
            e.printStackTrace();
            return R.fail("上传图片失败");
        }
    }
}
