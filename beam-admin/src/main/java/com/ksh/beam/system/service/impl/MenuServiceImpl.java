package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.constant.Constant;
import com.ksh.beam.common.constant.cache.Cache;
import com.ksh.beam.common.constant.cache.CacheKey;
import com.ksh.beam.common.utils.ToolUtil;
import com.ksh.beam.system.dao.MenuMapper;
import com.ksh.beam.system.entity.sys.Menu;
import com.ksh.beam.system.service.MenuService;
import com.ksh.beam.system.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * 菜单管理
 */
@Service
public class MenuServiceImpl extends ServiceImpl<MenuMapper, Menu> implements MenuService {

    @Autowired
    private UserService userService;

    @Override
    public List<Map> queryListParentId(Long parentId, List<Long> menuIdList) {
        List<Map> menuList = queryListParentId(parentId);
        if (menuIdList == null) {
            return menuList;
        }
        List<Map> userMenuList = new ArrayList<>();
        for (Map menu : menuList) {
            if (menuIdList.contains(menu.get("id"))) {
                userMenuList.add(menu);
            }
        }
        return userMenuList;
    }

    @Override
    public List<Map> queryListParentId(Long parentId) {
        return baseMapper.queryListParentId(parentId);
    }

    @Override
    public List<Map> treeMenuList(Long userId, Menu menu) {
        List<Map> menuList;
        if (ToolUtil.isNotEmpty(menu.getName())) {
            QueryWrapper qw = new QueryWrapper<Map>();
            qw.like("name", menu.getName());
            menuList = this.listMaps(qw);

            //删除重复元素
            List<Map> tempMenuList = new ArrayList<>();
            Iterator<Map> iterator = menuList.iterator();
            for(Map mapOne : menuList){
                while (iterator.hasNext()) {
                    Map mapTwo = iterator.next();
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
        List<Long> menuIdList = userService.queryAllMenuId(userId);
        return getAllMenuTreeList(userId, menuList, menuIdList);
    }

    @Override
    @Cacheable(value = Cache.CONSTANT, key = "'" + CacheKey.USER_ID + "'+#userId")
    public List<Map> getUserMenuList(Long userId) {
        //系统管理员，拥有最高权限
        if (userId == Constant.SUPER_ADMIN) {
            return getAllMenuList(null);
        }
        //用户菜单列表
        List<Long> menuIdList = userService.queryAllMenuId(userId);
        return getAllMenuList(menuIdList);
    }

    /**
     * 获取所有菜单列表
     */
    private List<Map> getAllMenuList(List<Long> menuIdList) {
        //查询根菜单列表
        List<Map> menuList = queryListParentId(0L, menuIdList);
        //递归获取子菜单
        getMenuTreeList(menuList, menuIdList);

        return menuList;
    }

    /**
     * 获取目录和菜单 递归
     */
    private List<Map> getMenuTreeList(List<Map> menuList, List<Long> menuIdList) {
        List<Map> subMenuList = new ArrayList<>();
        for (Map entity : menuList) {
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
    private List<Map> getAllMenuTreeList(Long userId, List<Map> menuList, List<Long> menuIdList) {
        List<Map> subMenuList = new ArrayList<>();
        for (Map entity : menuList) {
            if(Constant.SUPER_ADMIN != userId){
                //非超级管理员
                if(!menuIdList.contains(entity.get("id"))){
                    continue;
                }
            }
            entity.put("children", getAllMenuTreeList(userId, queryListParentId(Long.parseLong(entity.get("id") + "")), menuIdList));
            subMenuList.add(entity);
        }
        return subMenuList;
    }
}
