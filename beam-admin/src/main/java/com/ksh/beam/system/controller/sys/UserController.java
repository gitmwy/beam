package com.ksh.beam.system.controller.sys;

import com.ksh.beam.common.base.controller.BaseController;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.dto.ChangePassowdForm;
import com.ksh.beam.system.entity.sys.User;
import com.ksh.beam.system.service.UserService;
import com.ksh.beam.system.wrapper.UserWrapper;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

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
        return R.ok(new UserWrapper(userService.selectPageList(user)).wrap());
    }

    @ApiOperation("改变状态,是否可用")
    @PostMapping(value = "/change/status/{flag}")
    public R changeStatus(@RequestBody Long userId, @PathVariable Integer flag) {
        return userService.changeStatus(userId, flag);
    }

    @ApiOperation("新增用户")
    @PostMapping(value = "/add")
    @RequiresPermissions("sys:user:add")
    public R add(@RequestBody User user) {
        return userService.saveUser(user);
    }

    @ApiOperation("批量删除用户")
    @PostMapping(value = "/del")
    @RequiresPermissions("sys:user:del")
    public R del(@RequestBody Long[] userIds) {
        return userService.deleteUser(userIds);
    }

    @ApiOperation("编辑")
    @GetMapping(value = "/edit")
    public R edit(@RequestParam Long userId) {
        return userService.editUser(userId);
    }

    @ApiOperation("重置用户密码")
    @PostMapping(value = "/reset/password")
    @RequiresPermissions("sys:user:resetPassword")
    public R resetPassword(@RequestBody Long[] userIds) {
        return userService.resetPassword(userIds);
    }

    @ApiOperation("修改密码")
    @RequiresPermissions("sys:user:changePassword")
    @PostMapping(value = "/change/password")
    public R changePassword(@RequestBody ChangePassowdForm changePassowdForm) {

        return userService.changePassword(changePassowdForm);
    }
}