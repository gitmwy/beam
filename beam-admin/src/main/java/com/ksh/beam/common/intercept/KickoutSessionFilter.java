package com.ksh.beam.common.intercept;

import com.ksh.beam.common.constant.CacheConstant;
import com.ksh.beam.common.enumeration.RetEnum;
import com.ksh.beam.common.shiro.ShiroUser;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.RedisManager;
import com.ksh.beam.common.utils.RenderUtil;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.DefaultSessionKey;
import org.apache.shiro.session.mgt.SessionManager;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.AccessControlFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;
import java.io.Serializable;
import java.util.Deque;
import java.util.LinkedList;

/**
 *访问控制拦截器
 */
public class KickoutSessionFilter extends AccessControlFilter {

    private static final Logger logger = LoggerFactory.getLogger(KickoutSessionFilter.class);

    // 踢出之前登录的/之后登录的用户 默认false踢出之前登录的用户
    private boolean kickoutAfter = false;
    // 同一个帐号最大会话数 默认1
    private int maxSession = 1;

    @Autowired
    private RedisManager redisManager;

    @Autowired
    private SessionManager sessionManager;

    public void setKickoutAfter(boolean kickoutAfter){
        this.kickoutAfter = kickoutAfter;
    }

    public void setMaxSession(int maxSession){
        this.maxSession = maxSession;
    }

    private String getRedisKickoutKey(String account) {
        return CacheConstant.SHIRO_KICKOUT_KEY_PREFIX + account;
    }

    /**
     * * 表示是否允许访问 ，如果允许访问返回true，否则false；
     * @param mappedValue 表示写在拦截器中括号里面的字符串 mappedValue 就是 [urls] 配置中拦截器参数部分
     * */
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {
        return false;
    }
    /**
     * 表示当访问拒绝时是否已经处理了；如果返回true表示需要继续处理；如果返回false表示该拦截器实例已经处理了，将直接返回即可。
     * onAccessDenied是否执行取决于isAccessAllowed的值，如果返回true则onAccessDenied不会执行；如果返回false，执行onAccessDenied
     * 如果onAccessDenied也返回false，则直接返回，不会进入请求的方法（只有isAccessAllowed和onAccessDenied的情况下）
     * */
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response) {
        HttpServletResponse httpServletResponse = WebUtils.toHttp(response);
        Subject subject = getSubject(request, response);
        if(isLoginRequest(request, response)){
            return true;
        }else if(!subject.isAuthenticated() && !subject.isRemembered()){
            RenderUtil.renderJson(httpServletResponse, R.fail(RetEnum.LOGIN_EXPIRED.getRet(),RetEnum.LOGIN_EXPIRED.getMsg()));
            return false;
        }

        //获取User实体
        Session session = subject.getSession();
        String account = ((ShiroUser) subject.getPrincipal()).getAccount();
        Serializable sessionId = session.getId();

        // 初始化用户的队列放到缓存里
        Deque<Serializable> deque = (Deque<Serializable>) redisManager.get(getRedisKickoutKey(account));
        if(deque == null || deque.size()==0) {
            deque = new LinkedList<>();
        }

        //如果队列里没有此sessionId，且用户没有被踢出；放入队列
        if(!deque.contains(sessionId) && session.getAttribute("kickout") == null) {
            deque.push(sessionId);
        }

        //如果队列里的sessionId数超出最大会话数，开始踢人
        while(deque.size() > maxSession) {
            Serializable kickoutSessionId;
            if(kickoutAfter) {
                //踢出后者
                kickoutSessionId = deque.removeFirst();
            } else {
                //踢出前者
                kickoutSessionId = deque.removeLast();
            }
            try {
                Session kickoutSession = sessionManager.getSession(new DefaultSessionKey(kickoutSessionId));
                if(kickoutSession != null) {
                    //设置会话的kickout属性表示踢出了
                    kickoutSession.setAttribute("kickout", true);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        redisManager.set(getRedisKickoutKey(account), deque, RedisManager.DEFAULT_EXPIRE);

        //如果被踢出了，直接退出
        if (session.getAttribute("kickout") != null) {
            //会话被踢出了
            subject.logout();
            RenderUtil.renderJson(httpServletResponse, R.fail(RetEnum.LOGIN_EXPIRED.getRet(),RetEnum.LOGIN_EXPIRED.getMsg()));
            return false;
        }
        return true;
    }
}
