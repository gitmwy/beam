package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.meeting.Place;

/**
 * 会议场所
 */
public interface MeetingPlaceService extends IService<Place> {

    /**
     * 分页
     */
    R selectPageList(Place place);

    /**
     * 新增场所
     */
    R savePlace(Place place);

    /**
     *删除场所
     */
    R deletePlace(Long[] placeIds);
}
