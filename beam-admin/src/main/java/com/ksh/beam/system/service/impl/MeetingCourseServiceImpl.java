package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.constant.Constant;
import com.ksh.beam.common.file.FileUtil;
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
import java.util.Objects;
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
    public R saveCourse(MultipartFile file) {
        String fileName = "";
        try {
            fileName = Constant.COURSE + UUID.randomUUID().toString() + "." + ToolUtil.getFileSuffix(file.getOriginalFilename());
            String url = Objects.requireNonNull(OSSFactory.buildCloud()).upload(file.getBytes(),  fileName);
            Course course = new Course();
            course.setName(file.getOriginalFilename());
            course.setUrl(url);
            course.setSize(FileUtil.getFileSize(file.getSize()));
            course.setTimes(0);
            if (!this.save(course)) {
                Objects.requireNonNull(OSSFactory.buildCloud()).delete(fileName);
            }
        } catch (Exception e) {
            Objects.requireNonNull(OSSFactory.buildCloud()).delete(fileName);
            e.printStackTrace();
            return R.fail("上传图片失败");
        }
        return R.ok();
    }

    /**
     * 删除课件数据
     */
    @Override
    public R deleteCourse(Long[] ids) {
        List<Course> cours = baseMapper.selectBatchIds(Arrays.asList(ids));
        for (Course course : cours) {
            if (baseMapper.deleteById(course.getId()) == 1) {
                Objects.requireNonNull(OSSFactory.buildCloud()).delete(Constant.COURSE + course.getName());
                return R.ok();
            }
        }
        return R.fail("删除文件失败");
    }

    /**
     * 下载课件
     */
    @Override
    public void downloadFile(Long id, HttpServletResponse response) {
        Course course = baseMapper.selectById(id);
        FileUtil.urlDownload(
                Objects.requireNonNull(OSSFactory.buildCloud()).getDownloadUrl(course.getUrl()),
                course.getName(),
                response);
        course.setTimes(course.getTimes() + 1);
        this.updateById(course);
    }
}
