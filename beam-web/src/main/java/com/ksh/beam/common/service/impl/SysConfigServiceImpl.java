package com.ksh.beam.common.service.impl;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.enumeration.RetEnum;

import com.ksh.beam.common.exception.BeamException;
import com.ksh.beam.common.dao.SysConfigMapper;
import com.ksh.beam.common.entity.SysConfig;
import com.ksh.beam.common.service.ISysConfigService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 系统配置信息表 服务实现类
 */
@Service(value = "sysConfigService")
public class SysConfigServiceImpl extends ServiceImpl<SysConfigMapper, SysConfig> implements ISysConfigService {

    public String getValue(String key, String defaultValue) {
        String value = baseMapper.getByKey(key);
        if (StringUtils.isBlank(value)) {
            return defaultValue;
        }
        return value;
    }

    public <T> T getConfigObject(String key, Class<T> clazz) {
        String value = getValue(key, null);
        if (StringUtils.isNotBlank(value)) {
            return JSON.parseObject(value, clazz);
        }
        try {
            return clazz.newInstance();
        } catch (Exception e) {
            throw new BeamException(RetEnum.ERRORPARAM);
        }
    }

    @Transactional(rollbackFor = Exception.class)
    public void updateValueByKey(String key, String value) {
        baseMapper.updateValueByKey(key, value);
    }
}
