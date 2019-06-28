package com.hsshy.beam.common.enumeration;

/**
 * 返回信息枚举
 */
public enum RetEnum {
    /**
     * 成功
      */
    SUCCESS(200,"成功"),
    /**
     * 失败
     */
    ERROR(400,"失败"),
    /**
     * 禁止访问
     */
    FORBID(403,"禁止访问"),
    /**
     * SIGN签名无效
     */
    ERRORSIGN(401,"无效的签名"),
    /**
     * 参数异常
     */
    ERRORPARAM(1004,"参数异常"),
    /**
     * token过期
     */
    TOKEN_EXPIRED(401,"token过期"),
    /**
     * token验证失败
     */
    TOKEN_ERROR(401,"token验证失败"),
    /**
     * 签名异常
     */
    SIGN_ERROR(401, "签名验证失败"),
    /**
     * session过期
     */
    LOGIN_EXPIRED(-1,"请重新登陆"),
    /**
     * 其他
     */
    INVLIDE_DATE_STRING(400, "输入日期格式不对"),
    /**
     * 其他
     */
    WRITE_ERROR(500, "渲染界面错误"),
    /**
     * 文件上传
     */
    FILE_NOT_FOUND(404, "未找到文件!"),
    FILE_READING_ERROR(500, "文件读取错误!"),
    UPLOAD_ERROR(500,"上传图片出错"),
    /**
    *  服务器异常
    */
    SERVER_EXCEPTION(500,"未知的服务器异常");

    /**
     * 返回信息
     */
    RetEnum(int ret, String msg){
        setRet(ret);
        setMsg(msg);
    }

    /**
     * 获取返回值
     */
    public int getRet() {
        return ret;
    }

    /**
     * 设置返回值
     */
    private void setRet(int ret) {
        this.ret = ret;
    }

    /**
     * 获取返回信息
     */
    public String getMsg() {
        return msg;
    }

    /**
     * 设置返回信息
     */
    private void setMsg(String msg) {
        this.msg = msg;
    }

    /**
     * 返回值
     */  
    private int ret;
    /**
     * 返回信息
     */  
    private String msg;
}
