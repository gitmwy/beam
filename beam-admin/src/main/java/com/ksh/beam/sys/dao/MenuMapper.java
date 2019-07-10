package com.ksh.beam.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ksh.beam.sys.entity.sys.Menu;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 菜单管理
 */
@Repository
public interface MenuMapper extends BaseMapper<Menu> {

    /**
     * 根据父菜单，查询子菜单
     * @param parentId 父菜单ID
     */
    List<Map> queryListParentId(Long parentId);
}
