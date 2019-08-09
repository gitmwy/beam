package com.ksh.beam.system.controller.sys;

import com.ksh.beam.common.base.BaseController;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.sys.LoginLog;
import com.ksh.beam.system.service.LoginLogService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 登陆日志
 */
@Api(value = "LoginLogController", tags = {"LoginLog接口"})
@RequestMapping("/sys/loginlog")
@RestController
public class LoginLogController extends BaseController {

    @Autowired
    private LoginLogService loginLogService;

    /**
     * 分页列表
     */
    @ApiOperation("分页列表")
    @GetMapping(value = "/page/list")
    @RequiresPermissions("sys:loginLog:list")
    public R pageList(LoginLog loginLog) {
        return loginLogService.selectPageList(loginLog);
    }

    @ApiOperation("清空")
    @PostMapping(value = "/clear")
    @RequiresPermissions("sys:loginLog:clear")
    public R clear() {
       return loginLogService.deleteAll();
    }
}