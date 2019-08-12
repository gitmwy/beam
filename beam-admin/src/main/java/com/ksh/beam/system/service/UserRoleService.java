package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.user.Role;

/**
 * 角色管理
 */
public interface UserRoleService extends IService<Role> {

    //分页
    R selectPageList(Role role);

    //用户所属角色
    R getUserRole();

    R saveUserArea(Role role);

    R deleteBatch(Long[] deptIds);
}
