package com.hsshy.beam.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hsshy.beam.common.base.dto.TreeNode;
import com.hsshy.beam.common.base.service.ICommonService;
import com.hsshy.beam.sys.entity.Dept;
import com.hsshy.beam.sys.entity.Menu;

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
