package com.ksh.beam.common.shiro;

import com.ksh.beam.common.constant.CacheConstant;
import com.ksh.beam.common.utils.RedisUtil;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.eis.EnterpriseCacheSessionDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.Serializable;

@Component
public class RedisShiroSessionDAO extends EnterpriseCacheSessionDAO {

    @Autowired
    private RedisUtil redisUtil;

    private String getShiroSessionKey(String sessionId) {
        return CacheConstant.BEAM_SESSION_KEY_PREFIX + sessionId;
    }

    //创建session
    @Override
    protected Serializable doCreate(Session session) {
        Serializable sessionId = super.doCreate(session);
        final String key = getShiroSessionKey(sessionId.toString());
        redisUtil.set(key, session, RedisUtil.DEFAULT_EXPIRE);
        return sessionId;
    }

    //获取session
    @Override
    protected Session doReadSession(Serializable sessionId) {
        Session session = super.doReadSession(sessionId);
        if (session == null) {
            final String key = getShiroSessionKey(sessionId.toString());
            session = (Session) redisUtil.get(key);
        }
        return session;
    }

    //更新session
    @Override
    protected void doUpdate(Session session) {
        super.doUpdate(session);
        final String key = getShiroSessionKey(session.getId().toString());
        redisUtil.set(key,  session, RedisUtil.DEFAULT_EXPIRE);
    }

    //删除session
    @Override
    protected void doDelete(Session session) {
        super.doDelete(session);
        final String key = getShiroSessionKey(session.getId().toString());
        redisUtil.del(key);
    }
}
