package com.ksh.beam.system.controller.user;

import com.ksh.beam.common.annotion.SysLog;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.user.Detail;
import com.ksh.beam.system.service.UserDetailService;
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
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;

/**
 * 用户列表
 */
@Api(value = "UserDetailController", tags = {"UserDetail接口"})
@RequestMapping("/user/detail")
@RestController
public class UserDetailController {

    @Autowired
    private UserDetailService userDetailService;

    @ApiOperation("用户列表分页")
    @GetMapping(value = "/page/list")
    @RequiresPermissions("user:detail:list")
    public R pageList(Detail detail) {
        return userDetailService.selectPageList(detail);
    }

    @SysLog(value = "用户列表导出")
    @ApiOperation(value = "用户列表导出")
    @RequiresPermissions("user:detail:export")
    @GetMapping("/export")
    public void export(Detail detail, HttpServletResponse response) {
        userDetailService.exportData(detail, response);
    }

    @SysLog(value = "用户删除")
    @ApiOperation("用户删除")
    @PostMapping(value = "/del")
    @RequiresPermissions("user:detail:del")
    public R del(@RequestBody Long[] deptIds) {
        Assert.notEmpty(deptIds, "请选择要删除的记录");
        return userDetailService.deleteBatch(deptIds);
    }

    @SysLog(value = "用户新增")
    @ApiOperation("用户新增")
    @PostMapping(value = "/add")
    @RequiresPermissions("user:detail:add")
    public R add(@RequestBody Detail detail) {
        return userDetailService.saveUserDetail(detail);
    }

    @ApiOperation("改变状态,是否可用")
    @PostMapping(value = "/change/status/{flag}")
    public R changeStatus(@RequestBody Long userId, @PathVariable Integer flag) {
        Assert.notNull(userId, "请选择要改变的用户");
        return userDetailService.changeStatus(userId, flag);
    }
}
