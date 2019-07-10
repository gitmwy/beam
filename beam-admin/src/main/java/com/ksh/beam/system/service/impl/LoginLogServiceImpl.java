package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ksh.beam.system.dao.LoginLogMapper;
import com.ksh.beam.system.entity.sys.LoginLog;
import com.ksh.beam.system.service.LoginLogService;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

/**
 * 登陆日志
 */
@Service
public class LoginLogServiceImpl extends ServiceImpl<LoginLogMapper, LoginLog> implements LoginLogService {

    @Override
    public IPage<LoginLog> selectPageList(Page page, LoginLog loginLog) {
        return baseMapper.selectPageList(page,loginLog);
    }

    @Override
    public void deleteAll() {
        baseMapper.deleteAll();
    }
}
