package com.ksh.beam.common.constant;

/**
 * Redis缓存标识前缀集合
 */
public interface CacheConstant {

    /**
     * 注解Cacheable的value
     */
    String BEAM_CACHE_KEY_PREFIX = "beam:cache:";
    /**
     * 菜单信息
     */
    String BEAM_USER_MENU = "beam_user_menu_";
    /**
     * shiro登陆次数限制
     */
    String BEAM_RETRYLIMIT_KEY_PREFIX = "beam:retrylimit:";
    /**
     * 登陆人数访问控制拦截器
     */
    String BEAM_KICKOUT_KEY_PREFIX = "beam:kickout:";
    /**
     * shiro的session
     */
    String BEAM_SESSION_KEY_PREFIX = "beam:session:";
}
