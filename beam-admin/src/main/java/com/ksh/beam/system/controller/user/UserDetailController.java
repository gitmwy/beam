package com.ksh.beam.system.controller.user;

import com.ksh.beam.common.annotion.SysLog;
import com.ksh.beam.common.base.BaseController;
import com.ksh.beam.common.constant.Constant;
import com.ksh.beam.common.util.OSSFactory;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.ToolUtil;
import com.ksh.beam.system.entity.user.User;
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
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.util.Objects;
import java.util.UUID;

/**
 * 用户列表
 */
@Api(value = "UserDetailController", tags = {"用户列表"})
@RequestMapping("/user/detail")
@RestController
public class UserDetailController extends BaseController {

    @Autowired
    private UserDetailService userDetailService;

    @ApiOperation("用户列表分页")
    @GetMapping(value = "/page/list")
    @RequiresPermissions("user:detail:list")
    public R pageList(User user) {
        return userDetailService.selectPageList(user);
    }

    @SysLog(value = "用户列表导出")
    @ApiOperation(value = "用户列表导出")
    @RequiresPermissions("user:detail:export")
    @GetMapping("/export")
    public void export(User user) {
        userDetailService.exportData(user, getHttpServletResponse());
    }

    @SysLog(value = "用户删除")
    @ApiOperation("用户删除")
    @PostMapping(value = "/del")
    @RequiresPermissions("user:detail:del")
    public R del(@RequestBody Long[] ids) {
        Assert.notEmpty(ids, "请选择要删除的记录");
        return userDetailService.deleteBatch(ids);
    }

    @SysLog(value = "用户新增")
    @ApiOperation("用户新增")
    @PostMapping(value = "/add")
    @RequiresPermissions("user:detail:add")
    public R add(@RequestBody @Valid User user) {
        return userDetailService.saveUserDetail(user);
    }

    @ApiOperation("改变状态,是否可用")
    @PostMapping(value = "/change/status/{flag}")
    public R changeStatus(@RequestBody Long userId, @PathVariable Integer flag) {
        Assert.notNull(userId, "请选择要改变的用户");
        return userDetailService.changeStatus(userId, flag);
    }

    @ApiOperation(value = "小程序用户头像上传")
    @PostMapping("/upload")
    public Object upload(@RequestPart("file") MultipartFile file) {
        Assert.notNull(file, "请选择要上传的文件");
        String fileName = Constant.USER_AVATAR + UUID.randomUUID().toString() + "." + ToolUtil.getFileSuffix(file.getOriginalFilename());
        try {
            String url = Objects.requireNonNull(OSSFactory.buildCloud()).upload(file.getBytes(), fileName);
            return R.ok(url);
        } catch (Exception e) {
            e.printStackTrace();
            return R.fail("上传图片失败");
        }
    }
}
