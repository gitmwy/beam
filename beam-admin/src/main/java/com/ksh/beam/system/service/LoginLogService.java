package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.system.entity.sys.LoginLog;

/**
 * 登陆日志
 */
public interface LoginLogService extends IService<LoginLog> {

    IPage<LoginLog> selectPageList(Page page, LoginLog loginLog);

    void  deleteAll();
}
