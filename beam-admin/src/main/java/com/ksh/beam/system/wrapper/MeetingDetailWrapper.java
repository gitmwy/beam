package com.ksh.beam.system.wrapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.ksh.beam.common.base.BaseWrapper;
import com.ksh.beam.common.factory.impl.ConstantFactory;
import com.ksh.beam.system.entity.meeting.Detail;

import java.util.Map;

public class MeetingDetailWrapper extends BaseWrapper {

    public MeetingDetailWrapper(IPage<Detail> page) {
        super(page);
    }

    @Override
    protected void wrapTheMap(Map<String, Object> map) {
        map.put("meetingType", ConstantFactory.me().getDictsByCode("meeting_type",map.get("meetingType")+""));
        map.put("status", ConstantFactory.me().getDictsByCode("meeting_status",map.get("status")+""));
    }
}
