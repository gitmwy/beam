package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.hospital.Area;

/**
 * 医院区域管理
 */
public interface HospitalAreaService extends IService<Area> {

    //树形区域
    R treeAreaList(Area area);

    R saveHospitalArea(Area area);

    //关联区域
    R getOptions(Integer level);

    //医院所属区域
    R getHospitalArea();

    R deleteBatch(Long[] ids);

    R getEditInfo(Long areaId);
}
