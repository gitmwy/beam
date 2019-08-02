package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.constant.CacheConstant;
import com.ksh.beam.common.constant.Constant;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.RedisManager;
import com.ksh.beam.common.utils.ToolUtil;
import com.ksh.beam.system.dao.MenuMapper;
import com.ksh.beam.system.dao.UserMapper;
import com.ksh.beam.system.entity.sys.Menu;
import com.ksh.beam.system.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * 菜单管理
 */
@Service
public class MenuServiceImpl extends ServiceImpl<MenuMapper, Menu> implements MenuService {

    @Autowired
    private RedisManager redisManager;

    @Autowired
    private UserMapper userMapper;

    @Override
    public List<Map<String, Object>> queryListParentId(Long parentId, List<Long> menuIdList) {
        List<Map<String, Object>> menuList = queryListParentId(parentId);
        if (menuIdList == null) {
            return menuList;
        }
        List<Map<String, Object>> userMenuList = new ArrayList<>();
        for (Map<String, Object> menu : menuList) {
            if (menuIdList.contains(Long.parseLong(menu.get("id") + ""))) {
                userMenuList.add(menu);
            }
        }
        return userMenuList;
    }

    @Override
    public List<Map<String, Object>> queryListParentId(Long parentId) {
        return baseMapper.queryListParentId(parentId);
    }

    @Override
    public List<Map<String, Object>> treeMenuList(Long userId, Menu menu) {
        List<Map<String, Object>> menuList;
        if (ToolUtil.isNotEmpty(menu.getName())) {
            QueryWrapper<Menu> qw = new QueryWrapper<>();
            qw.like("name", menu.getName());
            menuList = this.listMaps(qw);

            //删除重复元素
            List<Map<String, Object>> tempMenuList = new ArrayList<>();
            Iterator<Map<String, Object>> iterator = menuList.iterator();
            for(Map<String, Object> mapOne : menuList){
                while (iterator.hasNext()) {
                    Map<String, Object> mapTwo = iterator.next();
                    if(mapOne.get("id") == mapTwo.get("parentId")){
                        tempMenuList.add(mapTwo);
                    }
                }
            }
            menuList.removeAll(tempMenuList);
        } else {
            menuList = queryListParentId(0L);
        }
        //用户菜单列表
        List<Long> menuIdList = userMapper.queryAllMenuId(userId);
        return getAllMenuTreeList(userId, menuList, menuIdList);
    }

    @Override
    @Cacheable(value = CacheConstant.SHIRO_CACHE_KEY_PREFIX, key = "'" + CacheConstant.USER_MENU + "'+#userId")
    public List<Map<String, Object>> getUserMenuList(Long userId) {
        //系统管理员，拥有最高权限
        if (userId == Constant.SUPER_ADMIN) {
            return getAllMenuList(null);
        }
        //用户菜单列表
        List<Long> menuIdList = userMapper.queryAllMenuId(userId);
        return getAllMenuList(menuIdList);
    }

    /**
     * 获取所有菜单列表
     */
    private List<Map<String, Object>> getAllMenuList(List<Long> menuIdList) {
        //查询根菜单列表
        List<Map<String, Object>> menuList = queryListParentId(0L, menuIdList);
        //递归获取子菜单
        getMenuTreeList(menuList, menuIdList);

        return menuList;
    }

    /**
     * 获取目录和菜单 递归
     */
    private List<Map<String, Object>> getMenuTreeList(List<Map<String, Object>> menuList, List<Long> menuIdList) {
        List<Map<String, Object>> subMenuList = new ArrayList<>();
        for (Map<String, Object> entity : menuList) {
            if (Integer.parseInt(entity.get("type") + "") == Constant.MenuType.CATALOG.getValue()) {
                entity.put("list", getMenuTreeList(queryListParentId(Long.parseLong(entity.get("id") + ""), menuIdList), menuIdList));
            }
            subMenuList.add(entity);
        }
        return subMenuList;
    }

    /**
     * 获取所有菜单 递归
     */
    private List<Map<String, Object>> getAllMenuTreeList(Long userId, List<Map<String, Object>> menuList, List<Long> menuIdList) {
        List<Map<String, Object>> subMenuList = new ArrayList<>();
        for (Map<String, Object> entity : menuList) {
            if(Constant.SUPER_ADMIN != userId){
                //非超级管理员
                if(!menuIdList.contains(Long.parseLong(entity.get("id") + ""))){
                    continue;
                }
            }
            entity.put("children", getAllMenuTreeList(userId, queryListParentId(Long.parseLong(entity.get("id") + "")), menuIdList));
            subMenuList.add(entity);
        }
        return subMenuList;
    }

    @Override
    public R saveMenu(Menu menu) {
        if (ToolUtil.isEmpty(menu.getParentId())) {
            menu.setParentId(0L);
        }
        if (this.saveOrUpdate(menu)) {
            //清除缓存
            redisManager.clearCache();
            return R.ok();
        } else {
            return R.fail();
        }
    }

    @Override
    public R getEditInfo(Long menuId) {
        Menu menu = this.getById(menuId);
        if (ToolUtil.isEmpty(menu)) {
            return R.fail("找不到该菜单");
        }
        if (menu.getParentId() != 0) {
            Menu pmenu = this.getById(menu.getParentId());
            menu.setPname(pmenu.getName());
        } else {
            menu.setPname("顶级");
        }
        return R.ok(menu);
    }

    @Override
    public R deleteBatch(Long[] menuIds) {
        for (Long menuId : menuIds) {
            int count = this.count(new QueryWrapper<Menu>().lambda().eq(Menu::getParentId, menuId));
            if (count > 0) {
                return R.fail("删除失败，请先删除菜单关联的子菜单");
            }
        }
        //清除缓存
        redisManager.clearCache();
        this.removeByIds(Arrays.asList(menuIds));
        return R.ok();
    }
}
