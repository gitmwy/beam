package com.ksh.beam.system.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ksh.beam.system.entity.user.Area;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 用户列表
 */
@Repository
public interface UserAreaMapper extends BaseMapper<Area> {

    IPage<Area> selectPageList(Page page, @Param("area") Area area);

    //根据父ID和等级获取区域
    List<Area> getAreaByParentIdAndLevel(@Param("level") Integer level, @Param("parentId") Long parentId);

    //获取最大的等级
    Integer getMaxLevel();
}
