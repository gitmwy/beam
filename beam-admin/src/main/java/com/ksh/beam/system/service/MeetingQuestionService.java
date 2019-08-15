package com.ksh.beam.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.system.entity.meeting.Question;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;

/**
 * 会议问卷
 */
public interface MeetingQuestionService extends IService<Question> {

    /**
     * 分页
     */
    R selectPageList(Question question);

    /**
     * 保存上传问卷数据
     */
    R saveQuestion(MultipartFile file, String fileType);

    /**
     *删除问卷
     */
    R deleteQuestion(Long[] ids);

    /**
     *下载问卷
     */
    void downloadFile(Long id, HttpServletResponse response);
}
