package com.ksh.beam.config;

import com.ksh.beam.common.config.DefaultFastjsonConfig;
import com.ksh.beam.config.properties.BeamRestProperties;
import com.ksh.beam.interceptor.APIInterceptor;
import com.ksh.beam.sign.converter.WithSignMessageConverter;
import com.ksh.beam.sign.security.DataSecurityAction;
import com.ksh.beam.sign.security.impl.Base64SecurityAction;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @ConditionalOnProperty(prefix = BeamRestProperties.BEAM_REST_PREFIX, name = "auth-open", havingValue = "true", matchIfMissing = true)
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new APIInterceptor()).addPathPatterns("/**");
    }

    @Bean
    @ConditionalOnProperty(prefix = BeamRestProperties.BEAM_REST_PREFIX, name = "sign-open", havingValue = "true", matchIfMissing = true)
    public WithSignMessageConverter withSignMessageConverter() {
        WithSignMessageConverter withSignMessageConverter = new WithSignMessageConverter();
        DefaultFastjsonConfig defaultFastjsonConfig = new DefaultFastjsonConfig();
        withSignMessageConverter.setFastJsonConfig(defaultFastjsonConfig.fastjsonConfig());
        withSignMessageConverter.setSupportedMediaTypes(defaultFastjsonConfig.getSupportedMediaType());
        return withSignMessageConverter;
    }

    @Bean
    public DataSecurityAction dataSecurityAction() {
        return new Base64SecurityAction();
    }
}