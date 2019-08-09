package com.ksh.beam.system.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ksh.beam.system.entity.user.UserRole;
import org.apache.ibatis.annotations.Param;

/**
 * 用户列表
 */
public interface UserRoleMapper extends BaseMapper<UserRole> {

    IPage<UserRole> selectPageList(Page page, @Param("role")UserRole userRole);
}
