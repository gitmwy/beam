package com.hsshy.beam.sys.dao;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hsshy.beam.sys.entity.Meeting;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 会议管理
 */
public interface MeetingMapper extends BaseMapper<Meeting> {

    IPage<Meeting> selectPageList(Page page, @Param("meeting") Meeting meeting);

    List<Map<String, Object>> exportData(@Param("meeting") Meeting meeting);
}
