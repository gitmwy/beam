package com.ksh.beam.system.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ksh.beam.system.entity.sys.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 管理员表
 */
@Repository
public interface UserMapper extends BaseMapper<User> {

    IPage<User> selectPageList(Page page, @Param("user") User user);

    /**
     * 查询用户的所有权限
     * @param userId  用户ID
     */
    List<String> queryAllPerms(Long userId);

    /**
     * 查询用户的所有菜单ID
     */
    List<Long> queryAllMenuId(Long userId);


    List<Long> getRoleIdsById(@Param("userId") Long userId);

    void saveUserRole(@Param("user") User user);

    void delURByUserId(Long userId);
}
