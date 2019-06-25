package com.hsshy.beam.sys.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hsshy.beam.common.utils.FileUtil;
import com.hsshy.beam.common.utils.R;
import com.hsshy.beam.common.base.entity.ExcelEntity;
import com.hsshy.beam.sys.entity.Meeting;
import com.hsshy.beam.sys.service.MeetingService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 会议管理
 */
@Api(value = "MeetingController", tags = {"Meeting接口"})
@RequestMapping("/meeting")
@RestController
public class MeetingController {

    private static Logger logger = LoggerFactory.getLogger(MeetingController.class);

    @Autowired
    private MeetingService meetingService;

    //分页
    @ApiOperation("分页列表")
    @GetMapping(value = "/page/list")
    @RequiresPermissions("meeting:list")
    public R pageList(Meeting meeting) {
        IPage page = meetingService.selectPageList(new Page(meeting.getCurrentPage(), meeting.getPageSize()), meeting);
        return R.ok(page);
    }

    @ApiOperation(value = "文件导出")
    @GetMapping("/export")
    public void exportExcel(Meeting meeting, HttpServletResponse response) {
        try {
            //获取导出数据
            List<Map<String, Object>> list = meetingService.exportData(meeting);
            //定义存放英文字段名和中文字段名的Map
            LinkedHashMap<String, String> fieldMap = new LinkedHashMap<>();
            fieldMap.put("code", "编号");
            fieldMap.put("meeting_time", "会议时间");
            fieldMap.put("hospital_name", "医院名称");
            fieldMap.put("city", "所在省市");
            fieldMap.put("courseware", "课件");
            fieldMap.put("speakers", "讲者");
            fieldMap.put("application_time", "申请时间");
            fieldMap.put("source", "来源");
            fieldMap.put("flag", "状态");
            //Excel文档属性
            ExcelEntity excelEntity = new ExcelEntity();
            excelEntity.setManager("admin");
            excelEntity.setCategory("Excel文件");
            excelEntity.setCompany("北京");
            excelEntity.setSubject("数据");
            excelEntity.setTitle("会议数据");
            excelEntity.setAuthor("admin");
            excelEntity.setComments("导出文件");
            //导出文件
            FileUtil.exportFile(list, fieldMap, "会议数据", new HSSFWorkbook(), excelEntity, response);
        } catch (Exception e) {
            logger.info(e.getMessage());
            e.printStackTrace();
        }
    }
}
