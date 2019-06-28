package com.hsshy.beam.sys.controller;

import com.hsshy.beam.common.base.controller.BaseController;
import com.hsshy.beam.common.factory.impl.ConstantFactory;
import com.hsshy.beam.common.utils.R;
import com.hsshy.beam.common.utils.ToolUtil;
import com.hsshy.beam.sys.dto.ChangePassowdForm;
import com.hsshy.beam.sys.entity.Dept;
import com.hsshy.beam.sys.entity.User;
import com.hsshy.beam.sys.service.IDeptService;
import com.hsshy.beam.sys.service.IUserService;
import com.hsshy.beam.sys.wrapper.UserWrapper;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 管理员表
 */
@Api(value = "UserController", tags = {"User接口"})
@RequestMapping("/sys/user")
@RestController
public class UserController extends BaseController {

    @Autowired
    private IUserService userService;

    @Autowired
    private IDeptService deptService;

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
    public R del(@RequestBody Long userIds[]) {
        return userService.deleteUser(userIds);
    }

    @ApiOperation("编辑")
    @GetMapping(value = "/edit")
    public R edit(@RequestParam Long userId) {
        User user = userService.getById(userId);
        if (ToolUtil.isEmpty(user)) {
            return R.fail("找不到该用户");
        }
        List<Long> roleIds = ConstantFactory.me().getRoleIdsById(userId);
        user.setRoleIds(roleIds);
        Dept dept = deptService.getById(user.getDeptId());
        if (ToolUtil.isNotEmpty(dept)) {
            user.setDeptName(dept.getName());
        }
        return R.ok(user);
    }

    @ApiOperation("重置用户密码")
    @PostMapping(value = "/reset/password")
    @RequiresPermissions("sys:user:resetPassword")
    public R resetPassword(@RequestBody Long userIds[]) {
        return userService.resetPassword(userIds);
    }

    @ApiOperation("修改密码")
    @RequiresPermissions("sys:user:changePassword")
    @PostMapping(value = "/change/password")
    public R changePassword(@RequestBody ChangePassowdForm changePassowdForm) {

        return userService.changePassword(changePassowdForm);
    }
}