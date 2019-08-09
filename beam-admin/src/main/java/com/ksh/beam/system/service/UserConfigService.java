package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.user.UserConfig;

/**
 * 配置信息
 */
public interface UserConfigService extends IService<UserConfig> {

    //获取区域级别
    R selectAreaLevel();

    //获取角色级别
    R selectRoleLevel();
}
