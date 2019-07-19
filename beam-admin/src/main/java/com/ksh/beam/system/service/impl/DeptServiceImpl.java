package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.constant.Constant;
import com.ksh.beam.system.dao.DeptMapper;
import com.ksh.beam.system.entity.sys.Dept;
import com.ksh.beam.system.entity.sys.User;
import com.ksh.beam.system.service.DeptService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * 企业管理
 */
@Service
public class DeptServiceImpl extends ServiceImpl<DeptMapper, Dept> implements DeptService {

    @Override
    public List<Dept> treeDeptList(User user, Dept dept) {
        if(Constant.SUPER_ADMIN != user.getId()){
            //非超级管理员
            dept.setId(user.getCompanyId());
        }else{
            //超级管理员
            if(null == dept.getName()){
                dept.setParentId(0L);
            }
        }
        List<Dept> deptList = baseMapper.queryListByDept(dept);
        return getAllDeptTreeList(deptList);
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

    /**
     *根据子ID查询所有父级
     */
    @Override
    public List<Dept> queryDeptNameById(Long id) {
        return baseMapper.queryDeptNameById(id);
    }
}
