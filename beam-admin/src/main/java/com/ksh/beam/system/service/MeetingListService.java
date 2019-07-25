package com.ksh.beam.system.service;

import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.meeting.MeetingList;

import javax.servlet.http.HttpServletResponse;

/**
 * 会议列表
 */
public interface MeetingListService {

    //分页
    R selectPageList(MeetingList meeting);

    //导出
    void exportData(MeetingList meeting, HttpServletResponse response);
}
