package com.ksh.beam.common.cloud;

import com.google.gson.Gson;
import com.ksh.beam.common.exception.BeamException;
import com.qiniu.common.QiniuException;
import com.qiniu.common.Zone;
import com.qiniu.http.Response;
import com.qiniu.storage.BucketManager;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.UploadManager;
import com.qiniu.storage.model.DefaultPutRet;
import com.qiniu.util.Auth;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.InputStream;

public class QiniuCloudStorageService extends CloudStorageService{

    private static final Logger logger = LoggerFactory.getLogger(QiniuCloudStorageService.class);

    private UploadManager uploadManager;
    private BucketManager bucketManager;
    private String token;
    private Auth auth;
    private static final String HTTP = "http://";

    public QiniuCloudStorageService(CloudStorageConfig config) {
        this.config = config;
        init();
    }

    private void init() {
        auth = Auth.create(config.getQiniuAccessKey(), config.getQiniuSecretKey());
        Configuration configuration = new Configuration(Zone.autoZone());
        uploadManager = new UploadManager(configuration);
        bucketManager = new BucketManager(auth, configuration);
        token = auth.uploadToken(config.getQiniuBucketName());
    }

    public String upload(byte[] data, String path) {
        try {
            Response response = uploadManager.put(data, path, token);
            DefaultPutRet putRet = new Gson().fromJson(response.bodyString(), DefaultPutRet.class);
            logger.info("七牛返回json：" + putRet );
            if (!response.isOK()) {
                throw new RuntimeException("上传七牛出错：" + response.toString());
            }
        } catch (Exception e) {
            throw new BeamException("上传文件失败，请核对七牛配置信息", e);
        }
        return HTTP + config.getQiniuDomain() + "/" + path;
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
        return upload(data, getPath(config.getQiniuPrefix(), suffix));
    }

    @Override
    public String uploadSuffix(InputStream inputStream, String suffix) {
        try {
            byte[] data = IOUtils.toByteArray(inputStream);
            return upload(data, getPath(config.getQiniuPrefix(), suffix));
        } catch (IOException e) {
            throw new BeamException("上传文件失败", e);
        }
    }

    @Override
    public void delete(String path) {
        if (path.contains(config.getQiniuDomain())) {
            String key = path.replaceAll(config.getQiniuDomain() + "/", "");
            try {
                //调用delete方法移动文件
                bucketManager.delete(config.getQiniuBucketName(), key);
            } catch (QiniuException e) {
                //捕获异常信息
                Response r = e.response;
                System.out.println(r.toString());
            }
        }
    }

    @Override
    public String getDownloadUrl(String url) {
        return auth.privateDownloadUrl(url);
    }
}
