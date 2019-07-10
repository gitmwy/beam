package com.ksh.beam.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.sys.entity.sys.Dept;

import java.util.List;

/**
 * 部门管理
 */
public interface IDeptService extends IService<Dept> {


    /**
     * 获取树形列表
     */
    List<Dept> treeDeptList(Long deptId, Dept dept);

    List<Dept> queryListParentId(Long parentId);
}
