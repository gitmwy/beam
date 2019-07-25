package com.ksh.beam.system.controller.sys;

import com.ksh.beam.common.base.controller.BaseController;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.sys.OperationLog;
import com.ksh.beam.system.service.OperationLogService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 操作日志
 */
@Api(value = "OperationLogController", tags = {"OperationLog接口"})
@RequestMapping("/sys/operationlog")
@RestController
public class OperationLogController extends BaseController {

    @Autowired
    private OperationLogService operationLogService;

    /**
     * 分页列表
     */
    @ApiOperation("分页列表")
    @GetMapping(value = "/page/list")
    @RequiresPermissions("sys:operationLog:list")
    public R pageList(OperationLog operationLog) {
        return operationLogService.selectPageList(operationLog);
    }

    @ApiOperation("清空")
    @PostMapping(value = "/clear")
    @RequiresPermissions("sys:operationLog:clear")
    public R clear() {
        return operationLogService.deleteAll();
    }
}