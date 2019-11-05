package com.ksh.beam.system.controller.meeting;

import com.ksh.beam.common.annotion.SysLog;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.meeting.Place;
import com.ksh.beam.system.service.MeetingPlaceService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

/**
 * 会议场所
 */
@Api(value = "MeetingPlaceController", tags = {"会议场所"})
@RestController
@RequestMapping("/meeting/place")
public class MeetingPlaceController {

    @Autowired
    private MeetingPlaceService meetingPlaceService;

    @ApiOperation("场所分页")
    @GetMapping(value = "/page/list")
    @RequiresPermissions("meeting:place:list")
    public R pageList(Place place) {
        return meetingPlaceService.selectPageList(place);
    }

    @SysLog(value = "场所删除")
    @ApiOperation("场所删除")
    @PostMapping(value = "/del")
    @RequiresPermissions("meeting:place:del")
    public R del(@RequestBody Long[] placeIds) {
        Assert.notEmpty(placeIds, "请选择要删除的资源");
        return meetingPlaceService.deletePlace(placeIds);
    }

    @SysLog(value = "场所新增")
    @ApiOperation("场所新增")
    @PostMapping(value = "/add")
    @RequiresPermissions("meeting:place:add")
    public R add(@RequestBody @Valid Place place) {
        return meetingPlaceService.savePlace(place);
    }
}
