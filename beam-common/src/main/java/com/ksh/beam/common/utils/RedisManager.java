package com.ksh.beam.common.utils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.data.redis.core.Cursor;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ScanOptions;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.TimeUnit;

/**
 * Redis工具类
 */
@Component
public class RedisManager {

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    /**  默认过期时长，单位：秒 */
    private final static long DEFAULT_EXPIRE = 60 * 60 * 24;
    /**  不设置过期时长 */
    private final static long NOT_EXPIRE = -1;

    /**
     * 指定缓存失效时间
     * @param key 键
     * @param expire 时间(秒)
     */
    public void expire(String key,long expire){
        redisTemplate.expire(key, expire, TimeUnit.SECONDS);
    }

    /**
     * 判断key是否存在
     * @param key 键
     * @return true 存在 false不存在
     */
    public Boolean hasKey(String key){
        return redisTemplate.hasKey(key);
    }

    /**
     * 删除缓存
     * @param key 可以传一个值 或多个
     */
    @SuppressWarnings("unchecked")
    public void del(String ... key){
        if(key!=null&&key.length>0){
            if(key.length==1){
                redisTemplate.delete(key[0]);
            }else{
                redisTemplate.delete(CollectionUtils.arrayToList(key));
            }
        }
    }

    /**
     * 批量删除key
     */
    public void del(Collection keys){
        redisTemplate.delete(keys);
    }

    /**
     * 普通缓存获取
     * @param key 键
     * @return 值
     */
    public Object get(String key){
        return redisTemplate.opsForValue().get(key);
    }

    /**
     * 普通缓存放入
     * @param key 键
     * @param value 值
     */
    public void set(String key,Object value) {
        set(key, value, DEFAULT_EXPIRE);
    }


    /**
     * 普通缓存放入并设置时间
     * @param key 键
     * @param value 值
     * @param expire 时间(秒) expire要大于0 如果expire小于等于0 将设置无限期
     */
    public void set(String key,Object value,long expire){
        if(expire>0){
            redisTemplate.opsForValue().set(key, value, expire, TimeUnit.SECONDS);
        }else{
            set(key, value);
        }
    }

    /**
     * 使用scan命令 查询某些前缀的key
     */
    public Set<String> scan(String key){
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
     * 用来获取当前session数量,也就是在线用户
     */
    public Long scanSize(String key){
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

    @CacheEvict(value = {"CONSTANT"},allEntries = true)
    public void clearCache() {

    }
}
