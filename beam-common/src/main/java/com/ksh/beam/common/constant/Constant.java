package com.ksh.beam.common.constant;

/**
 * 系统常量
 */
public class Constant {

	// 超级管理员ID
	public static final int SUPER_ADMIN = 1;

    /**
	 * 菜单类型
	 */
    public enum MenuType {
        //目录
    	CATALOG(0),
        //菜单
        MENU(1),
        //按钮
        BUTTON(2);

        private int value;

        MenuType(int value) {
            this.value = value;
        }

        public int getValue() {
            return value;
        }
    }

    /**
     * 云服务
     */
    public enum CloudService {
        //阿里云
        ALIYUN(1),
        //腾讯云
        QCLOUD(2);

        private int value;

        CloudService(int value) {
            this.value = value;
        }

        public int getValue() {
            return value;
        }
    }
}
