package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.dao.UserRoleMapper;
import com.ksh.beam.system.entity.user.UserRole;
import com.ksh.beam.system.service.UserRoleService;
import org.springframework.stereotype.Service;

import java.util.Arrays;

/**
 * 角色管理
 */
@Service
public class UserRoleServiceImpl extends ServiceImpl<UserRoleMapper, UserRole> implements UserRoleService {

    /**
     * 分页
     */
    @Override
    public R selectPageList(UserRole userRole) {
        IPage page = baseMapper.selectPageList(new Page(userRole.getCurrentPage(), userRole.getPageSize()), userRole);
        return R.ok(page);
    }

    @Override
    public R getUserRole() {
        QueryWrapper<UserRole> qw = new QueryWrapper<>();
        qw.orderByAsc("level");
        return R.ok(baseMapper.selectList(qw));
    }

    /**
     * 保存角色
     */
    @Override
    public R saveUserArea(UserRole userRole) {
        this.saveOrUpdate(userRole);
        return R.ok();
    }

    /**
     * 删除角色
     */
    @Override
    public R deleteBatch(Long[] deptIds) {
        this.removeByIds(Arrays.asList(deptIds));
        return R.ok();
    }
}
