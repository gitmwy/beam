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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.List;
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
    @Transactional(rollbackFor = Exception.class)
    public R saveCoursePerms(MultipartFile file, String fileType) {
        Course course = new Course();
        try {
            String fileName = UUID.randomUUID().toString() + "." + ToolUtil.getFileSuffix(file.getOriginalFilename());
            Map<String, String> maps = ftpUtil.uploadToFtp(file, fileName, fileType);
            course.setCourseName(file.getOriginalFilename());
            course.setFileName(maps.get("fileName"));
            course.setFilePath(maps.get("filePath"));
            course.setFileSize(maps.get("fileSize"));
            course.setDownloadTimes(0);
            this.saveOrUpdate(course);
        } catch (Exception e) {
            e.printStackTrace();
            ftpUtil.deleteFile(course.getFilePath(), course.getFileName());
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
        }
        return R.ok();
    }

    /**
     *删除课件数据
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public R deleteCourse(Long[] userIds) {
        if (ToolUtil.isEmpty(userIds) || userIds.length <= 0) {
            return R.fail("未选择删除的课件");
        }
        List<Course> courses = baseMapper.selectBatchIds(Arrays.asList(userIds));
        for(Course course : courses){
            if(baseMapper.deleteById(course.getId()) == 1){
                if(ftpUtil.deleteFile(course.getFilePath(), course.getFileName())){
                    return R.ok();
                }
            }
        }
        return R.fail("删除文件失败");
    }

    /**
     *下载课件
     */
    @Override
    public void downloadFile(Long id, HttpServletResponse response) {
        Course course = baseMapper.selectById(id);
        ftpUtil.downloadFile(course.getFilePath(), course.getFileName(), course.getCourseName(), response);
    }
}
