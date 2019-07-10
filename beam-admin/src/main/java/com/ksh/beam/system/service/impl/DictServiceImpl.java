package com.ksh.beam.system.service.impl;

import com.ksh.beam.system.dao.DictMapper;
import com.ksh.beam.system.entity.sys.Dict;
import com.ksh.beam.system.service.DictService;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

/**
 * 字典表
 */
@Service
public class DictServiceImpl extends ServiceImpl<DictMapper, Dict> implements DictService {

}
