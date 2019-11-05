package com.ksh.beam.common.constant;

/**
 * 系统常量
 */
public class Constant {

	// 超级管理员ID
	public static final int SUPER_ADMIN = 1;

    /**
     * 云服务
     */
    //阿里云
	public static final int ALIYUN = 1;
    //腾讯云
    public static final int QCLOUD = 2;
    //七牛
    public static final int QINIU = 3;

    /**
     * 云存储目录
     */
    //课件
    public static final String COURSE = "course/";
    //问卷
    public static final String QUESTION = "question/";
    //后台系统用户头像
    public static final String SYS_AVATAR = "sysAvatar/";
    //小程序用户头像
    public static final String USER_AVATAR = "userAvatar/";

    /**
	 * 菜单类型
	 */
    //目录
    public static final int CATALOG = 0;
    //菜单
    public static final int MENU = 1;
    //按钮
    public static final int BUTTON = 2;
}
