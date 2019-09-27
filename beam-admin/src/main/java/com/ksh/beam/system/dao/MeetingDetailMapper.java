package com.ksh.beam.system.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ksh.beam.system.entity.meeting.Detail;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 会议列表
 */
public interface MeetingDetailMapper extends BaseMapper<Detail> {

    IPage<Detail> selectPageList(Page page, @Param("meeting") Detail meeting);

    List<Detail> selectPageList(@Param("meeting") Detail meeting);

    Map<String, Object> getInfo(Long meetingId);
}
