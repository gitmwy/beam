package com.ksh.beam.common.config;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.ksh.beam.common.constant.CacheConstant;
import com.ksh.beam.common.utils.RedisManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CachingConfigurerSupport;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.cache.RedisCacheConfiguration;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.cache.RedisCacheWriter;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.serializer.Jackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.RedisSerializationContext;

import java.time.Duration;
import java.util.HashMap;
import java.util.Map;

/**
 * Redis配置
 */
@Configuration
@EnableCaching//开启缓存 @Cacheable @CacheEvict @CachePut 并继承CachingConfigurerSupport
public class RedisCacheConfig extends CachingConfigurerSupport {

    @Autowired
    private RedisConnectionFactory factory;

    /**
     * 申明缓存管理器，会创建一个切面（aspect）并触发Spring缓存注解的切点（pointcut）
     * 根据类或者方法所使用的注解以及缓存的状态，这个切面会从缓存中获取数据，将数据添加到缓存之中或者从缓存中移除某个值
     */
    @Bean
    public RedisCacheManager cacheManager() {
        return new RedisCacheManager(
                RedisCacheWriter.nonLockingRedisCacheWriter(factory),
                this.getRedisCacheConfigurationWithTtl(30*60L), // 默认策略，未配置的 key 会使用这个
                this.getRedisCacheConfigurationMap() // 指定 key 策略
        );
    }

    @Bean
    public Jackson2JsonRedisSerializer<Object> jackson2JsonRedisSerializer(){
        Jackson2JsonRedisSerializer<Object> jackson2JsonRedisSerializer = new Jackson2JsonRedisSerializer<>(Object.class);
        ObjectMapper om = new ObjectMapper();
        om.setVisibility(PropertyAccessor.ALL, JsonAutoDetect.Visibility.ANY);
        om.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
        jackson2JsonRedisSerializer.setObjectMapper(om);
        return jackson2JsonRedisSerializer;
    }

    private Map<String, RedisCacheConfiguration> getRedisCacheConfigurationMap() {
        Map<String, RedisCacheConfiguration> redisCacheConfigurationMap = new HashMap<>();
        //SsoCache和BasicDataCache进行过期时间配置
        redisCacheConfigurationMap.put(CacheConstant.SHIRO_CACHE_KEY_PREFIX, this.getRedisCacheConfigurationWithTtl(RedisManager.DEFAULT_EXPIRE));
        return redisCacheConfigurationMap;
    }

    private RedisCacheConfiguration getRedisCacheConfigurationWithTtl(Long seconds) {
        return RedisCacheConfiguration
                .defaultCacheConfig()
                .computePrefixWith(cacheNames -> cacheNames)
                .serializeValuesWith(RedisSerializationContext.SerializationPair.fromSerializer(jackson2JsonRedisSerializer()))
                .entryTtl(Duration.ofSeconds(seconds));
    }
}
