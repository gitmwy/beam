package com.ksh.beam.system.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ksh.beam.system.entity.hospital.Area;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 医院区域管理
 */
@Repository
public interface HospitalAreaMapper extends BaseMapper<Area> {

    IPage<Area> selectPageList(Page page, @Param("area") Area area);

    //根据父ID和等级获取区域
    List<Area> getAreaByParentIdAndLevel(@Param("level") Integer level, @Param("parentId") Long parentId);

    //获取最大的等级
    Integer getMaxLevel();
}
