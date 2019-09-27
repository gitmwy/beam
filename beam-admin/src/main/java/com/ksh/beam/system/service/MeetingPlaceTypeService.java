package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.meeting.PlaceType;

/**
 * 会议场所类型
 */
public interface MeetingPlaceTypeService extends IService<PlaceType> {

    //获取会议类型列表
    R getTypeList();
}
