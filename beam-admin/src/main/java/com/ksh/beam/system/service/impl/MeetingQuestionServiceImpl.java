package com.ksh.beam.system.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ksh.beam.common.util.OSSFactory;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.ToolUtil;
import com.ksh.beam.system.dao.MeetingQuestionMapper;
import com.ksh.beam.system.entity.meeting.Question;
import com.ksh.beam.system.service.MeetingQuestionService;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * 会议问卷
 */
@Service
public class MeetingQuestionServiceImpl extends ServiceImpl<MeetingQuestionMapper, Question> implements MeetingQuestionService {

    /**
     * 分页
     */
    @Override
    public R selectPageList(Question question) {
        IPage page = baseMapper.selectPageList(new Page(question.getCurrentPage(), question.getPageSize()), question);
        return R.ok(page);
    }

    /**
     * 保存上传问卷数据
     */
    @Override
    public R saveQuestion(MultipartFile file, String fileType) {
        String fileName = UUID.randomUUID().toString() + "." + ToolUtil.getFileSuffix(file.getOriginalFilename());
        Map<String, String> maps = OSSFactory.buildFtp().ftpUpload(file, fileName, fileType);
        if (null == maps) {
            return R.fail("上传问卷失败");
        }
        Question question = new Question();
        question.setQuestionName(file.getOriginalFilename());
        question.setFilePath(maps.get("filePath"));
        question.setFileName(maps.get("fileName"));
        question.setDownloadTimes(0);
        if (!this.saveOrUpdate(question)) {
            OSSFactory.buildFtp().ftpDelete(question.getFilePath(), question.getFileName());
        }
        return R.ok();
    }

    /**
     * 删除问卷
     */
    @Override
    public R deleteQuestion(Long[] ids) {
        List<Question> questions = baseMapper.selectBatchIds(Arrays.asList(ids));
        for (Question question : questions) {
            if (baseMapper.deleteById(question.getId()) == 1) {
                if (OSSFactory.buildFtp().ftpDelete(question.getFilePath(), question.getFileName())) {
                    return R.ok();
                }
            }
        }
        return R.fail("删除文件失败");
    }

    /**
     * 下载问卷
     */
    @Override
    public void downloadFile(Long id, HttpServletResponse response) {
        Question question = baseMapper.selectById(id);
        OSSFactory.buildFtp().ftpDownload(question.getFilePath(), question.getFileName(), question.getQuestionName(), response);
        question.setDownloadTimes(question.getDownloadTimes() + 1);
        this.updateById(question);
    }
}
