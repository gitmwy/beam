package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.user.UserArea;

/**
 * 区域管理
 */
public interface UserAreaService extends IService<UserArea> {

    //分页
    R selectPageList(UserArea userArea);

    R saveUserArea(UserArea userArea);

    //关联区域
    R getOptions(Integer level);

    //用户所属区域
    R getUserArea();

    R deleteBatch(Long[] deptIds);
}
