package com.ksh.beam.common.util;

import com.ksh.beam.common.cloud.AliyunCloudStorageService;
import com.ksh.beam.common.cloud.CloudStorageConfig;
import com.ksh.beam.common.cloud.CloudStorageService;
import com.ksh.beam.common.cloud.ConfigConstant;
import com.ksh.beam.common.cloud.QcloudCloudStorageService;
import com.ksh.beam.common.constant.Constant;
import com.ksh.beam.common.service.ISysConfigService;
import com.ksh.beam.common.utils.SpringContextHolder;

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
