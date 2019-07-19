package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.system.entity.sys.Dept;
import com.ksh.beam.system.entity.sys.User;

import java.util.List;

/**
 * 企业管理
 */
public interface DeptService extends IService<Dept> {

    /**
     * 获取树形列表
     */
    List<Dept> treeDeptList(User user, Dept dept);

    /**
     *根据子ID查询所有父级
     */
    List<Dept> queryDeptNameById(Long id);
}
