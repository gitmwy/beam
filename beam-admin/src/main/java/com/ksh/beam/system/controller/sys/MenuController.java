package com.ksh.beam.system.controller.sys;

import com.ksh.beam.common.base.controller.BaseController;
import com.ksh.beam.common.factory.impl.ConstantFactory;
import com.ksh.beam.common.shiro.ShiroUtils;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.sys.Menu;
import com.ksh.beam.system.service.MenuService;
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
 * 菜单管理
 */
@Api(value = "MenuController", tags = {"Menu接口"})
@RestController
@RequestMapping("/sys/menu")
public class MenuController extends BaseController {

    @Autowired
    private MenuService menuService;

    /**
     * 树形菜单
     */
    @ApiOperation(value = "树形菜单")
    @GetMapping("/tree/menu")
    @RequiresPermissions("sys:menu:list")
    public R treeMenu(Menu menu) {
        return R.ok(menuService.treeMenuList(ShiroUtils.getUserId(), menu));
    }

    /**
     * 导航菜单
     */
    @ApiOperation(value = "导航菜单")
    @GetMapping("/nav")
    public R nav() {
        return R.ok(menuService.getUserMenuList(ShiroUtils.getUserId()));
    }

    /**
     * 按钮权限
     */
    @ApiOperation(value = "按钮权限")
    @GetMapping("/button")
    public R button() {
        return R.ok(ConstantFactory.me().findPermissionsByUserId(ShiroUtils.getUserId()));
    }

    @ApiOperation("新增")
    @RequiresPermissions("sys:menu:add")
    @PostMapping(value = "/add")
    public R add(@RequestBody @Valid Menu menu) {
       return menuService.saveMenu(menu);
    }

    @ApiOperation("编辑")
    @GetMapping(value = "/edit")
    @RequiresPermissions("sys:menu:edit")
    public R edit(@RequestParam Long menuId) {
        Assert.notNull(menuId, "请选择要编辑的记录");
       return menuService.getEditInfo(menuId);
    }

    @RequiresPermissions("sys:menu:del")
    @ApiOperation("删除")
    @PostMapping(value = "/del")
    public R del(@RequestBody Long[] menuIds) {
        Assert.notEmpty(menuIds, "请选择要删除的记录");
       return menuService.deleteBatch(menuIds);
    }
}