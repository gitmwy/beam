package com.ksh.beam.common.config;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;

import java.sql.Timestamp;

/**  自定义填充公共 name 字段  */
@Component
public class MyMetaObjectConfig implements MetaObjectHandler {

    @Override
    public void insertFill(MetaObject metaObject) {
        setFieldValByName("createTime",  new Timestamp(System.currentTimeMillis()), metaObject);
        setFieldValByName("updateTime", new Timestamp(System.currentTimeMillis()), metaObject);
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        setFieldValByName("updateTime", new Timestamp(System.currentTimeMillis()), metaObject);
    }
}