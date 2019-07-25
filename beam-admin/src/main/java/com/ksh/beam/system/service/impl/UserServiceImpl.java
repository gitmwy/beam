package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.constant.Constant;
import com.ksh.beam.common.factory.impl.ConstantFactory;
import com.ksh.beam.common.shiro.ShiroUtils;
import com.ksh.beam.common.util.OSSFactory;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.RedisUtil;
import com.ksh.beam.common.utils.ToolUtil;
import com.ksh.beam.system.dao.UserMapper;
import com.ksh.beam.system.dto.ChangePassowdForm;
import com.ksh.beam.system.entity.sys.Dept;
import com.ksh.beam.system.entity.sys.User;
import com.ksh.beam.system.service.UserService;
import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
import org.springframework.web.multipart.MultipartFile;

import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

/**
 * 管理员表
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Autowired
    private RedisUtil redisUtil;

    @Override
    public R selectPageList(User user) {
        Long userId = ShiroUtils.getUserId();
        if(Constant.SUPER_ADMIN != userId){
            //非超级管理员
            user.setCompanyId(baseMapper.selectById(userId).getCompanyId());
        }
        IPage page = baseMapper.selectPageList(new Page(user.getCurrentPage(), user.getPageSize()), user);
        return R.ok(page);
    }

    @Override
    public R saveUser(User user) {
        //获取公司ID
        List<Dept> depts = ConstantFactory.me().queryDeptNameById(user.getDeptId());
        for(Dept dept : depts){
            if(0 == dept.getParentId()){
                user.setCompanyId(dept.getId());
                break;
            }
        }
        if (ToolUtil.isNotEmpty(user.getId())) {
            if (user.getId() == Constant.SUPER_ADMIN && ShiroUtils.getUserId() != Constant.SUPER_ADMIN) {
                return R.fail("不能修改超级管理员信息");
            }
            User oldUser = this.getById(user.getId());
            Assert.notNull(oldUser, "找不到该用户");
            if (this.updateById(user)) {
                //删除用户关联角色
                baseMapper.delURByUserId(user.getId());
                // 插入用户角色关系
                redisUtil.clearCache();
                if (user.getRoleIds().size() <= 0) {
                    return R.ok();
                } else {
                    baseMapper.saveUserRole(user);
                    return R.ok();
                }
            } else {
                return R.fail("未知原因，保存失败");
            }
        } else {
            String salt = RandomStringUtils.randomAlphanumeric(20);
            user.setSalt(salt);
            user.setPassword(ShiroUtils.sha256("123456", salt));
            if (this.save(user)) {
                return R.ok();
            } else {
                return R.fail("未知原因，保存失败");
            }
        }
    }

    @Override
    public R changeStatus(Long userId, Integer flag) {
        if (userId == Constant.SUPER_ADMIN) {
            return R.fail("不能修改超级管理员的状态");
        }
        User user = this.getById(userId);
        Assert.notNull(user, "找不到用户");
        user.setStatus(flag);
        this.updateById(user);
        return R.ok();
    }

    @Override
    public R deleteUser(Long[] userIds) {
        for (Long userId : userIds) {
            if (userId == Constant.SUPER_ADMIN) {
                return R.fail("管理员不能删除");
            }
        }
        this.removeByIds(Arrays.asList(userIds));
        return R.ok();
    }

    @Override
    public R resetPassword(Long[] userIds) {
        for (Long userId : userIds) {
            if (userId == Constant.SUPER_ADMIN) {
                return R.fail("管理员密码不能重置");
            }
        }
        List<User> userList = this.list(new QueryWrapper<User>().lambda().in(User::getId, userIds));
        Assert.notNull(userList, "找不到用户");
        userList.forEach(user -> {
            String salt = RandomStringUtils.randomAlphanumeric(20);
            user.setSalt(salt);
            user.setPassword(ShiroUtils.sha256("123456", salt));
        });
        this.updateBatchById(userList);
        return R.ok();
    }

    @Override
    public R changePassword(ChangePassowdForm changePassowdForm) {
        if (!changePassowdForm.getNewPwd().equals(changePassowdForm.getPassword_confirm())) {
            return R.fail("两次密码不一致");
        }
        User user = this.getById(ShiroUtils.getUserId());
        Assert.notNull(user, "找不到该用户");
        String old = ShiroUtils.sha256(changePassowdForm.getOldPwd(), user.getSalt());
        if (user.getPassword().equals(old)) {
            String salt = RandomStringUtils.randomAlphanumeric(20);
            user.setSalt(salt);
            user.setPassword(ShiroUtils.sha256(changePassowdForm.getNewPwd(), salt));
            this.updateById(user);
            return R.ok("修改成功");
        } else {
            return R.fail("密码有误");
        }
    }

    @Override
    public List<Long> queryAllMenuId(Long userId) {
        return baseMapper.queryAllMenuId(userId);
    }

    /**
     * 编辑用户
     */
    @Override
    public R editUser(Long userId) {
        User user = baseMapper.selectById(userId);
        if (ToolUtil.isEmpty(user)) {
            return R.fail("找不到该用户");
        }
        List<Long> roleIds = ConstantFactory.me().getRoleIdsById(userId);
        user.setRoleIds(roleIds);

        //获取所在部门
        List<Dept> depts = ConstantFactory.me().queryDeptNameById(user.getDeptId());
        if (depts.size() > 0) {
            StringBuilder deptName = new StringBuilder();
            for(Dept dept : depts){
                deptName.append(dept.getName()).append(">");
            }
            user.setDeptName(deptName.substring(0, deptName.lastIndexOf(">")));
        }
        return R.ok(user);
    }

    @Override
    public R uploadAvatar(MultipartFile file) {
        String fileName = UUID.randomUUID().toString() + "." + ToolUtil.getFileSuffix(file.getOriginalFilename());
        try {
            String url = Objects.requireNonNull(OSSFactory.buildCloud()).upload(file.getBytes(), fileName);
            return R.ok(url);
        } catch (Exception e) {
            e.printStackTrace();
            return R.fail("上传图片失败");
        }
    }
}
