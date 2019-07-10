package com.ksh.beam.sys.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ksh.beam.sys.entity.meeting.MeetingList;

import java.util.List;
import java.util.Map;

/**
 * 会议列表
 */
public interface MeetingListService {

    //分页
    IPage<MeetingList> selectPageList(Page page, MeetingList meeting);

    //导出
    List<Map<String,Object>> exportData(MeetingList meeting);
}
