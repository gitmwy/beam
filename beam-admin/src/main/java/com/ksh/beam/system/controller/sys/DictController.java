package com.ksh.beam.system.controller.sys;

import com.ksh.beam.common.base.controller.BaseController;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.sys.Dict;
import com.ksh.beam.system.service.DictService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.util.Assert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

/**
 * 字典表
 */
@Api(value = "DictController", tags = {"Dict接口"})
@RequestMapping("/sys/dict")
@RestController
public class DictController extends BaseController {

    @Autowired
    private DictService dictService;

    /**
     * 分页列表
     */
    @ApiOperation("分页列表")
    @GetMapping(value = "/page/list")
    @RequiresPermissions("sys:dict:list")
    public R pageList(Dict dict) {
        return dictService.selectPageList(dict);
    }

    @ApiOperation("列表")
    @GetMapping(value = "/list")
    public R list() {
        return dictService.selectList();
    }

    @ApiOperation("新增")
    @RequiresPermissions("sys:dict:add")
    @PostMapping(value = "/add")
    public R add(@RequestBody @Valid Dict dict) {
       return dictService.saveDict(dict);
    }

    @ApiOperation("删除")
    @RequiresPermissions("sys:dict:del")
    @PostMapping(value = "/del")
    public R del(@RequestBody Long[] dictIds) {
        Assert.notEmpty(dictIds, "请选择要删除的记录");
        return dictService.deleteBatch(dictIds);
    }
}