package com.ksh.beam.common.cloud;

import com.aliyun.oss.OSSClient;
import com.ksh.beam.common.exception.BeamException;
import com.qcloud.cos.exception.CosClientException;

import java.io.ByteArrayInputStream;
import java.io.InputStream;

/**
 * 阿里云存储
 */
public class AliyunCloudStorageService extends CloudStorageService {

    private OSSClient ossClient;

    public AliyunCloudStorageService(CloudStorageConfig config){
        this.config = config;
        init();
    }

    private void init(){
        ossClient = new OSSClient(config.getAliyunEndPoint(), config.getAliyunAccessKeyId(), config.getAliyunAccessKeySecret());
    }

    @Override
    public String upload(InputStream inputStream, String path) {
        try {
            ossClient.putObject(config.getAliyunBucketName(), path, inputStream);
        } catch (Exception e){
            throw new BeamException("上传文件失败，请检查配置信息", e);
        }finally {
            ossClient.shutdown();
        }
        return config.getAliyunDomain() + "/" + path;
    }

    @Override
    public String upload(byte[] data) {
        return upload(data, getPath(config.getAliyunPrefix(),""));
    }

    @Override
    public String upload(byte[] data, String path) {
        return upload(new ByteArrayInputStream(data), path);
    }

    @Override
    public String uploadSuffix(byte[] data, String suffix) {
        return upload(data, getPath(config.getAliyunPrefix(), suffix));
    }

    @Override
    public String uploadSuffix(InputStream inputStream, String suffix) {
        return upload(inputStream, getPath(config.getAliyunPrefix(), suffix));
    }

    @Override
    public void delete(String path) {
        try {
            ossClient.deleteObject(config.getAliyunBucketName(), path);
        } catch (CosClientException e) {
            e.printStackTrace();
        } finally {
            ossClient.shutdown();
        }
    }
}
