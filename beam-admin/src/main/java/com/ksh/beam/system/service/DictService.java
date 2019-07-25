package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.sys.Dict;

/**
 * 字典表
 */
public interface DictService extends IService<Dict> {

    R selectPageList(Dict dict);

    R selectList();

    R saveDict(Dict dict);

    R deleteBatch(Long[] dictIds);
}
