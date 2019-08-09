package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.user.UserRole;

/**
 * 角色管理
 */
public interface UserRoleService extends IService<UserRole> {

    //分页
    R selectPageList(UserRole userRole);

    //用户所属角色
    R getUserRole();

    R saveUserArea(UserRole userRole);

    R deleteBatch(Long[] deptIds);
}
