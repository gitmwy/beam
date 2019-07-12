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

    public Boolean getCaptchaOpen() {
        return captchaOpen;
    }

    public void setCaptchaOpen(Boolean captchaOpen) {
        this.captchaOpen = captchaOpen;
    }
}
