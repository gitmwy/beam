package com.ksh.beam.sys.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.sys.entity.sys.LoginLog;

/**
 * 登陆日志
 */
public interface ILoginLogService extends IService<LoginLog> {

    IPage<LoginLog> selectPageList(Page page, LoginLog loginLog);

    void  deleteAll();
}
