package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.sys.LoginLog;

/**
 * 登陆日志
 */
public interface LoginLogService extends IService<LoginLog> {

    R selectPageList(LoginLog loginLog);

    R deleteAll();
}
