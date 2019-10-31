package com.ksh.beam.system.controller.hospital;

import com.ksh.beam.common.annotion.SysLog;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.ToolUtil;
import com.ksh.beam.system.entity.hospital.Area;
import com.ksh.beam.system.service.HospitalAreaService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

/**
 * 医院区域管理
 */
@Api(value = "HospitalAreaController", tags = {"医院区域管理"})
@RequestMapping("/hospital/area")
@RestController
public class HospitalAreaController {

    @Autowired
    private HospitalAreaService hospitalAreaService;

    @ApiOperation("树形区域")
    @GetMapping(value = "/page/list")
    @RequiresPermissions("hospital:area:list")
    public R treeDept(Area area) {
        return hospitalAreaService.treeAreaList(area);
    }

    @SysLog(value = "区域新增")
    @ApiOperation("区域新增")
    @PostMapping(value = "/add")
    @RequiresPermissions("hospital:area:add")
    public R add(@RequestBody @Valid Area area) {
        if(area.getLevel() > 1 && null == area.getParentId()){
            return R.fail("关联区域不能为空");
        }
        if(ToolUtil.isNotEmpty(area.getId()) && area.getId().equals(area.getParentId())){
            return R.fail("不能选择关联区域为当前编辑区域");
        }
        return hospitalAreaService.saveHospitalArea(area);
    }

    @ApiOperation("关联区域")
    @GetMapping(value = "/options")
    public R options(@RequestParam(required = false) Integer level) {
        Assert.notNull(level, "请先选择区域等级");
        return hospitalAreaService.getOptions(level);
    }

    @ApiOperation("医院所属区域")
    @GetMapping(value = "/hospitalArea")
    public R userArea() {
        return hospitalAreaService.getHospitalArea();
    }

    @ApiOperation("编辑")
    @GetMapping(value = "/edit")
    @RequiresPermissions("hospital:area:edit")
    public R edit(@RequestParam(required = false) Long areaId) {
        Assert.notNull(areaId, "请选择要编辑的用户");
        return hospitalAreaService.getEditInfo(areaId);
    }

    @SysLog(value = "区域删除")
    @ApiOperation("区域删除")
    @PostMapping(value = "/del")
    @RequiresPermissions("hospital:area:del")
    public R del(@RequestBody Long[] ids) {
        Assert.notEmpty(ids, "请选择要删除的记录");
        return hospitalAreaService.deleteBatch(ids);
    }
}
