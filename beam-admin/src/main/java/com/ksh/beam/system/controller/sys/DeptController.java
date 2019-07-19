package com.ksh.beam.system.controller.sys;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ksh.beam.common.base.controller.BaseController;
import com.ksh.beam.common.shiro.ShiroUtils;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.ToolUtil;
import com.ksh.beam.system.entity.sys.Dept;
import com.ksh.beam.system.entity.sys.User;
import com.ksh.beam.system.service.DeptService;
import com.ksh.beam.system.service.UserService;
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
 * 企业管理
 */
@Api(value = "DeptController", tags = {"Dept接口"})
@RequestMapping("/sys/dept")
@RestController
public class DeptController extends BaseController {

    @Autowired
    private DeptService deptService;

    @Autowired
    private UserService userService;

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
        if (ToolUtil.isEmpty(dept.getParentId())) {
            dept.setParentId(0L);
        }
        deptService.saveOrUpdate(dept);
        return R.ok();
    }

    @ApiOperation("删除")
    @PostMapping(value = "/del")
    @RequiresPermissions("sys:dept:del")
    public R del(@RequestBody Long[] deptIds) {
        if (ToolUtil.isEmpty(deptIds) || deptIds.length <= 0) {
            return R.fail("未提交要删除的记录");
        }
        deptService.removeByIds(Arrays.asList(deptIds));
        return R.ok();
    }

    /**
     * 树形
     */
    @ApiOperation(value = "树形企业部门")
    @RequiresPermissions("sys:dept:list")
    @GetMapping("/tree/dept")
    public R treeDept(Dept dept) {
        User user = userService.getById(ShiroUtils.getUserId());
        return R.ok(deptService.treeDeptList(user, dept));
    }

    @ApiOperation("编辑")
    @GetMapping(value = "/edit")
    @RequiresPermissions("sys:dept:edit")
    public R edit(@RequestParam Long deptId) {
        Dept dept = deptService.getById(deptId);
        if (ToolUtil.isEmpty(dept)) {
            return R.fail("找不到该企业部门");
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