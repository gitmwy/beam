package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.system.entity.sys.OperationLog;

/**
 * 操作日志
 */
public interface OperationLogService extends IService<OperationLog> {

    IPage<OperationLog> selectPageList(Page page, OperationLog operationLog);

    void  deleteAll();
}
