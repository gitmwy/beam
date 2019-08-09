package com.ksh.beam.system.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ksh.beam.system.entity.meeting.MeetingCourse;
import io.lettuce.core.dynamic.annotation.Param;

/**
 * 会议课件
 */
public interface MeetingCourseMapper extends BaseMapper<MeetingCourse> {

    /**
     *分页
     */
    IPage<MeetingCourse> selectPageList(Page page, @Param("course") MeetingCourse meetingCourse);
}
