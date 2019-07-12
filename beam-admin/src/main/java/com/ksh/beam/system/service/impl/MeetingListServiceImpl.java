package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.base.entity.ExcelEntity;
import com.ksh.beam.common.enumeration.RetEnum;
import com.ksh.beam.common.exception.BeamException;
import com.ksh.beam.common.utils.FileUtil;
import com.ksh.beam.system.dao.MeetingListMapper;
import com.ksh.beam.system.entity.meeting.MeetingList;
import com.ksh.beam.system.service.MeetingListService;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 会议列表
 */
@Service
public class MeetingListServiceImpl extends ServiceImpl<MeetingListMapper, MeetingList> implements MeetingListService {

    private static Logger logger = LoggerFactory.getLogger(MeetingListServiceImpl.class);

    /**
     * 分页
     */
    @Override
    public IPage<MeetingList> selectPageList(Page page, MeetingList meeting) {
        return baseMapper.selectPageList(page,meeting);
    }

    /**
     * 导出
     */
    @Override
    public void exportData(MeetingList meeting, HttpServletResponse response) {
        List<Map<String, Object>> list = baseMapper.exportData(meeting);
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
        try {
            //导出文件
            FileUtil.exportFile(list, fieldMap, "会议数据", new HSSFWorkbook(), excelEntity, response);
        } catch (Exception e) {
            logger.info(e.getMessage());
            throw new BeamException(RetEnum.EXPORT_ERROR);
        }
    }
}
