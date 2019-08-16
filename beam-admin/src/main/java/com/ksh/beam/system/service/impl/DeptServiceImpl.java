package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.constant.Constant;
import com.ksh.beam.common.shiro.ShiroUtils;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.ToolUtil;
import com.ksh.beam.system.dao.DeptMapper;
import com.ksh.beam.system.dao.UserMapper;
import com.ksh.beam.system.entity.sys.Dept;
import com.ksh.beam.system.entity.sys.User;
import com.ksh.beam.system.service.DeptService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 企业管理
 */
@Service
public class DeptServiceImpl extends ServiceImpl<DeptMapper, Dept> implements DeptService {

    @Autowired
    private UserMapper userMapper;

    /**
     * 获取树形列表
     */
    @Override
    public R treeDeptList(Dept dept) {
        User user = userMapper.selectById(ShiroUtils.getUserId());
        if(Constant.SUPER_ADMIN != user.getId()){
            //非超级管理员
            dept.setId(user.getCompanyId());
        }else{
            //超级管理员
            if(StringUtils.isBlank(dept.getName())){
                dept.setParentId(0L);
            }
        }
        List<Dept> deptList = baseMapper.queryListByDept(dept);
        return R.ok(getAllDeptTreeList(deptList));
    }

    /**
     * 企业树形表格
     */
    private List<Dept> getAllDeptTreeList(List<Dept> deptList){
        List<Dept> subDeptList = new ArrayList<>();
        for(Dept entity : deptList){
            entity.setChildren(getAllDeptTreeList(baseMapper.queryListParentId(entity.getId())));
            subDeptList.add(entity);
        }
        return subDeptList;
    }

    @Override
    public R saveDept(Dept dept) {
        if (ToolUtil.isEmpty(dept.getParentId())) {
            dept.setParentId(0L);
        }
        this.saveOrUpdate(dept);
        return R.ok();
    }

    @Override
    public R deleteBatch(Long[] deptIds) {
        List<Dept> deptList = baseMapper.selectBatchIds(Arrays.asList(deptIds));
        deleteChilren(deptList);
        return R.ok();
    }

    /**
     * 递归删除所有子节点
     */
    private void deleteChilren(List<Dept> deptList){
        for(Dept dept : deptList){
            this.removeById(dept.getId());
            deleteChilren(baseMapper.selectList(new QueryWrapper<Dept>().eq("parent_id", dept.getId())));
        }
    }

    @Override
    public R getEditInfo(Long deptId) {
        Dept dept = this.getById(deptId);
        if (ToolUtil.isEmpty(dept)) {
            return R.fail("找不到该企业部门");
        }
        if (dept.getParentId() != 0) {
            Dept pdept = this.getById(dept.getParentId());
            dept.setPname(pdept.getName());
        } else {
            dept.setPname("顶级");
        }
        return R.ok(dept);
    }
}
