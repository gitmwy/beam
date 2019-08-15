package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.ToolUtil;
import com.ksh.beam.system.dao.UserAreaMapper;
import com.ksh.beam.system.entity.user.Area;
import com.ksh.beam.system.service.UserAreaService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 区域管理
 */
@Service
public class UserAreaServiceImpl extends ServiceImpl<UserAreaMapper, Area> implements UserAreaService {

    /**
     * 分页
     */
    @Override
    public R selectPageList(Area area) {
        IPage page = baseMapper.selectPageList(new Page(area.getCurrentPage(), area.getPageSize()), area);
        return R.ok(page);
    }

    /**
     * 保存区域
     */
    @Override
    public R saveUserArea(Area area) {
        if(ToolUtil.isEmpty(area.getParentId())){
            area.setParentId(0L);
        }
        List<Area> areas = baseMapper.selectList(new QueryWrapper<Area>().eq("id", area.getParentId()));
        if(ToolUtil.isNotEmpty(areas)){
            int poor = area.getLevel() - areas.get(0).getLevel();
            if(poor > 1){
                return R.fail("新建区域级别是" + area.getLevel() + "级，请选择" + (area.getLevel() - 1) + "级的关联区域");
            }
        }
        this.saveOrUpdate(area);
        return R.ok();
    }

    /**
     * 获取可关联的区域
     */
    @Override
    public R getOptions(Integer level) {
        List<Area> areas = baseMapper.getAreaByParentIdAndLevel(1, level, null);
        return R.ok(getAllChildrenArea(areas, level));
    }

    /**
     * 用户所属区域
     */
    @Override
    public R getUserArea() {
        List<Area> areas = baseMapper.getAreaByParentIdAndLevel(null, null, 0L);
        return R.ok(getAllChildrenArea(areas, null));
    }

    /**
     *递归获取子区域
     */
    private List<Area> getAllChildrenArea(List<Area> areas, Integer level){
        List<Area> allAreaList = new ArrayList<>();
        for(Area area : areas){
            area.setChildren(getAllChildrenArea(baseMapper.getAreaByParentIdAndLevel(null, level, area.getId()), level));
            allAreaList.add(area);
        }
        return allAreaList;
    }

    /**
     * 删除区域
     */
    @Override
    public R deleteBatch(Long[] ids) {
        this.removeByIds(Arrays.asList(ids));
        return R.ok();
    }
}
