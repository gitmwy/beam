package com.ksh.beam.system.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ksh.beam.system.entity.user.Config;

import java.util.List;

/**
 * 配置信息
 */
public interface UserConfigMapper extends BaseMapper<Config> {

    //获取级别信息
    List<Config> selectLevel(Integer level);
}
