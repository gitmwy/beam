package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.meeting.MeetingCourse;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;

/**
 * 会议课件
 */
public interface MeetingCourseService extends IService<MeetingCourse> {

    /**
     * 分页
     */
    R selectPageList(MeetingCourse meetingCourse);

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
