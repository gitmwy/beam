package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ksh.beam.system.entity.meeting.MeetingList;

import javax.servlet.http.HttpServletResponse;

/**
 * 会议列表
 */
public interface MeetingListService {

    //分页
    IPage<MeetingList> selectPageList(Page page, MeetingList meeting);

    //导出
    void exportData(MeetingList meeting, HttpServletResponse response);
}
