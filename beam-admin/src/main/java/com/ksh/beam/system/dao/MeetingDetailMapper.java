package com.ksh.beam.system.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ksh.beam.system.entity.meeting.Meeting;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 会议列表
 */
public interface MeetingDetailMapper extends BaseMapper<Meeting> {

    IPage<Meeting> selectPageList(Page page, @Param("meeting") Meeting meeting);

    List<Meeting> selectPageList(@Param("meeting") Meeting meeting);

    Map<String, Object> getInfo(Long meetingId);
}
