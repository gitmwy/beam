package com.ksh.beam.common.shiro;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ksh.beam.common.constant.CacheConstant;
import com.ksh.beam.common.utils.RedisUtil;
import com.ksh.beam.system.dao.UserMapper;
import com.ksh.beam.system.entity.sys.User;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.concurrent.atomic.AtomicInteger;

/**
 * 登陆次数限制
 */
public class RetryLimitHashedCredentialsMatcher extends HashedCredentialsMatcher {

    private static final Logger logger = LoggerFactory.getLogger(RetryLimitHashedCredentialsMatcher.class);

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private RedisUtil redisUtil;

    private String getRedisRetryLimitKey(String account) {
        return CacheConstant.BEAM_RETRYLIMIT_KEY_PREFIX + account;
    }

    @Override
    public boolean doCredentialsMatch(AuthenticationToken token, AuthenticationInfo info) {

        //获取用户名
        String account = (String) token.getPrincipal();
        //获取用户登录次数
        AtomicInteger retryCount = (AtomicInteger) redisUtil.getObj(getRedisRetryLimitKey(account));
        if (null == retryCount) {
            //如果用户没有登陆过,登陆次数加1 并放入缓存
            retryCount = new AtomicInteger(0);
        }
        if (retryCount.incrementAndGet() > 5) {
            //如果用户登陆失败次数大于5次 抛出锁定用户异常  并修改数据库字段
            User user = userMapper.selectOne(new QueryWrapper<User>().lambda().eq(User::getAccount,account));
            if (null != user && 1 == user.getStatus()) {
                user.setStatus(0);
                userMapper.updateById(user);
                logger.info("锁定用户" + user.getAccount());
                throw new LockedAccountException();
            }
        }
        //判断用户账号和密码是否正确
        boolean matches = super.doCredentialsMatch(token, info);
        if (matches) {
            //如果正确,从缓存中将用户登录计数 清除
            redisUtil.del(getRedisRetryLimitKey(account));
        }else {
            redisUtil.setObj(getRedisRetryLimitKey(account), retryCount, RedisUtil.DEFAULT_EXPIRE);
        }
        return matches;
    }

    /**
     * 根据用户名 解锁用户
     */
    public void unlockAccount(String account){
        User user = userMapper.selectOne(new QueryWrapper<User>().lambda().eq(User::getAccount,account));
        if (user != null){
            user.setStatus(1);
            userMapper.updateById(user);
            redisUtil.del(getRedisRetryLimitKey(account));
        }
    }
}
