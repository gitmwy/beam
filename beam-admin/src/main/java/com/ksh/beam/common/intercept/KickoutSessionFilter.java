package com.ksh.beam.common.intercept;

import com.ksh.beam.common.enumeration.RetEnum;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.RenderUtil;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.session.mgt.SessionManager;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.AccessControlFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;
import java.io.Serializable;
import java.util.Deque;

/**
 *访问控制拦截器
 */
public class KickoutSessionFilter extends AccessControlFilter {

    private static final Logger logger = LoggerFactory.getLogger(KickoutSessionFilter.class);

    // 踢出后到的地址
    private String kickoutUrl;
    // 踢出之前登录的/之后登录的用户 默认false踢出之前登录的用户
    private boolean kickoutAfter = false;
    // 同一个帐号最大会话数 默认1
    private int maxSession = 1;
    private SessionManager sessionManager;
    private Cache<String, Deque<Serializable>> cache;

    /**
     * * 表示是否允许访问 ，如果允许访问返回true，否则false；
     * @param mappedValue 表示写在拦截器中括号里面的字符串 mappedValue 就是 [urls] 配置中拦截器参数部分
     * */
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {
        if (isLoginRequest(request, response)) {
            return true;
        } else {
            Subject subject = getSubject(request, response);
            return subject.getPrincipal() != null;
        }
    }

    /**
     * 表示当访问拒绝时是否已经处理了；如果返回true表示需要继续处理；如果返回false表示该拦截器实例已经处理了，将直接返回即可。
     * onAccessDenied是否执行取决于isAccessAllowed的值，如果返回true则onAccessDenied不会执行；如果返回false，执行onAccessDenied
     * 如果onAccessDenied也返回false，则直接返回，不会进入请求的方法（只有isAccessAllowed和onAccessDenied的情况下）
     * */
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response) {
        HttpServletResponse httpServletResponse = WebUtils.toHttp(response);
        RenderUtil.renderJson(httpServletResponse, R.fail(RetEnum.LOGIN_EXPIRED.getRet(),RetEnum.LOGIN_EXPIRED.getMsg()));
        return false;
    }
}
