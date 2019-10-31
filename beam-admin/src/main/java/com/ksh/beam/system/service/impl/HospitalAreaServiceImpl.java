package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.ToolUtil;
import com.ksh.beam.system.dao.HospitalAreaMapper;
import com.ksh.beam.system.dao.HospitalDetailMapper;
import com.ksh.beam.system.entity.hospital.Area;
import com.ksh.beam.system.entity.hospital.Detail;
import com.ksh.beam.system.service.HospitalAreaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 医院区域管理
 */
@Service
public class HospitalAreaServiceImpl extends ServiceImpl<HospitalAreaMapper, Area> implements HospitalAreaService {

    @Autowired
    private HospitalDetailMapper hospitalDetailMapper;

    /**
     * 树形区域
     */
    @Override
    public R treeAreaList(Area area) {
        if (ToolUtil.isNotEmpty(area.getLevel())) {
            List<Area> areas = baseMapper.selectList(new QueryWrapper<Area>().eq("level", area.getLevel()));
            return R.ok(getAllChildrenArea(areas, null));
        }
        List<Area> areas = baseMapper.selectList(new QueryWrapper<Area>().eq("parent_id", 0L));
        areas = getAllChildrenArea(areas, null);

        List<Area> noOptionAreas = baseMapper.selectList(new QueryWrapper<Area>().isNull("parent_id"));
        noOptionAreas = getAllChildrenArea(noOptionAreas, null);

        areas.addAll(noOptionAreas);
        return R.ok(areas);
    }

    /**
     * 保存区域
     */
    @Override
    public R saveHospitalArea(Area area) {
        if (ToolUtil.isEmpty(area.getParentId())) {
            area.setParentId(0L);
        }
        List<Area> areas = baseMapper.selectList(new QueryWrapper<Area>().eq("id", area.getParentId()));
        if (ToolUtil.isNotEmpty(areas)) {
            int poor = area.getLevel() - areas.get(0).getLevel();
            if (poor > 1) {
                return R.fail("新建区域级别是" + area.getLevel() + "级，请选择" + (area.getLevel() - 1) + "级的关联区域");
            }
        }
        //无关联的区域
        if (ToolUtil.isNotEmpty(area.getOptionStatus()) && 0 == area.getOptionStatus()) {
            List<Area> noOptionAreas = baseMapper.selectList(new QueryWrapper<Area>().eq("parent_id", area.getId()));
            updateChildrenAreas(noOptionAreas, area.getOptionAreas());
        }
        area.setOptionStatus(1);
        this.saveOrUpdate(area);
        return R.ok();
    }

    /**
     * 无关联的区域修改时，递归修改子节点区域
     */
    private void updateChildrenAreas(List<Area> areas, String saveOptionAreas) {
        QueryWrapper<Area> qw = new QueryWrapper<>();
        for (Area area : areas) {
            area.setOptionAreas(saveOptionAreas + "/" + area.getOptionAreas());
            area.setOptionStatus(1);
            this.updateById(area);
            updateChildrenAreas(baseMapper.selectList(qw.eq("parent_id", area.getId())), saveOptionAreas);
        }
    }

    /**
     * 获取可关联的区域
     */
    @Override
    public R getOptions(Integer level) {
        List<Area> areas = baseMapper.getAreaByParentIdAndLevel(level, 0L);
        return R.ok(getAllChildrenArea(areas, level));
    }

    /**
     * 医院所属区域
     */
    @Override
    public R getHospitalArea() {
        List<Area> areas = baseMapper.getAreaByParentIdAndLevel(null, 0L);
        return R.ok(getAllChildrenArea(areas, null));
    }

    /**
     * 递归获取子区域
     */
    private List<Area> getAllChildrenArea(List<Area> areas, Integer level) {
        List<Area> allAreaList = new ArrayList<>();
        for (Area area : areas) {
            area.setChildren(getAllChildrenArea(baseMapper.getAreaByParentIdAndLevel(level, area.getId()), level));
            allAreaList.add(area);
        }
        return allAreaList;
    }

    /**
     * 删除区域
     */
    @Override
    public R deleteBatch(Long[] ids) {
        List<Detail> details = hospitalDetailMapper.selectList(new QueryWrapper<Detail>().in("area_id", Arrays.asList(ids)));
        if (ToolUtil.isNotEmpty(details)) {
            return R.fail("当前删除区域，还有用户关联，请先取消其关联");
        }
        List<Area> areas = baseMapper.selectBatchIds(Arrays.asList(ids));
        for (Area area : areas) {
            List<Area> childrenAreas = baseMapper.selectList(new QueryWrapper<Area>().eq("parent_id", area.getId()));
            for (Area childrenArea : childrenAreas) {
                editChildrenAreas(baseMapper.selectList(new QueryWrapper<Area>().eq("parent_id", childrenArea.getId())), childrenArea.getOptionAreas());
                childrenArea.setParentId(null);
                childrenArea.setOptionStatus(0);
                childrenArea.setOptionAreas("无关联区域");
                this.updateById(childrenArea);
            }
        }
        this.removeByIds(Arrays.asList(ids));
        return R.ok();
    }

    /**
     * 删除父区域后，递归修改子节点的关联区域
     */
    private void editChildrenAreas(List<Area> areas, String delOptionAreas) {
        QueryWrapper<Area> qw = new QueryWrapper<>();
        for (Area area : areas) {
            area.setOptionAreas(area.getOptionAreas().replace(delOptionAreas + "/", ""));
            area.setOptionStatus(0);
            this.updateById(area);
            editChildrenAreas(baseMapper.selectList(qw.eq("parent_id", area.getId())), delOptionAreas);
        }
    }

    /**
     * 获取编辑信息
     */
    @Override
    public R getEditInfo(Long areaId) {
        Area area = baseMapper.selectById(areaId);
        if (ToolUtil.isEmpty(area)) {
            return R.fail("找不到该区域");
        }
        return R.ok(area);
    }
}
