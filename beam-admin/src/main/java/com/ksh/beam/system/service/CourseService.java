package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.meeting.Course;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;

/**
 * 会议课件
 */
public interface CourseService extends IService<Course> {

    /**
     * 分页
     */
    R selectPageList(Course course);

    /**
     * 保存上传课件数据
     */
    R saveCoursePerms(MultipartFile file, String fileType);

    /**
     *删除课件数据
     */
    R deleteCourse(Long[] userIds);

    /**
     *下载课件
     */
    void downloadFile(Long id, HttpServletResponse response);
}
