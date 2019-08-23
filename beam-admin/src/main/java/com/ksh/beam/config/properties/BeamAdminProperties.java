package com.ksh.beam.config.properties;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 项目相关配置
 */
@Component
@ConfigurationProperties(prefix = BeamAdminProperties.BEAM_REST_PREFIX)
public class BeamAdminProperties {

    public static final String BEAM_REST_PREFIX = "beam.admin";

    private Boolean captchaOpen = false;
    private Boolean redisOpen = false;
    private Boolean shiroRedis = false;

    public Boolean getCaptchaOpen() {
        return captchaOpen;
    }

    public void setCaptchaOpen(Boolean captchaOpen) {
        this.captchaOpen = captchaOpen;
    }

    public Boolean getRedisOpen() {
        return redisOpen;
    }

    public void setRedisOpen(Boolean redisOpen) {
        this.redisOpen = redisOpen;
    }

    public Boolean getShiroRedis() {
        return shiroRedis;
    }

    public void setShiroRedis(Boolean shiroRedis) {
        this.shiroRedis = shiroRedis;
    }
}
