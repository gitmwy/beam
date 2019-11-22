package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.meeting.Auditor;
import com.ksh.beam.system.entity.meeting.Meeting;

import javax.servlet.http.HttpServletResponse;

/**
 * 会议列表
 */
public interface MeetingDetailService extends IService<Meeting> {

    //分页
    R selectPageList(Meeting meeting);

    //导出
    void exportData(Meeting meeting, HttpServletResponse response);

    //会议详细信息
    R getInfo(Long meetingId);

    //审核会议
    R saveAuditor(Auditor auditor);
}
