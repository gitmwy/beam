package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.base.BaseWrapper;
import com.ksh.beam.common.factory.impl.ConstantFactory;
import com.ksh.beam.common.file.ExcelUtil;
import com.ksh.beam.common.utils.DateUtil;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.dao.HospitalDoctorMapper;
import com.ksh.beam.system.entity.hospital.Doctor;
import com.ksh.beam.system.service.HospitalDoctorService;
import com.ksh.beam.system.wrapper.HospitalDoctorWrapper;
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
        return R.ok(new HospitalDoctorWrapper(page).wrap());
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
            map.put("createTime", DateUtil.greenwichTime(map.get("create_time")+""));
            map.put("sexName", ConstantFactory.me().getDictsByCode("sex",map.get("sex")+""));
            list.add(map);
        }
        //定义存放英文字段名和中文字段名的Map
        LinkedHashMap<String, String> fieldMap = new LinkedHashMap<>();
        fieldMap.put("name", "医生姓名");
        fieldMap.put("phone", "手机号");
        fieldMap.put("department", "科室");
        fieldMap.put("position", "职位");
        fieldMap.put("title", "职称");
        fieldMap.put("sexName", "性别");
        fieldMap.put("createTime", "创建日期");
        //导出文件
        ExcelUtil.exportExcel(list, fieldMap, "医生数据", null, response);
    }
}
