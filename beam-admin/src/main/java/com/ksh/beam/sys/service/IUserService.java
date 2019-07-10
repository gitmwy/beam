package com.ksh.beam.sys.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.ksh.beam.common.base.service.ICommonService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.sys.dto.ChangePassowdForm;
import com.ksh.beam.sys.entity.sys.User;

import java.util.List;
import java.util.Map;

/**
 * 管理员表
 */
public interface IUserService extends ICommonService<User> {

    IPage<Map> selectPageList(User user);

    R saveUser(User user);

    R changeStatus(Long userId, Integer flag);

    R deleteUser(Long userIds[]);

    R resetPassword(Long userIds[]);

    R changePassword(ChangePassowdForm changePassowdForm);

    /**
     * 查询用户的所有菜单ID
     */
    List<Long> queryAllMenuId(Long userId);
}
