package com.hsshy.beam.common.shiro;

/**
 * Redis所有Keys
 */
public class RedisKeys {

    public static String getSysConfigKey(String key){
        return "sys:config:" + key;
    }

    static String getShiroSessionKey(String key){
        return "sessionid:" + key;
    }
}
