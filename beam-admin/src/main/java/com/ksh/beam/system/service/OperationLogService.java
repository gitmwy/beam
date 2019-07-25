package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.sys.OperationLog;

/**
 * 操作日志
 */
public interface OperationLogService extends IService<OperationLog> {

    R selectPageList(OperationLog operationLog);

    R deleteAll();
}
