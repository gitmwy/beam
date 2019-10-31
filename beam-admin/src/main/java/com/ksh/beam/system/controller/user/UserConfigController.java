package com.ksh.beam.system.controller.user;

import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.service.UserConfigService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 配置管理
 */
@Api(value = "UserConfigController", tags = {"配置管理"})
@RequestMapping("/user/config")
@RestController
public class UserConfigController {

    @Autowired
    private UserConfigService userConfigService;

    @ApiOperation("获取区域级别")
    @GetMapping(value = "/area/level")
    public R areaLevel() {
        return userConfigService.selectAreaLevel();
    }

    @ApiOperation("获取角色级别")
    @GetMapping(value = "/role/level")
    public R roleLevel() {
        return userConfigService.selectRoleLevel();
    }
}
