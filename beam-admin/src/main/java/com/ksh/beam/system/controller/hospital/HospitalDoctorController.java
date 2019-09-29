package com.ksh.beam.system.controller.hospital;

import com.ksh.beam.common.annotion.SysLog;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.hospital.Doctor;
import com.ksh.beam.system.service.HospitalDoctorService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;

/**
 * 医生列表
 */
@Api(value = "HospitalDoctorController", tags = {"HospitalDoctor接口"})
@RequestMapping("/hospital/doctor")
@RestController
public class HospitalDoctorController {

    @Autowired
    private HospitalDoctorService hospitalDoctorService;

    @ApiOperation("医生列表分页")
    @GetMapping(value = "/page/list")
    @RequiresPermissions("hospital:doctor:list")
    public R pageList(Doctor doctor) {
        return hospitalDoctorService.selectPageList(doctor);
    }

    @SysLog(value = "医生列表导出")
    @ApiOperation(value = "医生列表导出")
    @RequiresPermissions("hospital:doctor:export")
    @GetMapping("/export")
    public void export(Doctor doctor, HttpServletResponse response) {
        hospitalDoctorService.exportData(doctor, response);
    }
}
