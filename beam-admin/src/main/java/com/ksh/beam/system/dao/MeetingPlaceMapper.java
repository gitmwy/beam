package com.ksh.beam.system.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ksh.beam.system.entity.meeting.Place;
import io.lettuce.core.dynamic.annotation.Param;

/**
 * 会议场所
 */
public interface MeetingPlaceMapper extends BaseMapper<Place> {

    /**
     *分页
     */
    IPage<Place> selectPageList(Page page, @Param("place") Place place);
}
