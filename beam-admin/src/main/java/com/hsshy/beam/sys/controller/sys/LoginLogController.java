package com.hsshy.beam.sys.controller.sys;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hsshy.beam.common.annotion.SysLog;
import com.hsshy.beam.common.base.controller.BaseController;
import com.hsshy.beam.common.utils.R;
import com.hsshy.beam.sys.entity.LoginLog;
import com.hsshy.beam.sys.service.ILoginLogService;
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
    private ILoginLogService loginLogService;

    /**
     * 分页列表
     */
    @ApiOperation("分页列表")
    @GetMapping(value = "/page/list")
    @RequiresPermissions("sys:loginLog:list")
    public R pageList(LoginLog loginLog) {
        IPage page = loginLogService.selectPageList(new Page(loginLog.getCurrentPage(), loginLog.getPageSize()), loginLog);
        return R.ok(page);
    }

    @ApiOperation("清空")
    @PostMapping(value = "/clear")
    @RequiresPermissions("sys:loginLog:clear")
    public R clear() {
        loginLogService.deleteAll();
        return R.ok();
    }
}