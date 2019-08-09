package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.util.OSSFactory;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.ToolUtil;
import com.ksh.beam.system.dao.MeetingCourseMapper;
import com.ksh.beam.system.entity.meeting.MeetingCourse;
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
public class MeetingCourseServiceImpl extends ServiceImpl<MeetingCourseMapper, MeetingCourse> implements MeetingCourseService {

    /**
     * 分页
     */
    @Override
    public R selectPageList(MeetingCourse meetingCourse) {
        IPage page = baseMapper.selectPageList(new Page(meetingCourse.getCurrentPage(), meetingCourse.getPageSize()), meetingCourse);
        return R.ok(page);
    }

    /**
     * 保存上传课件数据
     */
    @Override
    public R saveCoursePerms(MultipartFile file, String fileType) {
        String fileName = UUID.randomUUID().toString() + "." + ToolUtil.getFileSuffix(file.getOriginalFilename());
        Map<String, String> maps = OSSFactory.buildFtp().ftpUpload(file, fileName, fileType);
        if(null == maps){
            return R.fail("上传课件失败");
        }
        MeetingCourse meetingCourse = new MeetingCourse();
        meetingCourse.setCourseName(file.getOriginalFilename());
        meetingCourse.setFileName(maps.get("fileName"));
        meetingCourse.setFilePath(maps.get("filePath"));
        meetingCourse.setFileSize(maps.get("fileSize"));
        meetingCourse.setDownloadTimes(0);
        if(!this.saveOrUpdate(meetingCourse)){
            OSSFactory.buildFtp().ftpDelete(meetingCourse.getFilePath(), meetingCourse.getFileName());
        }
        return R.ok();
    }

    /**
     *删除课件数据
     */
    @Override
    public R deleteCourse(Long[] userIds) {
        List<MeetingCourse> cours = baseMapper.selectBatchIds(Arrays.asList(userIds));
        for(MeetingCourse meetingCourse : cours){
            if(baseMapper.deleteById(meetingCourse.getId()) == 1){
                if(OSSFactory.buildFtp().ftpDelete(meetingCourse.getFilePath(), meetingCourse.getFileName())){
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
        MeetingCourse meetingCourse = baseMapper.selectById(id);
        OSSFactory.buildFtp().ftpDownload(meetingCourse.getFilePath(), meetingCourse.getFileName(), meetingCourse.getCourseName(), response);
        meetingCourse.setDownloadTimes(meetingCourse.getDownloadTimes() + 1);
        this.updateById(meetingCourse);
    }
}
