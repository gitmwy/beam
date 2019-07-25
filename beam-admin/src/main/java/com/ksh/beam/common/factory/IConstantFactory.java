package com.ksh.beam.common.factory;

import com.ksh.beam.system.entity.sys.Dept;
import com.ksh.beam.system.entity.sys.Dict;

import java.util.List;

public interface IConstantFactory {
    //根据用户ID获取其所有角色ID
    List<Long> getRoleIdsById(Long userId);

    //通过角色id获取角色名称
    String getSingleRoleName(Long roleId);

    //获取部门名称
    String getDeptName(Long deptId);

    //根据父级字典code和获取字典名称
    String getDictsByCode(String pcode, String code);

    //根据父级字典code和获取字典名称
    List<Dict> getDictListByCode(String pcode);

    //根据子ID查询所有父级
    List<Dept> queryDeptNameById(Long deptId);
}
