package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.base.BaseWrapper;
import com.ksh.beam.common.factory.impl.ConstantFactory;
import com.ksh.beam.common.file.ExcelUtil;
import com.ksh.beam.common.shiro.ShiroUtils;
import com.ksh.beam.common.utils.DateUtil;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.ToolUtil;
import com.ksh.beam.system.dao.MeetingAuditorMapper;
import com.ksh.beam.system.dao.MeetingDetailMapper;
import com.ksh.beam.system.entity.meeting.Auditor;
import com.ksh.beam.system.entity.meeting.Meeting;
import com.ksh.beam.system.service.MeetingDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 会议列表
 */
@Service
public class MeetingDetailServiceImpl extends ServiceImpl<MeetingDetailMapper, Meeting> implements MeetingDetailService {

    @Autowired
    private MeetingAuditorMapper meetingAuditorMapper;

    /**
     * 分页
     */
    @Override
    public R selectPageList(Meeting meeting) {
        IPage<Meeting> page = baseMapper.selectPageList(new Page(meeting.getCurrentPage(), meeting.getPageSize()),meeting);
        return R.ok(page);
    }

    /**
     * 导出
     */
    @Override
    public void exportData(Meeting meeting, HttpServletResponse response) {
        List<Meeting> meetings = baseMapper.selectPageList(meeting);
        Assert.notEmpty(meetings, "无法导出空数据");

        List<Map<String, Object>> list = new ArrayList<>();
        for (Meeting detail : meetings){
            Map<String, Object> map = BaseWrapper.beanToMap(detail);
            map.put("meetingStatus", ConstantFactory.me().getDictsByCode("meeting_status",map.get("meetingStatus")+""));
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
        fieldMap.put("topicName", "课件");
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
        Assert.notEmpty(map, "该会议已被删除");

        map.put("meetingType", ConstantFactory.me().getDictsByCode("meeting_type",map.get("meetingType")+""));
        map.put("meetingStatus", ConstantFactory.me().getDictsByCode("meeting_status",map.get("meetingStatus")+""));
        map.put("meetingVideo", ConstantFactory.me().getScene(meetingId,"01"));
        map.put("meetingImg", ConstantFactory.me().getScene(meetingId,"02"));
        map.put("laborImg", ConstantFactory.me().getScene(meetingId,"03"));
        map.put("invoiceImg", ConstantFactory.me().getScene(meetingId,"04"));
        map.put("preCost", ToolUtil.valueOf(map.get("preCost")));
        map.put("laborCost", ToolUtil.valueOf(map.get("laborCost")));
        map.put("activityCost", ToolUtil.valueOf(map.get("activityCost")));
        map.put("meetingAuditors", meetingAuditorMapper.selectList(new QueryWrapper<Auditor>().eq("meeting_id", meetingId)));
        return R.ok(map);
    }

    /**
     *审核会议
     */
    public R saveAuditor(Auditor auditor){
        Meeting meeting = baseMapper.selectOne(new QueryWrapper<Meeting>().eq("id", auditor.getMeetingId()).eq("del_flag", 1));
        Assert.notNull(meeting, "该会议已被删除");

        meeting.setAuditorId(ShiroUtils.getUserId());
        meeting.setAuditorTime(new Date());
        meeting.setMeetingStatus(auditor.getAuditorStatus());
        meeting.setAuditorText(auditor.getAuditorText());
        meeting.setAuditorChannel("beam");
        baseMapper.updateById(meeting);

        //审核记录
        auditor.setAuditorTime(new Date());
        auditor.setAuditorChannel("beam");
        auditor.setAuditorName(ShiroUtils.getUserEntity().getName());
        auditor.setAuditorStatus("03".equals(auditor.getAuditorStatus()) ? "通过" : "未通过");
        meetingAuditorMapper.insert(auditor);
        return R.ok();
    }
}
