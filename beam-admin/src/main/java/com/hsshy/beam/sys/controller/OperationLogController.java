package com.hsshy.beam.sys.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hsshy.beam.common.annotion.SysLog;
import com.hsshy.beam.common.base.controller.BaseController;
import com.hsshy.beam.common.utils.R;
import com.hsshy.beam.sys.entity.OperationLog;
import com.hsshy.beam.sys.service.IOperationLogService;
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
    private IOperationLogService operationLogService;

    /**
     * 分页列表
     */
    @ApiOperation("分页列表")
    @GetMapping(value = "/page/list")
    @RequiresPermissions("sys:operationLog:list")
    public R pageList(OperationLog operationLog) {
        IPage page = operationLogService.selectPageList(new Page(operationLog.getCurrentPage(), operationLog.getPageSize()), operationLog);
        return R.ok(page);
    }

    @SysLog(value = "清空日志")
    @ApiOperation("清空")
    @PostMapping(value = "/clear")
    @RequiresPermissions("sys:operationLog:clear")
    public R clear() {
        operationLogService.deleteAll();
        return R.ok();
    }
}