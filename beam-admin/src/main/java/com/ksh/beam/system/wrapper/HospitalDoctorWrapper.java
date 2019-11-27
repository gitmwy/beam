package com.ksh.beam.system.wrapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.ksh.beam.common.base.BaseWrapper;
import com.ksh.beam.common.factory.impl.ConstantFactory;
import com.ksh.beam.system.entity.hospital.Doctor;

import java.util.Map;

public class HospitalDoctorWrapper extends BaseWrapper {

    public HospitalDoctorWrapper(IPage<Doctor> page) {
        super(page);
    }

    @Override
    protected void wrapTheMap(Map<String, Object> map) {
        map.put("sexName", ConstantFactory.me().getDictsByCode("sex",map.get("sex")+""));
    }
}
