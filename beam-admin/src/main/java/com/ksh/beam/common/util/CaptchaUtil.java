package com.ksh.beam.common.util;

import com.ksh.beam.common.utils.SpringContextHolder;
import com.ksh.beam.config.properties.BeamAdminProperties;

/**
 * 验证码工具类
 */
public class CaptchaUtil {

    private boolean captchaOnOff;

    public CaptchaUtil(){
        this.captchaOnOff = SpringContextHolder.getBean(BeamAdminProperties.class).getCaptchaOpen();
    }

    public boolean isCaptchaOnOff() {
        return captchaOnOff;
    }
}