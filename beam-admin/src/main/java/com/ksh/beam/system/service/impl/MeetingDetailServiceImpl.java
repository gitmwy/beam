package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.file.ExcelManager;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.dao.MeetingDetailMapper;
import com.ksh.beam.system.entity.meeting.Detail;
import com.ksh.beam.system.service.MeetingDetailService;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 会议列表
 */
@Service
public class MeetingDetailServiceImpl extends ServiceImpl<MeetingDetailMapper, Detail> implements MeetingDetailService {

    /**
     * 分页
     */
    @Override
    public R selectPageList(Detail meeting) {
        IPage page = baseMapper.selectPageList(new Page(meeting.getCurrentPage(), meeting.getPageSize()),meeting);
        return R.ok(page);
    }

    /**
     * 导出
     */
    @Override
    public void exportData(Detail meeting, HttpServletResponse response) {
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
        //导出文件
        ExcelManager.exportExcel(list, fieldMap, "会议数据", null, response);
    }
}
