package com.hsshy.beam.common.cloud;

import com.hsshy.beam.common.exception.BeamException;
import com.qcloud.cos.COSClient;
import com.qcloud.cos.ClientConfig;
import com.qcloud.cos.request.UploadFileRequest;
import com.qcloud.cos.sign.Credentials;
import net.sf.json.JSONObject;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import sun.misc.BASE64Decoder;

import java.io.IOException;
import java.io.InputStream;

/**
 * 腾讯云存储
 */
public class QcloudCloudStorageService extends CloudStorageService {
    private COSClient client;

    public QcloudCloudStorageService(CloudStorageConfig config){
        this.config = config;

        //初始化
        init();
    }

    private void init(){
    	Credentials credentials = new Credentials(config.getQcloudAppId(), config.getQcloudSecretId(),
                config.getQcloudSecretKey());
    	
    	//初始化客户端配置
        ClientConfig clientConfig = new ClientConfig();
        //设置bucket所在的区域，华南：gz 华北：tj 华东：sh
        clientConfig.setRegion(config.getQcloudRegion());
        
    	client = new COSClient(clientConfig, credentials);
    }

    @Override
    public String upload(String pic) throws Exception {
        if(!StringUtils.isBlank(pic) && !pic.contains("http:") && !pic.contains("https:") && !pic.contains("upload")){
            if (pic.indexOf("data:image/jpeg;base64") > -1 || pic.indexOf("data:image/png;base64") > -1){
                pic = pic.substring(pic.indexOf(",") * 1 + 1, pic.length());
            }
            BASE64Decoder decoder = new BASE64Decoder();
            byte[] data = decoder.decodeBuffer(pic);
            for(int i=0;i<data.length;++i){
                if(data[i]<0){ data[i]+=256; }
            }
//            InputStream input = new ByteArrayInputStream(data);
//            OutputStream output = new ByteArrayOutputStream();
//            //图片尺寸不变，压缩图片文件大小outputQuality实现,参数1为最高质量
//            Thumbnails.of(input).scale(1f).outputQuality(0.25f).toOutputStream(output);
            return upload(data);
        }else{
            return pic;
        }
    }

    @Override
    public String upload(byte[] data) {
        return upload(data, getPath(config.getQiniuPrefix(),""));
    }

    @Override
    public String upload(byte[] data, String path) {
        //腾讯云必需要以"/"开头
        if(!path.startsWith("/")) {
            path = "/" + path;
        }
        
        //上传到腾讯云
        UploadFileRequest request = new UploadFileRequest(config.getQcloudBucketName(), path, data);
        String response = client.uploadFile(request);

        JSONObject jsonObject = JSONObject.fromObject(response);
        if(jsonObject.getInt("code") != 0) {
            throw new BeamException("文件上传失败，" + jsonObject.getString("message"));
        }

        return config.getQcloudDomain() + path;
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

    }
}
