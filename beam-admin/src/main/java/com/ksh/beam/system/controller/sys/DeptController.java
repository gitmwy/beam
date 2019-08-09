package com.ksh.beam.system.controller.sys;

import com.ksh.beam.common.base.BaseController;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.sys.Dept;
import com.ksh.beam.system.service.DeptService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

/**
 * 企业管理
 */
@Api(value = "DeptController", tags = {"Dept接口"})
@RequestMapping("/sys/dept")
@RestController
public class DeptController extends BaseController {

    @Autowired
    private DeptService deptService;

    @ApiOperation("新增")
    @PostMapping(value = "/add")
    @RequiresPermissions("sys:dept:add")
    public R add(@RequestBody @Valid Dept dept) {
        return deptService.saveDept(dept);
    }

    @ApiOperation("删除")
    @PostMapping(value = "/del")
    @RequiresPermissions("sys:dept:del")
    public R del(@RequestBody Long[] deptIds) {
        Assert.notEmpty(deptIds, "请选择要删除的记录");
        return deptService.deleteBatch(deptIds);
    }

    @ApiOperation(value = "树形企业部门")
    @RequiresPermissions("sys:dept:list")
    @GetMapping("/tree/dept")
    public R treeDept(Dept dept) {
        return deptService.treeDeptList(dept);
    }

    @ApiOperation("编辑")
    @GetMapping(value = "/edit")
    @RequiresPermissions("sys:dept:edit")
    public R edit(@RequestParam(required = false) Long deptId) {
        Assert.notNull(deptId, "请选择要编辑的记录");
        return deptService.getEditInfo(deptId);
    }
}