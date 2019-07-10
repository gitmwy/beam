package com.ksh.beam.common.annotion;

import java.lang.annotation.*;

/**
 * 忽略用户utoken验证
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface IgnoreUTokenAuth {
}
