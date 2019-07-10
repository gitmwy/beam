package com.ksh.beam.sys.wrapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.ksh.beam.common.base.warpper.BaseControllerWrapper;
import com.ksh.beam.common.factory.impl.ConstantFactory;

import java.util.Map;

public class UserWrapper extends BaseControllerWrapper {

    public UserWrapper(IPage<Map> page) {
        super(page);
    }

    @Override
    protected void wrapTheMap(Map<String, Object> map) {
        map.put("sexName", ConstantFactory.me().getDictsByCode("sex",map.get("sex")+""));
    }
}
