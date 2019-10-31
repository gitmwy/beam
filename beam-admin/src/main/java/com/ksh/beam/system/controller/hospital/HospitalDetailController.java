package com.ksh.beam.system.controller.hospital;

import com.ksh.beam.common.annotion.SysLog;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.hospital.Detail;
import com.ksh.beam.system.service.HospitalDetailService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

/**
 * 医院列表
 */
@Api(value = "HospitalDetailController", tags = {"医院列表"})
@RequestMapping("/hospital/detail")
@RestController
public class HospitalDetailController {

    @Autowired
    private HospitalDetailService hospitalDetailService;

    @ApiOperation("医院列表")
    @GetMapping(value = "/page/list")
    @RequiresPermissions("hospital:detail:list")
    public R pageList(Detail hospital) {
        return hospitalDetailService.selectPageList(hospital);
    }

    @SysLog(value = "医院导出")
    @ApiOperation(value = "医院列表导出")
    @RequiresPermissions("hospital:detail:export")
    @GetMapping("/export")
    public void export(Detail hospital, HttpServletResponse response) {
        hospitalDetailService.exportData(hospital, response);
    }

    @SysLog(value = "医院删除")
    @ApiOperation("医院删除")
    @PostMapping(value = "/del")
    @RequiresPermissions("hospital:detail:del")
    public R del(@RequestBody Long[] ids) {
        Assert.notEmpty(ids, "请选择要删除的记录");
        return hospitalDetailService.deleteBatch(ids);
    }

    @SysLog(value = "医院新增")
    @ApiOperation("医院新增")
    @PostMapping(value = "/add")
    @RequiresPermissions("hospital:detail:add")
    public R add(@RequestBody @Valid Detail detail) {
        return hospitalDetailService.saveHospitalDetail(detail);
    }
}
