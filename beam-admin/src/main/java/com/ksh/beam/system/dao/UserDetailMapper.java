package com.ksh.beam.system.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ksh.beam.system.entity.user.Detail;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 用户列表
 */
@Repository
public interface UserDetailMapper extends BaseMapper<Detail> {

    IPage<Detail> selectPageList(Page page, @Param("user") Detail user);

    List<Detail> selectPageList(@Param("user") Detail detail);
}
