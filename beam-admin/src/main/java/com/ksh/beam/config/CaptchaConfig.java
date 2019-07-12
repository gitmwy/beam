package com.ksh.beam.config;

import com.google.code.kaptcha.Constants;
import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.google.code.kaptcha.util.Config;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Properties;

/**
 * 生成验证码配置
 */
@Configuration
public class CaptchaConfig {

    @Bean
    public DefaultKaptcha captcha() {
        Properties properties = new Properties();
        // 图片边框
        properties.put(Constants.KAPTCHA_BORDER, "no");
        // 边框颜色
        properties.put(Constants.KAPTCHA_BORDER_COLOR, "105,179,90");
        // 字体颜色
        properties.put(Constants.KAPTCHA_TEXTPRODUCER_FONT_COLOR, "blue");
        // 图片宽
        properties.put(Constants.KAPTCHA_IMAGE_WIDTH, "150");
        // 图片高
        properties.put(Constants.KAPTCHA_IMAGE_HEIGHT, "45");
        // 字体大小
        properties.put(Constants.KAPTCHA_TEXTPRODUCER_FONT_SIZE, "40");
        // session key
        properties.put(Constants.KAPTCHA_SESSION_KEY, "code");
        // 验证码长度
        properties.put(Constants.KAPTCHA_TEXTPRODUCER_CHAR_LENGTH, "4");
        // 字体
        properties.put(Constants.KAPTCHA_TEXTPRODUCER_FONT_NAMES, "宋体,楷体,微软雅黑");
        Config config = new Config(properties);
        DefaultKaptcha defaultKaptcha = new DefaultKaptcha();
        defaultKaptcha.setConfig(config);
        return defaultKaptcha;
    }
}
