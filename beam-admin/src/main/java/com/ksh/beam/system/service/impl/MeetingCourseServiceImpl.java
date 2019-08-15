package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.util.OSSFactory;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.ToolUtil;
import com.ksh.beam.system.dao.MeetingCourseMapper;
import com.ksh.beam.system.entity.meeting.Course;
import com.ksh.beam.system.service.MeetingCourseService;
import org.springframework.stereotype.Service;
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
public class MeetingCourseServiceImpl extends ServiceImpl<MeetingCourseMapper, Course> implements MeetingCourseService {

    /**
     * 分页
     */
    @Override
    public R selectPageList(Course course) {
        IPage page = baseMapper.selectPageList(new Page(course.getCurrentPage(), course.getPageSize()), course);
        return R.ok(page);
    }

    /**
     * 保存上传课件数据
     */
    @Override
    public R saveCourse(MultipartFile file, String fileType) {
        String fileName = UUID.randomUUID().toString() + "." + ToolUtil.getFileSuffix(file.getOriginalFilename());
        Map<String, String> maps = OSSFactory.buildFtp().ftpUpload(file, fileName, fileType);
        if(null == maps){
            return R.fail("上传课件失败");
        }
        Course course = new Course();
        course.setCourseName(file.getOriginalFilename());
        course.setFileName(maps.get("fileName"));
        course.setFilePath(maps.get("filePath"));
        course.setFileSize(maps.get("fileSize"));
        course.setDownloadTimes(0);
        if(!this.saveOrUpdate(course)){
            OSSFactory.buildFtp().ftpDelete(course.getFilePath(), course.getFileName());
        }
        return R.ok();
    }

    /**
     *删除课件数据
     */
    @Override
    public R deleteCourse(Long[] ids) {
        List<Course> cours = baseMapper.selectBatchIds(Arrays.asList(ids));
        for(Course course : cours){
            if(baseMapper.deleteById(course.getId()) == 1){
                if(OSSFactory.buildFtp().ftpDelete(course.getFilePath(), course.getFileName())){
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
        OSSFactory.buildFtp().ftpDownload(course.getFilePath(), course.getFileName(), course.getCourseName(), response);
        course.setDownloadTimes(course.getDownloadTimes() + 1);
        this.updateById(course);
    }
}
