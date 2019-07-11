package com.ksh.beam.system.controller.sys;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ksh.beam.common.base.controller.BaseController;
import com.ksh.beam.common.shiro.IShiro;
import com.ksh.beam.common.shiro.ShiroUtils;
import com.ksh.beam.common.shiro.factory.ShiroFactroy;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.RedisUtil;
import com.ksh.beam.common.utils.ToolUtil;
import com.ksh.beam.system.entity.sys.Menu;
import com.ksh.beam.system.service.MenuService;
import com.ksh.beam.system.wrapper.MenuWrapper;
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

import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * 菜单管理
 */
@Api(value = "MenuController", tags = {"Menu接口"})
@RestController
@RequestMapping("/sys/menu")
public class MenuController extends BaseController {

    @Autowired
    private MenuService menuService;

    @Autowired
    private RedisUtil redisUtil;

    private IShiro shiroFactory = ShiroFactroy.me();

    /**
     * 树形菜单
     */
    @ApiOperation(value = "树形菜单")
    @GetMapping("/tree/menu")
    @RequiresPermissions("sys:menu:list")
    public R treeMenu(Menu menu) {
        return R.ok(menuService.treeMenuList(0L, menu));
    }

    /**
     * 导航菜单
     */
    @ApiOperation(value = "导航菜单")
    @GetMapping("/nav")
    public R nav() {
        List<Map> menuList = menuService.getUserMenuList(ShiroUtils.getUserId());
        return R.ok(menuList);
    }

    /**
     * 按钮权限
     */
    @ApiOperation(value = "按钮权限")
    @GetMapping("/button")
    public R button() {
        return R.ok(shiroFactory.findPermissionsByUserId(ShiroUtils.getUserId()));
    }

    /**
     * 分页列表
     */
    @ApiOperation("分页列表")
    @GetMapping(value = "/page/list")
    public R pageList(Menu menu) {
        QueryWrapper qw = new QueryWrapper<Menu>();
        IPage<Map> page = menuService.page(new Page(menu.getCurrentPage(), menu.getPageSize()), qw);
        return R.ok(new MenuWrapper(page).wrap());
    }

    @ApiOperation("新增")
    @RequiresPermissions("sys:menu:add")
    @PostMapping(value = "/add")
    public R add(@RequestBody Menu menu) {
        if (ToolUtil.isEmpty(menu.getParentId())) {
            menu.setParentId(0L);
        }
        if (menuService.saveOrUpdate(menu)) {
            //清除缓存
            redisUtil.clearCache();
            return R.ok();
        } else {
            return R.fail();
        }
    }

    @ApiOperation("编辑")
    @GetMapping(value = "/edit")
    @RequiresPermissions("sys:menu:edit")
    public R edit(@RequestParam Long menuId) {
        Menu menu = menuService.getById(menuId);
        if (ToolUtil.isEmpty(menu)) {
            return R.fail("找不到该菜单");
        }
        if (menu.getParentId() != 0) {
            Menu pmenu = menuService.getById(menu.getParentId());
            menu.setPname(pmenu.getName());
        } else {
            menu.setPname("顶级");
        }
        return R.ok(menu);
    }

    @RequiresPermissions("sys:menu:del")
    @ApiOperation("删除")
    @PostMapping(value = "/del")
    public R del(@RequestBody Long[] menuIds) {
        if (ToolUtil.isEmpty(menuIds) || menuIds.length <= 0) {
            return R.fail("未提交要删除的记录");
        }
        for (Long menuId : menuIds) {
            int count = menuService.count(new QueryWrapper<Menu>().lambda().eq(Menu::getParentId, menuId));
            if (count > 0) {
                return R.fail("删除失败，请先删除菜单关联的子菜单");
            }
        }
        //清除缓存
        redisUtil.clearCache();
        menuService.removeByIds(Arrays.asList(menuIds));
        return R.ok();
    }
}