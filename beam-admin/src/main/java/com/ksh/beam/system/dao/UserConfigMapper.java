package com.ksh.beam.system.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ksh.beam.system.entity.user.UserConfig;

import java.util.List;

/**
 * 配置信息
 */
public interface UserConfigMapper extends BaseMapper<UserConfig> {

    //获取级别信息
    List<UserConfig> selectLevel(Integer level);
}
