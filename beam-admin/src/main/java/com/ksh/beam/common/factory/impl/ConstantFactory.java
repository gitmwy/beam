package com.ksh.beam.common.factory.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ksh.beam.common.constant.Constant;
import com.ksh.beam.common.factory.IConstantFactory;
import com.ksh.beam.common.utils.SpringContextHolder;
import com.ksh.beam.common.utils.ToolUtil;
import com.ksh.beam.system.dao.DeptMapper;
import com.ksh.beam.system.dao.DictMapper;
import com.ksh.beam.system.dao.MeetingSceneMapper;
import com.ksh.beam.system.dao.MenuMapper;
import com.ksh.beam.system.dao.RoleMapper;
import com.ksh.beam.system.dao.SequenceMapper;
import com.ksh.beam.system.dao.UserMapper;
import com.ksh.beam.system.entity.meeting.Cloud;
import com.ksh.beam.system.entity.sys.Dept;
import com.ksh.beam.system.entity.sys.Dict;
import com.ksh.beam.system.entity.sys.Menu;
import com.ksh.beam.system.entity.sys.Role;
import com.ksh.beam.system.entity.sys.User;
import org.springframework.context.annotation.DependsOn;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 常量的生产工厂
 */
@Component
@DependsOn("springContextHolder")
@Transactional(readOnly = true)
public class ConstantFactory implements IConstantFactory {

    private SequenceMapper sequenceMapper = SpringContextHolder.getBean(SequenceMapper.class);
    private RoleMapper roleMapper = SpringContextHolder.getBean(RoleMapper.class);
    private DeptMapper deptMapper = SpringContextHolder.getBean(DeptMapper.class);
    private UserMapper userMapper = SpringContextHolder.getBean(UserMapper.class);
    private MenuMapper menuMapper = SpringContextHolder.getBean(MenuMapper.class);
    private DictMapper dictMapper = SpringContextHolder.getBean(DictMapper.class);
    private MeetingSceneMapper meetingSceneMapper = SpringContextHolder.getBean(MeetingSceneMapper.class);

    public static IConstantFactory me() {
        return SpringContextHolder.getBean("constantFactory");
    }

    @Override
    public List<Long> getRoleIdsById(Long userId) {
        return userMapper.getRoleIdsById(userId);
    }

    /**
     * 通过角色id获取角色名称
     */
    @Override
    public String getSingleRoleName(Long roleId) {
        if (0 == roleId) {
            return "--";
        }
        Role roleObj = roleMapper.selectById(roleId);
        if (ToolUtil.isNotEmpty(roleObj) && ToolUtil.isNotEmpty(roleObj.getRoleName())) {
            return roleObj.getRoleName();
        }
        return "";
    }

    @Override
    public User getUserByAccount(String account){
        return userMapper.selectOne(new QueryWrapper<User>().lambda().eq(User::getAccount,account));
    }

    /**
     * 获取部门名称
     */
    @Override
    public String getDeptName(Long deptId) {
        Dept dept = deptMapper.selectById(deptId);
        if (ToolUtil.isNotEmpty(dept) && ToolUtil.isNotEmpty(dept.getName())) {
            return dept.getName();
        }
        return "";
    }

    @Override
    public String getDictsByCode(String pcode, String code) {
        QueryWrapper<Dict> queryWrapper = new QueryWrapper<Dict>().eq("code", pcode);
        Dict dict = dictMapper.selectOne(queryWrapper);
        if (dict == null) {
            return "";
        } else {
            QueryWrapper<Dict> wrapper = new QueryWrapper<>();
            wrapper = wrapper.eq("pid", dict.getId());
            List<Dict> dicts = dictMapper.selectList(wrapper);
            for (Dict item : dicts) {
                if (item.getCode() != null && item.getCode().equals(code)) {
                    return item.getName();
                }
            }
            return "";
        }
    }

    @Override
    public List<Dict> getDictListByCode(String pcode) {
        QueryWrapper<Dict> queryWrapper = new QueryWrapper<Dict>().eq("code", pcode);
        Dict dict = dictMapper.selectOne(queryWrapper);
        if (dict == null) {
            return null;
        } else {
            QueryWrapper<Dict> wrapper = new QueryWrapper<>();
            wrapper = wrapper.eq("pid", dict.getId());
            return dictMapper.selectList(wrapper);
        }
    }

    @Override
    public List<String> findPermissionsByUserId(Long userId) {
        List<String> permsList;
        //系统管理员，拥有最高权限
        if(userId == Constant.SUPER_ADMIN){
            List<Menu> menuList = menuMapper.selectList(null);
            permsList = new ArrayList<>(menuList.size());
            for(Menu menu : menuList){
                permsList.add(menu.getPerms());
            }
        }else{
            permsList = userMapper.queryAllPerms(userId);
        }
        return permsList;
    }

    /**
     *获取会议相关视频、照片
     */
    @Override
    public List<Cloud> getScene(Long meetingId, String fileType) {
        QueryWrapper<Cloud> qw = new QueryWrapper<>();
        qw.eq("meeting_id", meetingId);
        qw.eq("file_type", fileType);
        return meetingSceneMapper.selectList(qw);
    }

    /**
     * 获取编号
     */
    @Override
    public String getSequence(String type) {
        if("H".equals(type)){
            return sequenceMapper.getHospitalNum();
        }
        return "";
    }
}
