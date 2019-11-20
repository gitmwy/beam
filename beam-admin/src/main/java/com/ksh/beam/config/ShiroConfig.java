package com.ksh.beam.config;

import com.ksh.beam.common.intercept.KickoutSessionFilter;
import com.ksh.beam.common.shiro.RetryLimitHashedCredentialsMatcher;
import com.ksh.beam.common.shiro.ShiroRealm;
import com.ksh.beam.common.shiro.ShiroUtils;
import com.ksh.beam.common.utils.RedisUtil;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.session.mgt.SessionManager;
import org.apache.shiro.spring.LifecycleBeanPostProcessor;
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.session.mgt.DefaultWebSessionManager;
import org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.servlet.Filter;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Shiro配置
 */
@Configuration
public class ShiroConfig {

    //配置会话管理器，设定会话超时及保存
    @Bean
    public SessionManager sessionManager() {
        DefaultWebSessionManager sessionManager = new DefaultWebSessionManager();
        //设置session过期时间为1小时(单位：毫秒)，默认为30分钟
        sessionManager.setGlobalSessionTimeout(RedisUtil.DEFAULT_EXPIRE);
        // 删除无效session
        sessionManager.setDeleteInvalidSessions(true);
        //是否开启定时调度器进行检测过期session 默认为true
        sessionManager.setSessionValidationSchedulerEnabled(true);
        //设置session失效的扫描时间, 清理用户直接关闭浏览器造成的孤立会话(单位：毫秒) 默认为 1个小时
        sessionManager.setSessionValidationInterval(15 * 60 * 1000);
        //取消url 后面的 JSESSIONID
        sessionManager.setSessionIdUrlRewritingEnabled(false);

        return sessionManager;
    }

    //配置密码比较器
    @Bean("credentialsMatcher")
    public RetryLimitHashedCredentialsMatcher retryLimitHashedCredentialsMatcher(){
        RetryLimitHashedCredentialsMatcher retryLimitHashedCredentialsMatcher = new RetryLimitHashedCredentialsMatcher();
        retryLimitHashedCredentialsMatcher.setHashAlgorithmName(ShiroUtils.hashAlgorithmName);
        retryLimitHashedCredentialsMatcher.setHashIterations(ShiroUtils.hashIterations);
        return retryLimitHashedCredentialsMatcher;
    }

    //配置自定义的权限登录器
    @Bean
    public ShiroRealm shiroRealm(){
        ShiroRealm shiroRealm = new ShiroRealm();
        shiroRealm.setCredentialsMatcher(retryLimitHashedCredentialsMatcher());
        return shiroRealm;
    }

    //配置核心安全事务管理器
    @Bean
    public SecurityManager securityManager(ShiroRealm shiroRealm, SessionManager sessionManager) {
        DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
        securityManager.setRealm(shiroRealm);
        securityManager.setSessionManager(sessionManager);
        return securityManager;
    }

    //ShiroFilterFactoryBean 处理拦截资源
    @Bean
    public ShiroFilterFactoryBean shiroFilter(SecurityManager securityManager) {
        ShiroFilterFactoryBean shiroFilter = new ShiroFilterFactoryBean();
        shiroFilter.setSecurityManager(securityManager);
        shiroFilter.setLoginUrl("/login");
        //未授权界面
        shiroFilter.setUnauthorizedUrl("/");

        //自定义限制器
        HashMap<String, Filter> myFilters = new HashMap<>();
        myFilters.put("authc", kickoutSessionFilter());
        shiroFilter.setFilters(myFilters);

        //authc:所有url都必须认证通过才可以访问; anon:所有url都都可以匿名访问
        Map<String, String> filterMap = new LinkedHashMap<>();
        filterMap.put("/swagger/**", "anon");
        filterMap.put("/v2/api-docs", "anon");
        filterMap.put("/swagger-ui.html", "anon");
        filterMap.put("/webjars/**", "anon");
        filterMap.put("/swagger-resources/**", "anon");

        filterMap.put("/login/**", "anon"); //登陆
        filterMap.put("/captcha/**", "anon");  //验证码
        filterMap.put("/global/*", "anon");  //全局路径（错误或者超时）

        filterMap.put("/favicon.ico", "anon");
        filterMap.put("/**", "authc");
        shiroFilter.setFilterChainDefinitionMap(filterMap);

        return shiroFilter;
    }

    //并发登录控制
    @Bean
    public KickoutSessionFilter kickoutSessionFilter(){
        KickoutSessionFilter kickoutSessionFilter = new KickoutSessionFilter();
        //是否踢出后来登录的，默认是false
        kickoutSessionFilter.setKickoutAfter(false);
        //同一个用户最大的会话数，默认1
        kickoutSessionFilter.setMaxSession(1);
        return kickoutSessionFilter;
    }

    //配置Shiro生命周期处理器
    @Bean
    public static LifecycleBeanPostProcessor lifecycleBeanPostProcessor() {
        return new LifecycleBeanPostProcessor();
    }

    @Bean
    public DefaultAdvisorAutoProxyCreator defaultAdvisorAutoProxyCreator() {
        DefaultAdvisorAutoProxyCreator proxyCreator = new DefaultAdvisorAutoProxyCreator();
        proxyCreator.setProxyTargetClass(true);
        return proxyCreator;
    }

    //开启shiro 注解模式，可以在controller中的方法前加上注解，如 @RequiresPermissions("userInfo:add")
    @Bean
    public AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor(SecurityManager securityManager) {
        AuthorizationAttributeSourceAdvisor advisor = new AuthorizationAttributeSourceAdvisor();
        advisor.setSecurityManager(securityManager);
        return advisor;
    }
}
