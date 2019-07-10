package com.ksh.beam.sys.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.sys.entity.sys.Role;

import java.util.List;

/**
 * 角色
 */
public interface IRoleService extends IService<Role> {

    IPage<Role> selectPageList(Role role);

    R deleteRole(Long roleIds[]);

    List<Long> getCheckMenuIds(Long roleId);

    R saveMuenPerms(Role role);
}
