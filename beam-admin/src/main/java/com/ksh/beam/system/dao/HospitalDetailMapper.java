package com.ksh.beam.system.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ksh.beam.system.entity.hospital.Detail;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 医院列表
 */
@Repository
public interface HospitalDetailMapper extends BaseMapper<Detail> {

    IPage<Detail> selectPageList(Page page, @Param("hospital") Detail hospital);

    List<Detail> selectPageList(@Param("hospital") Detail hospital);
}
