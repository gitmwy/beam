package com.ksh.beam.system.service;

import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.meeting.Detail;

import javax.servlet.http.HttpServletResponse;

/**
 * 会议列表
 */
public interface MeetingDetailService {

    //分页
    R selectPageList(Detail meeting);

    //导出
    void exportData(Detail meeting, HttpServletResponse response);
}
