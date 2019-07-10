package com.ksh.beam.sys.controller.sys;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ksh.beam.common.base.controller.BaseController;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.ToolUtil;
import com.ksh.beam.sys.entity.sys.Dept;
import com.ksh.beam.sys.service.IDeptService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;

/**
 * 部门管理
 */
@Api(value = "DeptController", tags = {"Dept接口"})
@RequestMapping("/sys/dept")
@RestController
public class DeptController extends BaseController {

    @Autowired
    private IDeptService deptService;

    /**
     * 分页列表
     */
    @ApiOperation("分页列表")
    @GetMapping(value = "/page/list")
    public R pageList(Dept dept) {
        QueryWrapper qw = new QueryWrapper<Dept>();
        IPage page = deptService.page(new Page(dept.getCurrentPage(), dept.getPageSize()), qw);
        return R.ok(page);
    }

    @ApiOperation("新增")
    @PostMapping(value = "/add")
    @RequiresPermissions("sys:dept:add")
    public R add(@RequestBody Dept dept) {
        deptService.saveOrUpdate(dept);
        return R.ok();
    }

    @ApiOperation("删除")
    @PostMapping(value = "/del")
    @RequiresPermissions("sys:dept:del")
    public R del(@RequestBody Long deptIds[]) {
        if (ToolUtil.isEmpty(deptIds) || deptIds.length <= 0) {
            return R.fail("未提交要删除的记录");
        }
        deptService.removeByIds(Arrays.asList(deptIds));
        return R.ok();
    }

    /**
     * 树形
     */
    @ApiOperation(value = "树形部门")
    @RequiresPermissions("sys:dept:list")
    @GetMapping("/tree/dept")
    public R treeDept(Dept dept) {
        return R.ok(deptService.treeDeptList(0L, dept));
    }

    @ApiOperation("编辑")
    @GetMapping(value = "/edit")
    @RequiresPermissions("sys:dept:edit")
    public R edit(@RequestParam Long deptId) {
        Dept dept = deptService.getById(deptId);
        if (ToolUtil.isEmpty(dept)) {
            return R.fail("找不到该部门");
        }
        if (dept.getParentId() != 0) {
            Dept pdept = deptService.getById(dept.getParentId());
            dept.setPname(pdept.getName());
        } else {
            dept.setPname("顶级");
        }
        return R.ok(dept);
    }
}