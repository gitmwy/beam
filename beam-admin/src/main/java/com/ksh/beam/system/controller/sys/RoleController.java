package com.ksh.beam.system.controller.sys;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ksh.beam.common.constant.Constant;
import com.ksh.beam.common.shiro.ShiroUtils;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.sys.Role;
import com.ksh.beam.system.service.RoleService;
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
    public Object pageList(Role role) {
        return R.ok(roleService.selectPageList(role));
    }

    @ApiOperation(value = "列表")
    @GetMapping(value = "/list")
    public Object list() {
        QueryWrapper qw = new QueryWrapper<Role>();
        if(1 != ShiroUtils.getUserId()){
            //非超级管理员
            qw.ne("id", Constant.SUPER_ADMIN);
        }
        return R.ok(roleService.list(qw));
    }

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
    public Object del(@RequestBody Long[] roleIds) {
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