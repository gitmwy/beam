package com.hsshy.beam.sys.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hsshy.beam.sys.dao.MeetingMapper;
import com.hsshy.beam.sys.entity.Meeting;
import com.hsshy.beam.sys.service.MeetingService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * 会议管理
 */
@Service
public class MeetingServiceImpl extends ServiceImpl<MeetingMapper, Meeting> implements MeetingService {

    /**
     * 分页
     */
    @Override
    public IPage<Meeting> selectPageList(Page page, Meeting meeting) {
        return baseMapper.selectPageList(page,meeting);
    }

    /**
     * 导出
     */
    @Override
    public List<Map<String, Object>> exportData(Meeting meeting) {
        return baseMapper.exportData(meeting);
    }
}
