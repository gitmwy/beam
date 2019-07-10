package com.ksh.beam.common.cloud;

import com.ksh.beam.common.exception.BeamException;
import com.qcloud.cos.COSClient;
import com.qcloud.cos.ClientConfig;
import com.qcloud.cos.auth.BasicCOSCredentials;
import com.qcloud.cos.auth.COSCredentials;
import com.qcloud.cos.exception.CosClientException;
import com.qcloud.cos.model.ObjectMetadata;
import com.qcloud.cos.region.Region;
import org.apache.commons.io.IOUtils;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

/**
 * 腾讯云存储
 */
public class QcloudCloudStorageService extends CloudStorageService {

    private static COSClient cosClient = null;

    public QcloudCloudStorageService(CloudStorageConfig config){
        this.config = config;
        init();
    }

    private void init(){
        //初始化用户身份信息
        COSCredentials credentials = new BasicCOSCredentials(config.getQcloudSecretId(), config.getQcloudSecretKey());
        //设置bucket所在的区域
        ClientConfig clientConfig = new ClientConfig(new Region(config.getQcloudRegion()));
        //生成cos客户端
        cosClient = new COSClient(credentials, clientConfig);
    }

    @Override
    public String upload(byte[] data, String path) {
        //腾讯云必需要以"/"开头
        if(!path.startsWith("/")) {
            path = "/" + path;
        }
        //上传到腾讯云
        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentLength(data.length);
        try {
            cosClient.putObject(config.getQcloudBucketName(), path, new ByteArrayInputStream(data), metadata);
        } catch (CosClientException e) {
            throw new BeamException("上传文件失败", e);
        }finally {
            cosClient.shutdown();
        }
        return config.getQcloudDomain() + path;
    }

    @Override
    public String upload(byte[] data) {
        return upload(data, getPath(config.getQcloudPrefix(),""));
    }

    @Override
    public String upload(InputStream inputStream, String path) {
    	try {
            byte[] data = IOUtils.toByteArray(inputStream);
            return this.upload(data, path);
        } catch (IOException e) {
            throw new BeamException("上传文件失败", e);
        }
    }

    @Override
    public String uploadSuffix(byte[] data, String suffix) {
        return upload(data, getPath(config.getQcloudPrefix(), suffix));
    }

    @Override
    public String uploadSuffix(InputStream inputStream, String suffix) {
        return upload(inputStream, getPath(config.getQcloudPrefix(), suffix));
    }

    @Override
    public void delete(String path) {
        try {
            cosClient.deleteObject(config.getQcloudBucketName(), path);
        } catch (CosClientException e) {
            e.printStackTrace();
        } finally {
            cosClient.shutdown();
        }
    }
}
