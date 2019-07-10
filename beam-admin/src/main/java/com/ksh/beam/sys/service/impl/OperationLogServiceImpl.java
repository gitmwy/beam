package com.ksh.beam.sys.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.sys.dao.OperationLogMapper;
import com.ksh.beam.sys.entity.sys.OperationLog;
import com.ksh.beam.sys.service.IOperationLogService;
import org.springframework.stereotype.Service;

/**
 * 操作日志
 */
@Service
public class OperationLogServiceImpl extends ServiceImpl<OperationLogMapper, OperationLog> implements IOperationLogService {

    @Override
    public IPage<OperationLog> selectPageList(Page page, OperationLog operationLog) {
        return baseMapper.selectPageList(page,operationLog);
    }

    @Override
    public void deleteAll() {
        baseMapper.deleteAll();
    }
}
