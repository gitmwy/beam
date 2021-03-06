package com.ksh.beam.common.util;

import com.ksh.beam.common.cloud.AliyunCloudStorageService;
import com.ksh.beam.common.cloud.CloudStorageConfig;
import com.ksh.beam.common.cloud.CloudStorageService;
import com.ksh.beam.common.cloud.QcloudCloudStorageService;
import com.ksh.beam.common.cloud.QiniuCloudStorageService;
import com.ksh.beam.common.constant.ConfigConstant;
import com.ksh.beam.common.constant.Constant;
import com.ksh.beam.common.file.FtpConfig;
import com.ksh.beam.common.file.FtpService;
import com.ksh.beam.common.file.FtpUtil;
import com.ksh.beam.common.service.ISysConfigService;
import com.ksh.beam.common.utils.SpringContextHolder;

/**
 * 获取配置信息Factory
 */
public final class OSSFactory {

    private static ISysConfigService sysConfigService;

    static {
        OSSFactory.sysConfigService = SpringContextHolder.getBean("sysConfigService");
    }

    /**
     * 云存储
     */
    public static CloudStorageService buildCloud() {
        //获取云存储配置信息
        CloudStorageConfig config = sysConfigService.getConfigObject(ConfigConstant.CLOUD_STORAGE_CONFIG_KEY, CloudStorageConfig.class);

        if (config.getType() == Constant.ALIYUN) {
            return new AliyunCloudStorageService(config);
        } else if (config.getType() == Constant.QCLOUD) {
            return new QcloudCloudStorageService(config);
        }else if (config.getType() == Constant.QINIU) {
            return new QiniuCloudStorageService(config);
        }
        return null;
    }

    /**
     * 获取ftp配置信息
     */
    public static FtpService buildFtp() {
        FtpConfig config = sysConfigService.getConfigObject(ConfigConstant.FTP_CONFIG_KEY, FtpConfig.class);

        return new FtpUtil(config);
    }
}
