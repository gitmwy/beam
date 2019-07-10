package com.ksh.beam.common.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.entity.SysConfig;

/**
 * 系统配置信息表 服务类
 */
public interface ISysConfigService extends IService<SysConfig> {

     <T> T getConfigObject(String key, Class<T> clazz);

     void updateValueByKey(String key, String value);

     String getValue(String key, String defaultValue) ;
}
