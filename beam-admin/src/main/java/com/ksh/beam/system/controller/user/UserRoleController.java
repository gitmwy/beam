package com.ksh.beam.system.controller.user;

import com.ksh.beam.common.annotion.SysLog;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.user.Role;
import com.ksh.beam.system.service.UserRoleService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

/**
 * 角色管理
 */
@Api(value = "UserRoleController", tags = {"UserRole接口"})
@RequestMapping("/user/role")
@RestController
public class UserRoleController {

    @Autowired
    private UserRoleService userRoleService;

    @ApiOperation("角色分页")
    @GetMapping(value = "/page/list")
    @RequiresPermissions("user:role:list")
    public R pageList(Role role) {
        return userRoleService.selectPageList(role);
    }

    @ApiOperation("用户所属角色")
    @GetMapping(value = "/userRole")
    public R userRole() {
        return userRoleService.getUserRole();
    }

    @SysLog(value = "角色新增")
    @ApiOperation("角色新增")
    @PostMapping(value = "/add")
    @RequiresPermissions("user:role:add")
    public R add(@RequestBody @Valid Role role) {
        return userRoleService.saveUserArea(role);
    }

    @SysLog(value = "角色删除")
    @ApiOperation("角色删除")
    @PostMapping(value = "/del")
    @RequiresPermissions("user:role:del")
    public R del(@RequestBody Long[] deptIds) {
        Assert.notEmpty(deptIds, "请选择要删除的记录");
        return userRoleService.deleteBatch(deptIds);
    }
}
