package com.ksh.beam.system.controller.meeting;

import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.service.MeetingPlaceTypeService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 会议场所类型
 */
@Api(value = "MeetingPlaceTypeController", tags = {"MeetingPlaceType接口"})
@RestController
@RequestMapping("/meeting/placeType")
public class MeetingPlaceTypeController {

    @Autowired
    private MeetingPlaceTypeService meetingPlaceTypeService;

    @ApiOperation("获取会议类型列表")
    @GetMapping(value = "/list")
    public R list() {
        return meetingPlaceTypeService.getTypeList();
    }
}
