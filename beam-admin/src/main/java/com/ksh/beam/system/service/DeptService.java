package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.system.entity.sys.Dept;

import java.util.List;

/**
 * 部门管理
 */
public interface DeptService extends IService<Dept> {

    /**
     * 获取树形列表
     */
    List<Dept> treeDeptList(Long deptId, Dept dept);

    List<Dept> queryListParentId(Long parentId);
}
