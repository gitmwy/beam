package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.dao.LoginLogMapper;
import com.ksh.beam.system.entity.sys.LoginLog;
import com.ksh.beam.system.service.LoginLogService;
import org.springframework.stereotype.Service;

/**
 * 登陆日志
 */
@Service
public class LoginLogServiceImpl extends ServiceImpl<LoginLogMapper, LoginLog> implements LoginLogService {

    @Override
    public R selectPageList(LoginLog loginLog) {
        IPage page = baseMapper.selectPageList(new Page(loginLog.getCurrentPage(), loginLog.getPageSize()), loginLog);
        return R.ok(page);
    }

    @Override
    public R deleteAll() {
        baseMapper.deleteAll();
        return R.ok();
    }
}
