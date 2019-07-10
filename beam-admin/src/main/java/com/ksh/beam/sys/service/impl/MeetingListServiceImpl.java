package com.ksh.beam.sys.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.sys.dao.MeetingListMapper;
import com.ksh.beam.sys.entity.meeting.MeetingList;
import com.ksh.beam.sys.service.MeetingListService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * 会议列表
 */
@Service
public class MeetingListServiceImpl extends ServiceImpl<MeetingListMapper, MeetingList> implements MeetingListService {

    /**
     * 分页
     */
    @Override
    public IPage<MeetingList> selectPageList(Page page, MeetingList meeting) {
        return baseMapper.selectPageList(page,meeting);
    }

    /**
     * 导出
     */
    @Override
    public List<Map<String, Object>> exportData(MeetingList meeting) {
        return baseMapper.exportData(meeting);
    }
}
