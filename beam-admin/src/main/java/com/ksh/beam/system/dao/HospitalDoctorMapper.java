package com.ksh.beam.system.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ksh.beam.system.entity.hospital.Doctor;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 医生列表
 */
public interface HospitalDoctorMapper extends BaseMapper<Doctor> {

    IPage<Doctor> selectPageList(Page page, @Param("doctor") Doctor doctor);

    List<Doctor> selectPageList(@Param("doctor") Doctor doctor);
}
