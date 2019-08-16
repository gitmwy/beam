package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.user.Area;

/**
 * 区域管理
 */
public interface UserAreaService extends IService<Area> {

    //树形区域
    R treeAreaList(Area area);

    R saveUserArea(Area area);

    //关联区域
    R getOptions(Integer level);

    //用户所属区域
    R getUserArea();

    R deleteBatch(Long[] ids);

    R getEditInfo(Long areaId);
}
