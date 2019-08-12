package com.ksh.beam.system.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ksh.beam.system.entity.meeting.Question;
import io.lettuce.core.dynamic.annotation.Param;

/**
 * 会议问卷
 */
public interface MeetingQuestionMapper extends BaseMapper<Question> {

    /**
     *分页
     */
    IPage<Question> selectPageList(Page page, @Param("question") Question question);
}
