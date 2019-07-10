package com.ksh.beam.system.dao;

import com.ksh.beam.system.entity.sys.LoginLog;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;

/**
 * 登陆日志
 */
public interface LoginLogMapper extends BaseMapper<LoginLog> {

    void deleteAll();

    IPage<LoginLog> selectPageList(Page page, @Param("loginLog") LoginLog loginLog);
}
