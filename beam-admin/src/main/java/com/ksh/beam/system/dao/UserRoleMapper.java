package com.ksh.beam.system.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ksh.beam.system.entity.user.Role;
import org.apache.ibatis.annotations.Param;

/**
 * 用户列表
 */
public interface UserRoleMapper extends BaseMapper<Role> {

    IPage<Role> selectPageList(Page page, @Param("role") Role role);
}
