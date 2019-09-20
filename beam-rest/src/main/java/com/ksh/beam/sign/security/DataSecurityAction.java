package com.ksh.beam.sign.security;

/**
 * 对数据进行base64编码的方式
 */
public interface DataSecurityAction {

    /**
     * 执行数据的保护措施
     */
    String doAction(String beProtected);

    /**
     * 解除保护
     */
    String unlock(String securityCode);
}
