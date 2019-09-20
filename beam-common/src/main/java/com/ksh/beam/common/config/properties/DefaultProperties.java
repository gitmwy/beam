package com.ksh.beam.common.config.properties;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

/**
 * 默认的配置
 */
@Configuration
@PropertySource("classpath:/default-config.properties")
public class DefaultProperties {

}
