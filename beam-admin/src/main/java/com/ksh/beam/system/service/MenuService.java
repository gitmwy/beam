package com.ksh.beam.system.service;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.system.entity.sys.Menu;

import java.util.List;
import java.util.Map;

/**
 * 菜单管理
 */
public interface MenuService extends IService<Menu> {

    /**
     * 根据父菜单，查询子菜单
     * @param parentId 父菜单ID
     * @param menuIdList  用户菜单ID
     */
    List<Map> queryListParentId(Long parentId, List<Long> menuIdList);

    /**
     * 获取该角色的菜单列表
     */
    List<Map> getUserMenuList(Long userId);

    /**
     * 根据父菜单，查询子菜单
     * @param parentId 父菜单ID
     */
    List<Map> queryListParentId(Long parentId);

    /**
     * 获取树形菜单列表
     */
    List<Map> treeMenuList(Long userId, Menu menu);
}
