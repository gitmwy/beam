package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.dao.OperationLogMapper;
import com.ksh.beam.system.entity.sys.OperationLog;
import com.ksh.beam.system.service.OperationLogService;
import org.springframework.stereotype.Service;

/**
 * 操作日志
 */
@Service
public class OperationLogServiceImpl extends ServiceImpl<OperationLogMapper, OperationLog> implements OperationLogService {

    @Override
    public R selectPageList(OperationLog operationLog) {
        IPage page = baseMapper.selectPageList(new Page(operationLog.getCurrentPage(), operationLog.getPageSize()), operationLog);
        return R.ok(page);
    }

    @Override
    public R deleteAll() {
        baseMapper.deleteAll();
        return R.ok();
    }
}
