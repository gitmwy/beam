package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.dto.ChangePassowdForm;
import com.ksh.beam.system.entity.sys.User;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * 管理员表
 */
public interface UserService extends IService<User> {

    R selectPageList(User user);

    R saveUser(User user);

    R changeStatus(Long userId, Integer flag);

    R deleteUser(Long[] userIds);

    R resetPassword(Long[] userIds);

    R changePassword(ChangePassowdForm changePassowdForm);

    /**
     * 查询用户的所有菜单ID
     */
    List<Long> queryAllMenuId(Long userId);

    R editUser(Long userId);

    R uploadAvatar(MultipartFile file);
}
