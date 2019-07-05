package com.hsshy.beam.common.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hsshy.beam.common.entity.SysConfig;
import org.apache.ibatis.annotations.Param;

/**
 * 角色
 */
public interface SysConfigMapper extends BaseMapper<SysConfig> {

    /**
     * 根据key，查询value
     */
    String getByKey(@Param("key") String key);

    /**
     * 根据key，更新value
     */
    int updateValueByKey(@Param("key") String key, @Param("value") String value);
}
