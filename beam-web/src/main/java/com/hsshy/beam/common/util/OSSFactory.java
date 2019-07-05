package com.hsshy.beam.common.util;

import com.hsshy.beam.common.cloud.*;
import com.hsshy.beam.common.constant.Constant;
import com.hsshy.beam.common.utils.SpringContextHolder;
import com.hsshy.beam.common.service.ISysConfigService;

/**
 * 文件上传Factory
 */
public final class OSSFactory {

    private static ISysConfigService sysConfigService;

    static {
        OSSFactory.sysConfigService = SpringContextHolder.getBean("sysConfigService");
    }

    public static CloudStorageService build(){
        //获取云存储配置信息
        CloudStorageConfig config = sysConfigService.getConfigObject(ConfigConstant.CLOUD_STORAGE_CONFIG_KEY, CloudStorageConfig.class);

        if(config.getType() == Constant.CloudService.ALIYUN.getValue()){
            return new AliyunCloudStorageService(config);
        }else if(config.getType() == Constant.CloudService.QCLOUD.getValue()){
            return new QcloudCloudStorageService(config);
        }
        return null;
    }
}
