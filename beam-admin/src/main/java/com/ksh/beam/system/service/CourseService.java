package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.meeting.Course;

import java.util.Map;

/**
 * 会议课件
 */
public interface CourseService extends IService<Course> {

    /**
     * 分页
     */
    IPage<Course> selectPageList(Course course);

    /**
     * 保存上传课件数据
     */
    R saveCoursePerms(Map<String, String> maps);
}
