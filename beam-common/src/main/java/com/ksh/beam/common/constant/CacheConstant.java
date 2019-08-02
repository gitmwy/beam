package com.ksh.beam.common.constant;

/**
 * 缓存标识前缀集合
 */
public interface CacheConstant {

    /**
     * 注解Cacheable的value
     */
    String SHIRO_CACHE_KEY_PREFIX = "shiro:cache:";
    /**
     * 菜单信息
     */
    String USER_MENU = "user_menu_";
    /**
     * shiro登陆次数限制
     */
    String SHIRO_RETRYLIMIT_KEY_PREFIX = "shiro:retrylimit:";
    /**
     * 登陆人数访问控制拦截器
     */
    String SHIRO_KICKOUT_KEY_PREFIX = "shiro:kickout:";
    /**
     * shiro的session
     */
    String SHIRO_SESSION_KEY_PREFIX = "shiro:session:";
}
