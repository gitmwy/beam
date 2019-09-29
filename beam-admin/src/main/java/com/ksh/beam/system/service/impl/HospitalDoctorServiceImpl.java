package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.base.BaseWrapper;
import com.ksh.beam.common.file.ExcelManager;
import com.ksh.beam.common.utils.DateUtil;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.dao.HospitalDoctorMapper;
import com.ksh.beam.system.entity.hospital.Doctor;
import com.ksh.beam.system.service.HospitalDoctorService;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 医生列表
 */
@Service
public class HospitalDoctorServiceImpl extends ServiceImpl<HospitalDoctorMapper, Doctor> implements HospitalDoctorService {

    /**
     * 分页
     */
    @Override
    public R selectPageList(Doctor doctor) {
        IPage<Doctor> page = baseMapper.selectPageList(new Page(doctor.getCurrentPage(), doctor.getPageSize()),doctor);
        return R.ok(page);
    }

    /**
     * 导出
     */
    @Override
    public void exportData(Doctor doctor, HttpServletResponse response) {
        List<Doctor> doctors = baseMapper.selectPageList(doctor);
        List<Map<String, Object>> list = new ArrayList<>();
        for (Doctor temp : doctors){
            Map<String, Object> map = BaseWrapper.beanToMap(temp);
            map.put("regTime", DateUtil.greenwichTime(map.get("regTime")+""));
            list.add(map);
        }
        //定义存放英文字段名和中文字段名的Map
        LinkedHashMap<String, String> fieldMap = new LinkedHashMap<>();
        fieldMap.put("name", "医生姓名");
        fieldMap.put("phone", "手机号");
        fieldMap.put("nickname", "微信昵称");
        fieldMap.put("regTime", "注册日期");
        //导出文件
        ExcelManager.exportExcel(list, fieldMap, "医生数据", null, response);
    }
}
