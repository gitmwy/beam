package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.file.ExcelManager;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.ToolUtil;
import com.ksh.beam.system.dao.UserDetailMapper;
import com.ksh.beam.system.entity.user.Detail;
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
public class UserDetailServiceImpl extends ServiceImpl<UserDetailMapper, Detail> implements UserDetailService {

    /**
     * 分页
     */
    @Override
    public R selectPageList(Detail detail) {
        IPage page = baseMapper.selectPageList(new Page(detail.getCurrentPage(), detail.getPageSize()), detail);
        return R.ok(page);
    }

    @Override
    public void exportData(Detail detail, HttpServletResponse response) {
        List<Map<String, Object>> list = baseMapper.exportData(detail);
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
    public R deleteBatch(Long[] ids) {
        this.removeByIds(Arrays.asList(ids));
        return R.ok();
    }

    /**
     * 保存用户
     */
    @Override
    public R saveUserDetail(Detail detail) {
        if(ToolUtil.isNotEmpty(detail.getAreaLevel()) && ToolUtil.isNotEmpty(detail.getRoleLevel())
            && !detail.getAreaLevel().equals(detail.getRoleLevel())){
            return R.fail("区域等级和角色等级不一致");
        }
        this.saveOrUpdate(detail);
        return R.ok();
    }

    @Override
    public R changeStatus(Long userId, Integer flag) {
        Detail detail = this.getById(userId);
        Assert.notNull(detail, "找不到用户");
        detail.setStatus(flag);
        if(this.updateById(detail)){
            return R.ok();
        }
        return R.fail();
    }
}
