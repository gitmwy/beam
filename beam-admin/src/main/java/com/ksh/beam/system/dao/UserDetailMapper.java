package com.ksh.beam.system.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ksh.beam.system.entity.user.UserDetail;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 用户列表
 */
public interface UserDetailMapper extends BaseMapper<UserDetail> {

    IPage<UserDetail> selectPageList(Page page, @Param("user") UserDetail userDetail);

    List<Map<String, Object>> exportData(@Param("user") UserDetail userDetail);
}
