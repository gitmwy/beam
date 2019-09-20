package com.ksh.beam.sign.converter;

import lombok.Data;

/**
 * 基础的传输bean
 */
@Data
public class BaseTransferEntity {

    private String object; //base64编码的json字符串
    private String sign; //签名
}
