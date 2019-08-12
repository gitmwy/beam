package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.dao.MeetingPlaceMapper;
import com.ksh.beam.system.entity.meeting.Place;
import com.ksh.beam.system.service.MeetingPlaceService;
import org.springframework.stereotype.Service;

import java.util.Arrays;

/**
 * 会议场所
 */
@Service
public class MeetingPlaceServiceImpl extends ServiceImpl<MeetingPlaceMapper, Place> implements MeetingPlaceService {

    /**
     * 分页
     */
    @Override
    public R selectPageList(Place place) {
        IPage page = baseMapper.selectPageList(new Page(place.getCurrentPage(), place.getPageSize()), place);
        return R.ok(page);
    }

    /**
     * 保存场所
     */
    @Override
    public R savePlace(Place place) {
        this.saveOrUpdate(place);
        return R.ok();
    }

    /**
     *删除场所
     */
    @Override
    public R deletePlace(Long[] placeIds) {
        this.removeByIds(Arrays.asList(placeIds));
        return R.ok();
    }
}
