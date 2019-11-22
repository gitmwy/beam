package com.ksh.beam.system.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ksh.beam.system.entity.user.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 用户列表
 */
@Repository
public interface UserDetailMapper extends BaseMapper<User> {

    IPage<User> selectPageList(Page page, @Param("user") User user);

    List<User> selectPageList(@Param("user") User user);
}
