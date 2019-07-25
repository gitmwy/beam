package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.ToolUtil;
import com.ksh.beam.system.dao.DictMapper;
import com.ksh.beam.system.entity.sys.Dict;
import com.ksh.beam.system.service.DictService;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

/**
 * 字典表
 */
@Service
public class DictServiceImpl extends ServiceImpl<DictMapper, Dict> implements DictService {

    @Override
    public R selectPageList(Dict dict) {
        QueryWrapper<Dict> qw = new QueryWrapper<>();
        if (ToolUtil.isNotEmpty(dict.getPid())) {
            qw.eq("pid", dict.getPid());
        } else {
            qw.eq("pid", 0);
        }
        if (ToolUtil.isNotEmpty(dict.getKeyword())) {
            qw.and(wrapper -> wrapper.like("name", dict.getKeyword()).or().like("code", dict.getKeyword()));
        }
        IPage page = this.page(new Page<>(dict.getCurrentPage(), dict.getPageSize()), qw);
        return R.ok(page);
    }

    @Override
    public R selectList() {
        QueryWrapper<Dict> qw = new QueryWrapper<>();
        qw.eq("pid", 0);
        List<Dict> dictList = this.list(qw);
        return R.ok(dictList);
    }

    @Override
    public R saveDict(Dict dict) {
        Dict old = this.getOne(new QueryWrapper<Dict>().eq("code", dict.getCode()));
        if (ToolUtil.isNotEmpty(old)) {
            if (!old.getId().equals(dict.getId())) {
                return R.fail("编码重复，请换一个编码值");
            }
        }
        this.saveOrUpdate(dict);
        return R.ok();
    }

    @Override
    public R deleteBatch(Long[] dictIds) {
        List<Dict> dictList = (List<Dict>) this.listByIds(Arrays.asList(dictIds));
        for (Dict dict : dictList) {
            int count = this.count(new QueryWrapper<Dict>().eq("pid", dict.getId()));
            if (count > 0) {
                return R.fail("该字典存在子字典，请先删除其子字典！");
            }
        }
        this.removeByIds(Arrays.asList(dictIds));
        return R.ok();
    }
}
