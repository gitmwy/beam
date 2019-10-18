package com.ksh.beam.common.sign.converter;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.support.spring.FastJsonHttpMessageConverter;
import com.ksh.beam.common.enumeration.RetEnum;
import com.ksh.beam.common.exception.BeamException;
import com.ksh.beam.common.sign.security.DataSecurityAction;
import com.ksh.beam.common.utils.MD5Util;
import com.ksh.beam.common.utils.ReflectionUtils;
import com.ksh.beam.config.properties.BeamRestProperties;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpInputMessage;
import org.springframework.http.converter.HttpMessageNotReadableException;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Type;

/**
 * 带签名的http信息转化器
 */
public class WithSignMessageConverter extends FastJsonHttpMessageConverter {

    private Logger logger = LoggerFactory.getLogger(WithSignMessageConverter.class);

    @Autowired
    BeamRestProperties beamRestProperties;

    @Autowired
    DataSecurityAction dataSecurityAction;

    @Override
    public Object read(Type type, Class<?> contextClass, HttpInputMessage inputMessage) throws IOException, HttpMessageNotReadableException {

        InputStream in = inputMessage.getBody();

        Object obj = JSON.parseObject(in, super.getFastJsonConfig().getCharset(), BaseTransferEntity.class, super.getFastJsonConfig().getFeatures());

        //先转化成原始的对象
        BaseTransferEntity baseTransferEntity = (BaseTransferEntity) obj;

        String object = baseTransferEntity.getObject();
        String json = dataSecurityAction.unlock(object);
        String encrypt = MD5Util.encrypt(object + beamRestProperties.getSecret());

        if (encrypt.equals(baseTransferEntity.getSign())) {
            logger.info("签名校验成功!");
        } else {
            logger.info("签名校验失败,数据被改动过!");
            throw new BeamException(RetEnum.SIGN_ERROR);
        }

        //如果是泛型则将其解析为  获得 Class 定义中声明的父类的泛型参数类型
        if(type.toString().equals("Entity")){
            return JSON.parseObject(json, ReflectionUtils.getSuperGenericType(contextClass));
        } else {
            //校验签名后再转化成应该的对象
            return JSON.parseObject(json, type);
        }
    }
}
