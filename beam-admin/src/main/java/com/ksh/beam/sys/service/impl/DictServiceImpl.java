package com.ksh.beam.sys.service.impl;

import com.ksh.beam.sys.dao.DictMapper;
import com.ksh.beam.sys.entity.sys.Dict;
import com.ksh.beam.sys.service.IDictService;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

/**
 * 字典表
 */
@Service
public class DictServiceImpl extends ServiceImpl<DictMapper, Dict> implements IDictService {

}
