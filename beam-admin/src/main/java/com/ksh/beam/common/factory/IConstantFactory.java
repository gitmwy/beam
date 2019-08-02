package com.ksh.beam.common.factory;

import com.ksh.beam.system.entity.sys.Dict;
import com.ksh.beam.system.entity.sys.User;

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

     //获取用户权限
    List<String> findPermissionsByUserId(Long userId);

    //获取用户
    User getUserByAccount(String account);
}
