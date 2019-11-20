package com.ksh.beam.common.utils;

import com.ksh.beam.common.constant.CacheConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.data.redis.core.Cursor;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ScanOptions;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.TimeUnit;

/**
 * Redis工具类
 */
@Component
public class RedisUtil {

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    //shiro在session和redis中时效
    public final static long DEFAULT_EXPIRE = 60 * 60 * 1000;

    /* -------------------String相关操作------------------------- */

    /**
     * 删除
     */
    public void delete(String key) {
        stringRedisTemplate.delete(key);
    }

    /**
     * 设置指定 key 的值
     * expire单位毫秒
     */
    public void set(String key, String value, long expire) {
        if(expire > 0){
            stringRedisTemplate.opsForValue().set(key, value, expire, TimeUnit.MILLISECONDS);
        }else{
            stringRedisTemplate.opsForValue().set(key, value);
        }
    }

    /**
     * 获取指定 key 的值
     */
    public String get(String key) {
        return stringRedisTemplate.opsForValue().get(key);
    }

    /* -------------------RedisTemplate相关操作------------------------- */

    /**
     * 指定缓存失效时间
     */
    public void expire(String key, long expire) {
        redisTemplate.expire(key, expire, TimeUnit.MILLISECONDS);
    }

    /**
     * 判断key是否存在
     */
    public Boolean hasKey(String key) {
        return redisTemplate.hasKey(key);
    }

    /**
     * 删除缓存
     */
    @SuppressWarnings("unchecked")
    public void del(String... key) {
        if (key != null && key.length > 0) {
            if (key.length == 1) {
                redisTemplate.delete(key[0]);
            } else {
                redisTemplate.delete(CollectionUtils.arrayToList(key));
            }
        }
    }

    /**
     * 模糊匹配删除
     */
    public void batchDel(String pattern) {
        Set<String> keys = redisTemplate.keys(pattern);
        redisTemplate.delete(keys);
    }

    /**
     * 普通缓存获取
     */
    public Object getObj(String key) {
        return redisTemplate.opsForValue().get(key);
    }

    /**
     * 普通缓存放入并设置时间
     */
    public void setObj(String key, Object value, long expire) {
        if (expire > 0) {
            redisTemplate.opsForValue().set(key, value, expire, TimeUnit.MILLISECONDS);
        } else {
            redisTemplate.opsForValue().set(key, value);
        }
    }

    /**
     * 使用scan命令 查询某些前缀的key
     */
    public Set<String> scan(String key) {
        return this.redisTemplate.execute((RedisCallback<Set<String>>) connection -> {
            Set<String> binaryKeys = new HashSet<>();
            Cursor<byte[]> cursor = connection.scan(new ScanOptions.ScanOptionsBuilder().match(key).count(1000).build());
            while (cursor.hasNext()) {
                binaryKeys.add(new String(cursor.next()));
            }
            return binaryKeys;
        });
    }

    /**
     * 使用scan命令 查询某些前缀的key 有多少个
     */
    public Long scanSize(String key) {
        return this.redisTemplate.execute((RedisCallback<Long>) connection -> {
            long count = 0L;
            Cursor<byte[]> cursor = connection.scan(ScanOptions.scanOptions().match(key).count(1000).build());
            while (cursor.hasNext()) {
                cursor.next();
                count++;
            }
            return count;
        });
    }

    @CacheEvict(value = {CacheConstant.BEAM_CACHE_KEY_PREFIX}, allEntries = true)
    public void clearCache() {

    }
}
