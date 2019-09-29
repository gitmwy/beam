package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.hospital.Doctor;

import javax.servlet.http.HttpServletResponse;

/**
 * 医生列表
 */
public interface HospitalDoctorService extends IService<Doctor> {

    //分页
    R selectPageList(Doctor doctor);

    //导出
    void exportData(Doctor doctor, HttpServletResponse response);
}
