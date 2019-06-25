package com.hsshy.beam.sys.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hsshy.beam.sys.entity.Meeting;

import java.util.List;
import java.util.Map;

/**
 * 会议管理
 */
public interface MeetingService {

    //分页
    IPage<Meeting> selectPageList(Page page, Meeting meeting);

    //导出
    List<Map<String,Object>> exportData(Meeting meeting);
}
