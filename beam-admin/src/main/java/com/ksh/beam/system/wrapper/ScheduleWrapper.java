package com.ksh.beam.system.wrapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.ksh.beam.common.base.warpper.BaseControllerWrapper;
import com.ksh.beam.common.factory.impl.ConstantFactory;
import com.ksh.beam.common.quartz.ScheduleJob;

import java.util.Map;

public class ScheduleWrapper extends BaseControllerWrapper {

    public ScheduleWrapper(IPage<ScheduleJob> page) {
        super(page);
    }

    @Override
    protected void wrapTheMap(Map<String, Object> map) {
        map.put("statusName", ConstantFactory.me().getDictsByCode("schedule_status",map.get("status")+""));
    }
}
