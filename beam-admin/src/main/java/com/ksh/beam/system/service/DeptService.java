package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.sys.Dept;

/**
 * 企业管理
 */
public interface DeptService extends IService<Dept> {

    /**
     * 获取树形列表
     */
    R treeDeptList(Dept dept);

    R saveDept(Dept dept);

    R deleteBatch(Long[] deptIds);

    R getEditInfo(Long deptId);
}
