package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.file.ExcelManager;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.dao.UserDetailMapper;
import com.ksh.beam.system.entity.user.UserDetail;
import com.ksh.beam.system.service.UserDetailService;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 用户列表
 */
@Service
public class UserDetailServiceImpl extends ServiceImpl<UserDetailMapper, UserDetail> implements UserDetailService {

    /**
     * 分页
     */
    @Override
    public R selectPageList(UserDetail userDetail) {
        IPage page = baseMapper.selectPageList(new Page(userDetail.getCurrentPage(), userDetail.getPageSize()), userDetail);
        return R.ok(page);
    }

    @Override
    public void exportData(UserDetail userDetail, HttpServletResponse response) {
        List<Map<String, Object>> list = baseMapper.exportData(userDetail);
        //定义存放英文字段名和中文字段名的Map
        LinkedHashMap<String, String> fieldMap = new LinkedHashMap<>();
        fieldMap.put("job_code", "编号");
        fieldMap.put("nickname", "昵称");
        fieldMap.put("username", "姓名");
        fieldMap.put("phone", "手机号");
        fieldMap.put("area_name", "区域名称");
        fieldMap.put("role_name", "角色名称");
        fieldMap.put("status_name", "状态");
        fieldMap.put("bound_time", "绑定时间");
        fieldMap.put("create_time", "创建时间");
        fieldMap.put("update_time", "更新时间");
        //导出文件
        ExcelManager.exportExcel(list, fieldMap, "用户数据", null, response);
    }

    /**
     * 删除用户
     */
    @Override
    public R deleteBatch(Long[] deptIds) {
        this.removeByIds(Arrays.asList(deptIds));
        return R.ok();
    }

    /**
     * 保存用户
     */
    @Override
    public R saveUserDetail(UserDetail userDetail) {
        this.saveOrUpdate(userDetail);
        return R.ok();
    }

    @Override
    public R changeStatus(Long userId, Integer flag) {
        UserDetail userDetail = this.getById(userId);
        Assert.notNull(userDetail, "找不到用户");
        userDetail.setStatus(flag);
        if(this.updateById(userDetail)){
            return R.ok();
        }
        return R.fail();
    }
}
