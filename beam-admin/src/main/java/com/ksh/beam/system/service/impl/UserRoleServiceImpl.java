package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.dao.UserRoleMapper;
import com.ksh.beam.system.entity.user.Role;
import com.ksh.beam.system.service.UserRoleService;
import org.springframework.stereotype.Service;

import java.util.Arrays;

/**
 * 角色管理
 */
@Service
public class UserRoleServiceImpl extends ServiceImpl<UserRoleMapper, Role> implements UserRoleService {

    /**
     * 分页
     */
    @Override
    public R selectPageList(Role role) {
        IPage page = baseMapper.selectPageList(new Page(role.getCurrentPage(), role.getPageSize()), role);
        return R.ok(page);
    }

    @Override
    public R getUserRole() {
        QueryWrapper<Role> qw = new QueryWrapper<>();
        qw.orderByAsc("level");
        return R.ok(baseMapper.selectList(qw));
    }

    /**
     * 保存角色
     */
    @Override
    public R saveUserArea(Role role) {
        this.saveOrUpdate(role);
        return R.ok();
    }

    /**
     * 删除角色
     */
    @Override
    public R deleteBatch(Long[] ids) {
        this.removeByIds(Arrays.asList(ids));
        return R.ok();
    }
}
