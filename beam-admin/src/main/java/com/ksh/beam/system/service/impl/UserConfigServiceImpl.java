package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.dao.UserAreaMapper;
import com.ksh.beam.system.dao.UserConfigMapper;
import com.ksh.beam.system.entity.user.UserConfig;
import com.ksh.beam.system.service.UserConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 配置管理
 */
@Service
public class UserConfigServiceImpl extends ServiceImpl<UserConfigMapper, UserConfig> implements UserConfigService {

    @Autowired
    private UserAreaMapper userAreaMapper;

    /**
     * 获取区域级别
     */
    @Override
    public R selectAreaLevel() {
        Integer level = userAreaMapper.getMaxLevel();
        if(null == level){
            level = 0;
        }
        return R.ok(baseMapper.selectLevel(level + 1));
    }

    /**
     * 获取角色级别
     */
    @Override
    public R selectRoleLevel() {
        QueryWrapper<UserConfig> qw = new QueryWrapper<>();
        qw.eq("config_id", 1004);
        qw.eq("status", 1);
        return R.ok(baseMapper.selectList(qw));
    }
}
