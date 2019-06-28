package com.hsshy.beam.sys.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.hsshy.beam.common.utils.R;
import com.hsshy.beam.sys.entity.Role;

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
