package com.ksh.beam.system.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ksh.beam.system.entity.sys.Dept;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 企业管理
 */
@Repository
public interface DeptMapper extends BaseMapper<Dept> {

    List<Dept> queryListParentId(Long parentId);

    List<Dept> queryListByDept(@Param("dept") Dept dept);

    /**
     * 根据子ID查询所有父级
     */
    List<Dept> queryDeptNameById(@Param("id") Long id);
}
