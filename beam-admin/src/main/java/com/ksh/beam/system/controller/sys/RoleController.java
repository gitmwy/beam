package com.ksh.beam.system.controller.sys;

import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.sys.Role;
import com.ksh.beam.system.service.RoleService;
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
 * 角色
 */
@Api(value = "RoleController", tags = {"Role接口"})
@RestController
@RequestMapping("/sys/role")
public class RoleController {

    @Autowired
    private RoleService roleService;

    @RequiresPermissions("sys:role:list")
    @ApiOperation(value = "分页列表")
    @GetMapping(value = "/page/list")
    public R pageList(Role role) {
        return roleService.selectPageList(role);
    }

    @ApiOperation(value = "列表")
    @GetMapping(value = "/list")
    public R list() {
        return roleService.selectList();
    }

    @RequiresPermissions("sys:role:add")
    @ApiOperation("新增角色")
    @PostMapping(value = "/add")
    public R add(@RequestBody @Valid Role role) {
        return roleService.saveRole(role);
    }

    @RequiresPermissions("sys:role:del")
    @ApiOperation("批量删除用户")
    @PostMapping(value = "/del")
    public R del(@RequestBody Long[] roleIds) {
        Assert.notEmpty(roleIds, "请选择要删除的角色");
        return roleService.deleteRole(roleIds);
    }

    @ApiOperation(value = "获取角色的菜单权限")
    @GetMapping(value = "/menu/list")
    public R menuList(@RequestParam Long roleId) {
        Assert.notNull(roleId, "请选择要配置权限的角色");
        return roleService.getCheckMenuIds(roleId);
    }

    @RequiresPermissions("sys:role:configPerm")
    @ApiOperation("配置菜单权限")
    @PostMapping(value = "/configPerm")
    public R configPerm(@RequestBody Role role) {
        return roleService.saveRoleMenu(role);
    }
}