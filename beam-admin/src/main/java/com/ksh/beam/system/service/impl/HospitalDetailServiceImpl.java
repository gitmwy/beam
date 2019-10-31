package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.base.BaseWrapper;
import com.ksh.beam.common.factory.impl.ConstantFactory;
import com.ksh.beam.common.file.ExcelUtil;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.dao.HospitalDetailMapper;
import com.ksh.beam.system.entity.hospital.Detail;
import com.ksh.beam.system.service.HospitalDetailService;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 医院列表
 */
@Service
public class HospitalDetailServiceImpl extends ServiceImpl<HospitalDetailMapper, Detail> implements HospitalDetailService {

    /**
     * 分页
     */
    @Override
    public R selectPageList(Detail hospital) {
        IPage<Detail> page = baseMapper.selectPageList(new Page(hospital.getCurrentPage(), hospital.getPageSize()),hospital);
        return R.ok(page);
    }

    /**
     * 导出
     */
    @Override
    public void exportData(Detail hospital, HttpServletResponse response) {
        List<Detail> details = baseMapper.selectPageList(hospital);
        List<Map<String, Object>> list = new ArrayList<>();
        for (Detail detail : details){
            Map<String, Object> map = BaseWrapper.beanToMap(detail);
            list.add(map);
        }
        //定义存放英文字段名和中文字段名的Map
        LinkedHashMap<String, String> fieldMap = new LinkedHashMap<>();
        fieldMap.put("code", "医院编号");
        fieldMap.put("name", "医院名称");
        fieldMap.put("address", "医院地址");
        fieldMap.put("level", "医院级别");
        //导出文件
        ExcelUtil.exportExcel(list, fieldMap, "医院数据", null, response);
    }

    /**
     * 删除医院
     */
    @Override
    public R deleteBatch(Long[] ids) {
        this.removeByIds(Arrays.asList(ids));
        return R.ok();
    }

    /**
     * 保存医院
     */
    @Override
    public R saveHospitalDetail(Detail detail) {
        detail.setCode(ConstantFactory.me().getSequence("H"));
        detail.setAddress(detail.getProvinceName() + detail.getCityName() + detail.getCountyName());
        this.saveOrUpdate(detail);
        return R.ok();
    }
}
