package com.ksh.beam.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ksh.beam.sys.entity.sys.Dept;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 部门管理
 */
public interface DeptMapper extends BaseMapper<Dept> {

    IPage<Dept> selectPageList(Page page, @Param("dept") Dept dept);

    List<Dept> queryListParentId(Long parentId);
}
