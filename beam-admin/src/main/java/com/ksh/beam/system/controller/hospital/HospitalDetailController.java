package com.ksh.beam.system.controller.hospital;

import com.ksh.beam.common.annotion.SysLog;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.hospital.Detail;
import com.ksh.beam.system.service.HospitalDetailService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;

/**
 * 医院列表
 */
@Api(value = "HospitalDetailController", tags = {"HospitalDetail接口"})
@RequestMapping("/hospital/detail")
@RestController
public class HospitalDetailController {

    @Autowired
    private HospitalDetailService hospitalDetailService;

    @ApiOperation("医院列表分页")
    @GetMapping(value = "/page/list")
    @RequiresPermissions("hospital:detail:list")
    public R pageList(Detail hospital) {
        return hospitalDetailService.selectPageList(hospital);
    }

    @SysLog(value = "医院列表导出")
    @ApiOperation(value = "医院列表导出")
    @RequiresPermissions("hospital:detail:export")
    @GetMapping("/export")
    public void export(Detail hospital, HttpServletResponse response) {
        hospitalDetailService.exportData(hospital, response);
    }
}
