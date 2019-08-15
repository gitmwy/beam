package com.ksh.beam.system.controller.user;

import com.ksh.beam.common.annotion.SysLog;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.ToolUtil;
import com.ksh.beam.system.entity.user.Area;
import com.ksh.beam.system.service.UserAreaService;
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
 * 区域管理
 */
@Api(value = "UserAreaController", tags = {"UserArea接口"})
@RequestMapping("/user/area")
@RestController
public class UserAreaController {

    @Autowired
    private UserAreaService userAreaService;

    @ApiOperation("区域分页")
    @GetMapping(value = "/page/list")
    @RequiresPermissions("user:area:list")
    public R pageList(Area area) {
        return userAreaService.selectPageList(area);
    }

    @SysLog(value = "区域新增")
    @ApiOperation("区域新增")
    @PostMapping(value = "/add")
    @RequiresPermissions("user:area:add")
    public R add(@RequestBody @Valid Area area) {
        if(area.getLevel() > 1 && null == area.getParentId()){
            return R.fail("关联区域不能为空");
        }
        if(ToolUtil.isNotEmpty(area.getId()) && area.getId().equals(area.getParentId())){
            return R.fail("不能选择关联区域为当前编辑区域");
        }
        return userAreaService.saveUserArea(area);
    }

    @ApiOperation("关联区域")
    @GetMapping(value = "/options")
    public R options(@RequestParam(required = false) Integer level) {
        Assert.notNull(level, "请先选择区域等级");
        return userAreaService.getOptions(level);
    }

    @ApiOperation("用户所属区域")
    @GetMapping(value = "/userArea")
    public R userArea() {
        return userAreaService.getUserArea();
    }

    @SysLog(value = "区域删除")
    @ApiOperation("区域删除")
    @PostMapping(value = "/del")
    @RequiresPermissions("user:area:del")
    public R del(@RequestBody Long[] ids) {
        Assert.notEmpty(ids, "请选择要删除的记录");
        return userAreaService.deleteBatch(ids);
    }
}
