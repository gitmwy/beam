package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.dao.CourseMapper;
import com.ksh.beam.system.entity.meeting.Course;
import com.ksh.beam.system.service.CourseService;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * 会议课件
 */
@Service
public class CourseServiceImpl extends ServiceImpl<CourseMapper, Course> implements CourseService {

    /**
     * 分页
     */
    @Override
    public IPage<Course> selectPageList(Course course) {
        return baseMapper.selectPageList(new Page(course.getCurrentPage(), course.getPageSize()), course);
    }

    /**
     * 保存上传课件数据
     */
    @Override
    public R saveCoursePerms(Map<String, String> maps) {
        Course course = new Course();
        course.setCourseName(maps.get("fileName"));
        course.setCourseSize(maps.get("fileSize"));
        course.setCourseUrl(maps.get("fileUrl"));
        course.setCourseTimes(0);
        baseMapper.saveCoursePerms(course);
        return R.ok("文件上传成功");
    }
}
