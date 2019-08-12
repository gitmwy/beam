package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.user.Detail;

import javax.servlet.http.HttpServletResponse;

/**
 * 用户列表
 */
public interface UserDetailService extends IService<Detail> {

    //分页
    R selectPageList(Detail detail);

    //导出
    void exportData(Detail detail, HttpServletResponse response);

    R deleteBatch(Long[] deptIds);

    R saveUserDetail(Detail detail);

    R changeStatus(Long userId, Integer flag);
}
