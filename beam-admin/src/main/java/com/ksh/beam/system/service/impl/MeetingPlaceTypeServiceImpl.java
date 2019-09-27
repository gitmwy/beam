package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.dao.MeetingPlaceTypeMapper;
import com.ksh.beam.system.entity.meeting.PlaceType;
import com.ksh.beam.system.service.MeetingPlaceTypeService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 会议场所类型
 */
@Service
public class MeetingPlaceTypeServiceImpl extends ServiceImpl<MeetingPlaceTypeMapper, PlaceType> implements MeetingPlaceTypeService {

    /**
     * 获取会议类型列表
     */
    @Override
    public R getTypeList() {
        List<PlaceType> placeTypes = baseMapper.selectList(new QueryWrapper<>());
        return R.ok(placeTypes);
    }
}
