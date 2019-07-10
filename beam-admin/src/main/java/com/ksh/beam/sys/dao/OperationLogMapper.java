package com.ksh.beam.sys.dao;

import com.ksh.beam.sys.entity.sys.OperationLog;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;

/**
 * 操作日志
 */
public interface OperationLogMapper extends BaseMapper<OperationLog> {

    IPage<OperationLog> selectPageList(Page page, @Param("operationLog") OperationLog operationLog);

    void deleteAll();
}
