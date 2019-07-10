package com.ksh.beam.common.util;

import com.ksh.beam.common.utils.SpringContextHolder;
import com.ksh.beam.config.properties.BeamAdminProperties;

/**
 * 验证码工具类
 */
public class KaptchaUtil {

    private boolean kaptchaOnOff;

    public KaptchaUtil(){
        this.kaptchaOnOff = SpringContextHolder.getBean(BeamAdminProperties.class).getKaptchaOpen();
    }

    public boolean isKaptchaOnOff() {
        return kaptchaOnOff;
    }
}