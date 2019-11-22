package com.ksh.beam.system.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ksh.beam.system.entity.hospital.Hospital;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 医院列表
 */
@Repository
public interface HospitalDetailMapper extends BaseMapper<Hospital> {

    IPage<Hospital> selectPageList(Page page, @Param("hospital") Hospital hospital);

    List<Hospital> selectPageList(@Param("hospital") Hospital hospital);
}
