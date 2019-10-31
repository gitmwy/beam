package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.base.BaseWrapper;
import com.ksh.beam.common.factory.impl.ConstantFactory;
import com.ksh.beam.common.file.ExcelUtil;
import com.ksh.beam.common.utils.DateUtil;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.dao.MeetingDetailMapper;
import com.ksh.beam.system.entity.meeting.Detail;
import com.ksh.beam.system.service.MeetingDetailService;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
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
        IPage<Detail> page = baseMapper.selectPageList(new Page(meeting.getCurrentPage(), meeting.getPageSize()),meeting);
        return R.ok(page);
    }

    /**
     * 导出
     */
    @Override
    public void exportData(Detail meeting, HttpServletResponse response) {
        List<Detail> details = baseMapper.selectPageList(meeting);
        List<Map<String, Object>> list = new ArrayList<>();
        for (Detail detail : details){
            Map<String, Object> map = BaseWrapper.beanToMap(detail);
            map.put("status", ConstantFactory.me().getDictsByCode("meeting_status",map.get("status")+""));
            map.put("meetingTime", DateUtil.greenwichTime(map.get("meetingTime")+""));
            map.put("applicantTime", DateUtil.greenwichTime(map.get("applicantTime")+""));
            list.add(map);
        }
        //定义存放英文字段名和中文字段名的Map
        LinkedHashMap<String, String> fieldMap = new LinkedHashMap<>();
        fieldMap.put("code", "编号");
        fieldMap.put("meetingTime", "会议时间");
        fieldMap.put("hospitalName", "医院名称");
        fieldMap.put("hospitalAddress", "所在省市");
        fieldMap.put("courseName", "课件");
        fieldMap.put("speakersName", "讲者");
        fieldMap.put("applicantTime", "申请时间");
        fieldMap.put("source", "来源");
        fieldMap.put("status", "状态");
        //导出文件
        ExcelUtil.exportExcel(list, fieldMap, "会议数据", null, response);
    }

    /**
     * 会议详细信息
     */
    @Override
    public R getInfo(Long meetingId) {
        Map<String, Object> map = baseMapper.getInfo(meetingId);
        map.put("meetingType", ConstantFactory.me().getDictsByCode("meeting_type",map.get("meetingType")+""));
        map.put("status", ConstantFactory.me().getDictsByCode("meeting_status",map.get("status")+""));
        map.put("meetingVideo", ConstantFactory.me().getScene(meetingId,"01"));
        map.put("meetingImg", ConstantFactory.me().getScene(meetingId,"02"));
        map.put("laborImg", ConstantFactory.me().getScene(meetingId,"03"));
        map.put("invoiceImg", ConstantFactory.me().getScene(meetingId,"04"));
        map.put("preCost", map.get("preCost")+"");
        map.put("laborCost", map.get("laborCost")+"");
        map.put("activityCost", map.get("activityCost")+"");
        return R.ok(map);
    }
}
