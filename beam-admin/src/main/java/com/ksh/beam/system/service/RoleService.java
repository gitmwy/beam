package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.sys.Role;

/**
 * 角色
 */
public interface RoleService extends IService<Role> {

    R selectPageList(Role role);

    R selectList();

    R deleteRole(Long[] roleIds);

    R getCheckMenuIds(Long roleId);

    R saveRoleMenu(Role role);

    R saveRole(Role role);
}
