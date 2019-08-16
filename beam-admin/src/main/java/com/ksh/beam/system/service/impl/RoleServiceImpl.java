package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.constant.Constant;
import com.ksh.beam.common.shiro.ShiroUtils;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.RedisManager;
import com.ksh.beam.common.utils.ToolUtil;
import com.ksh.beam.system.dao.RoleMapper;
import com.ksh.beam.system.entity.sys.Role;
import com.ksh.beam.system.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;

/**
 * 角色
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {

    @Autowired
    private RedisManager redisManager;

    @Override
    public R selectPageList(Role role) {
        if(Constant.SUPER_ADMIN != ShiroUtils.getUserId()){
            //非超级管理员
            role.setAdminRole("1");
        }
        IPage<Role> page = baseMapper.selectPageList(new Page(role.getCurrentPage(),role.getPageSize()),role);
        return R.ok(page);
    }

    @Override
    public R selectList() {
        QueryWrapper<Role> qw = new QueryWrapper<>();
        if(1 != ShiroUtils.getUserId()){
            //非超级管理员
            qw.ne("id", Constant.SUPER_ADMIN);
        }
        return R.ok(this.list(qw));
    }

    @Override
    public R deleteRole(Long[] roleIds) {
        for(Long roleId:roleIds){
            Integer count = baseMapper.getCountByRoleId(roleId);
            if(count>0){
                return R.fail("当前删除角色，还有用户关联，请先取消其关联");
            }
        }
        this.removeByIds(Arrays.asList(roleIds));
        return R.ok();
    }

    @Override
    public R getCheckMenuIds(Long roleId) {
        return R.ok(baseMapper.getCheckMenuIds(roleId));
    }

    @Override
    public R saveRoleMenu(Role role) {
        Role r = this.getById(role.getId());
        if(ToolUtil.isEmpty(r)){
            return R.fail("找不到该角色");
        }
        baseMapper.delMenuPermByRoleId(role.getId());
        //清除缓存
        redisManager.clearCache();

        if(role.getMenuIds().length<=0){
            return R.ok();
        }
        baseMapper.saveRoleMenu(role);

        return R.ok();
    }

    @Override
    public R saveRole(Role role) {
        this.saveOrUpdate(role);
        return R.ok();
    }
}
