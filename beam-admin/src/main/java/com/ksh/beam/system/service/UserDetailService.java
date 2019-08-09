package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.user.UserDetail;

import javax.servlet.http.HttpServletResponse;

/**
 * 用户列表
 */
public interface UserDetailService extends IService<UserDetail> {

    //分页
    R selectPageList(UserDetail userDetail);

    //导出
    void exportData(UserDetail userDetail, HttpServletResponse response);

    R deleteBatch(Long[] deptIds);

    R saveUserDetail(UserDetail userDetail);

    R changeStatus(Long userId, Integer flag);
}
