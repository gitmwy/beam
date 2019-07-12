package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.util.FtpUtil;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.ToolUtil;
import com.ksh.beam.system.dao.CourseMapper;
import com.ksh.beam.system.entity.meeting.Course;
import com.ksh.beam.system.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;
import java.util.UUID;

/**
 * 会议课件
 */
@Service
public class CourseServiceImpl extends ServiceImpl<CourseMapper, Course> implements CourseService {

    @Autowired
    private FtpUtil ftpUtil;

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
    public R saveCoursePerms(MultipartFile file, String fileType) {
        String fileName = UUID.randomUUID().toString() + "." + ToolUtil.getFileSuffix(file.getOriginalFilename());
        try {
            Map<String, String> maps = ftpUtil.uploadToFtp(file, fileName, fileType);
            maps.put("fileName", file.getOriginalFilename());
            Course course = new Course();
            course.setCourseName(maps.get("fileName"));
            course.setCourseSize(maps.get("fileSize"));
            course.setCourseUrl(maps.get("fileUrl"));
            course.setCourseTimes(0);
            baseMapper.saveCoursePerms(course);
        } catch (Exception e) {
            e.printStackTrace();
            return R.fail("上传文件失败");
        }
        return R.ok();
    }

    /**
     *删除课件数据
     */
    @Override
    public R deleteCourse(Course course) {
        baseMapper.deleteById(course.getId());
        return null;
    }
}
