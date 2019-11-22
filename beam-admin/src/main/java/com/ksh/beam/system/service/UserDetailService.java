package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.user.User;

import javax.servlet.http.HttpServletResponse;

/**
 * 用户列表
 */
public interface UserDetailService extends IService<User> {

    //分页
    R selectPageList(User user);

    //导出
    void exportData(User user, HttpServletResponse response);

    R deleteBatch(Long[] ids);

    R saveUserDetail(User user);

    R changeStatus(Long userId, Integer flag);
}
