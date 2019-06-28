package com.hsshy.beam.sys.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.hsshy.beam.common.annotion.SysLog;
import com.hsshy.beam.common.utils.R;
import com.hsshy.beam.sys.entity.Role;
import com.hsshy.beam.sys.service.IRoleService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 角色
 */
@Api(value = "RoleController", tags = {"Role接口"})
@RestController
@RequestMapping("/sys/role")
public class RoleController {

    @Autowired
    private IRoleService roleService;

    @RequiresPermissions("sys:role:list")
    @ApiOperation(value = "分页列表")
    @GetMapping(value = "/page/list")
    public Object pageList(Role role) {
        return R.ok(roleService.selectPageList(role));
    }

    @ApiOperation(value = "列表")
    @GetMapping(value = "/list")
    public Object list(Role role) {
        QueryWrapper qw = new QueryWrapper<Role>();
        return R.ok(roleService.list(qw));
    }

    @SysLog(value = "新增角色")
    @RequiresPermissions("sys:role:add")
    @ApiOperation("新增角色")
    @PostMapping(value = "/add")
    public Object add(@RequestBody Role role) {
        roleService.saveOrUpdate(role);
        return R.ok();
    }

    @RequiresPermissions("sys:role:del")
    @ApiOperation("批量删除用户")
    @PostMapping(value = "/del")
    public Object del(@RequestBody Long roleIds[]) {
        return roleService.deleteRole(roleIds);
    }

    @ApiOperation(value = "获取角色的菜单权限")
    @GetMapping(value = "/menu/list")
    public Object roleMenuList(@RequestParam Long roleId) {
        return R.ok(roleService.getCheckMenuIds(roleId));
    }

    @RequiresPermissions("sys:role:configPerm")
    @ApiOperation("配置菜单权限")
    @PostMapping(value = "/configPerm")
    public Object saveMuenPerms(@RequestBody Role role) {
        return roleService.saveMuenPerms(role);
    }
}