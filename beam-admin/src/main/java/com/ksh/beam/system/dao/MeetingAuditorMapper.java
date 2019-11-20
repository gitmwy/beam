package com.ksh.beam.system.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ksh.beam.system.entity.meeting.Auditor;
import org.springframework.stereotype.Repository;

/**
 * 审核记录
 */
@Repository
public interface MeetingAuditorMapper extends BaseMapper<Auditor> {

}
