package com.ksh.beam.system.dao;

import com.ksh.beam.system.entity.sys.Dict;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;

/**
 * 字典表
 */
public interface DictMapper extends BaseMapper<Dict> {

    IPage<Dict> selectPageList(Page page, @Param("dict") Dict dict);
}
