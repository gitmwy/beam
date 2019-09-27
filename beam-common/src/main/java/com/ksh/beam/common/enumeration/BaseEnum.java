package com.ksh.beam.common.enumeration;

import lombok.Getter;

import java.util.Arrays;

/**
 * 枚举工具
 */
@Getter
public enum BaseEnum {

    UNKNOWN("unknown", "");

    private String key;
    private String name;

    BaseEnum(String key, String name) {
        this.key = key;
        this.name = name;
    }

    /**
     * 根据Key得到枚举的Value
     */
    public static BaseEnum getEnumType(String key) {
        return Arrays.stream(BaseEnum.values())
                .filter(BaseEnum -> BaseEnum.getKey().equals(key))
                .findAny().orElse(BaseEnum.UNKNOWN);
    }
}
