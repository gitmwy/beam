package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.hospital.Detail;

import javax.servlet.http.HttpServletResponse;

/**
 * 医院列表
 */
public interface HospitalDetailService extends IService<Detail> {

    //分页
    R selectPageList(Detail hospital);

    //导出
    void exportData(Detail hospital, HttpServletResponse response);

    R deleteBatch(Long[] ids);

    R saveHospitalDetail(Detail detail);
}
