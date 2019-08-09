package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.ToolUtil;
import com.ksh.beam.system.dao.UserAreaMapper;
import com.ksh.beam.system.entity.user.UserArea;
import com.ksh.beam.system.service.UserAreaService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 区域管理
 */
@Service
public class UserAreaServiceImpl extends ServiceImpl<UserAreaMapper, UserArea> implements UserAreaService {

    /**
     * 分页
     */
    @Override
    public R selectPageList(UserArea userArea) {
        IPage page = baseMapper.selectPageList(new Page(userArea.getCurrentPage(), userArea.getPageSize()), userArea);
        return R.ok(page);
    }

    /**
     * 保存区域
     */
    @Override
    public R saveUserArea(UserArea userArea) {
        if(ToolUtil.isEmpty(userArea.getParentId())){
            userArea.setParentId(0L);
        }
        List<UserArea> userAreas = baseMapper.selectList(new QueryWrapper<UserArea>().eq("id", userArea.getParentId()));
        if(ToolUtil.isNotEmpty(userAreas)){
            int poor = userArea.getLevel() - userAreas.get(0).getLevel();
            if(poor > 1){
                return R.fail("新建区域级别是" + userArea.getLevel() + "级，请选择" + (userArea.getLevel() - 1) + "级的关联区域");
            }
        }
        this.saveOrUpdate(userArea);
        return R.ok();
    }

    /**
     * 获取可关联的区域
     */
    @Override
    public R getOptions(Integer level) {
        List<UserArea> userAreas = baseMapper.getAreaByParentIdAndLevel(1, level, null);
        return R.ok(getAllChildrenArea(userAreas, level));
    }

    /**
     * 用户所属区域
     */
    @Override
    public R getUserArea() {
        List<UserArea> userAreas = baseMapper.getAreaByParentIdAndLevel(null, null, 0L);
        return R.ok(getAllChildrenArea(userAreas, null));
    }

    /**
     *递归获取子区域
     */
    private List<UserArea> getAllChildrenArea(List<UserArea> userAreas, Integer level){
        List<UserArea> allAreaList = new ArrayList<>();
        for(UserArea userArea : userAreas){
            userArea.setChildren(getAllChildrenArea(baseMapper.getAreaByParentIdAndLevel(null, level, userArea.getId()), level));
            allAreaList.add(userArea);
        }
        return allAreaList;
    }

    /**
     * 删除区域
     */
    @Override
    public R deleteBatch(Long[] deptIds) {
        this.removeByIds(Arrays.asList(deptIds));
        return R.ok();
    }
}
