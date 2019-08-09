package com.ksh.beam.system.controller.sys;

import com.ksh.beam.common.base.BaseController;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.dto.ChangePassowdForm;
import com.ksh.beam.system.entity.sys.User;
import com.ksh.beam.system.service.UserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

/**
 * 管理员表
 */
@Api(value = "UserController", tags = {"User接口"})
@RequestMapping("/sys/user")
@RestController
public class UserController extends BaseController {

    @Autowired
    private UserService userService;

    @ApiOperation(value = "分页列表")
    @GetMapping(value = "/page/list")
    @RequiresPermissions("sys:user:list")
    public R pageList(User user) {
        return userService.selectPageList(user);
    }

    @ApiOperation("改变状态,是否可用")
    @PostMapping(value = "/change/status/{flag}")
    public R changeStatus(@RequestBody Long userId, @PathVariable Integer flag) {
        Assert.notNull(userId, "请选择要改变的用户");
        return userService.changeStatus(userId, flag);
    }

    @ApiOperation("新增用户")
    @PostMapping(value = "/add")
    @RequiresPermissions("sys:user:add")
    public R add(@RequestBody @Valid User user) {
        return userService.saveUser(user);
    }

    @ApiOperation("批量删除用户")
    @PostMapping(value = "/del")
    @RequiresPermissions("sys:user:del")
    public R del(@RequestBody Long[] userIds) {
        Assert.notNull(userIds, "请选择要删除的用户");
        return userService.deleteUser(userIds);
    }

    @ApiOperation("编辑")
    @GetMapping(value = "/edit")
    public R edit(@RequestParam(required = false) Long userId) {
        Assert.notNull(userId, "请选择要编辑的用户");
        return userService.editUser(userId);
    }

    @ApiOperation("重置用户密码")
    @PostMapping(value = "/reset/password")
    @RequiresPermissions("sys:user:resetPassword")
    public R resetPassword(@RequestBody Long[] userIds) {
        Assert.notNull(userIds, "请选择要重置密码的用户");
        return userService.resetPassword(userIds);
    }

    @ApiOperation("修改密码")
    @RequiresPermissions("sys:user:changePassword")
    @PostMapping(value = "/change/password")
    public R changePassword(@RequestBody @Valid ChangePassowdForm changePassowdForm) {
        if (!changePassowdForm.getNewPwd().equals(changePassowdForm.getPassword_confirm())) {
            return R.fail("两次密码不一致");
        }
        return userService.changePassword(changePassowdForm);
    }
}