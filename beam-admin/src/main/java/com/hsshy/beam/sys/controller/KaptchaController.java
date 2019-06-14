package com.hsshy.beam.sys.controller;


import com.google.code.kaptcha.Constants;
import com.google.code.kaptcha.impl.DefaultKaptcha;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;

/**
 * 验证码生成
 */
@Controller
@RequestMapping("kaptcha")
public class KaptchaController {

    @Autowired
    private DefaultKaptcha defaultKaptcha;

    /**
     * 生成验证码
     */
    @RequestMapping("defaultKaptcha")
    public void defaultKaptcha(HttpServletRequest request, HttpServletResponse response) {

        // 定义response输出类型为image/jpeg类型，使用response输出流输出图片的byte数组
        response.setDateHeader("Expires", 0);
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
        response.addHeader("Cache-Control", "post-check=0, pre-check=0");
        response.setHeader("Pragma", "no-cache");
        response.setContentType("image/jpeg");

        // 生产验证码字符串并保存到session中
        String capText = defaultKaptcha.createText();
        HttpSession session = request.getSession();
        session.setAttribute(Constants.KAPTCHA_SESSION_KEY, capText);

        // 使用生产的验证码字符串返回一个BufferedImage对象并转为byte写入到byte数组中
        BufferedImage bi = defaultKaptcha.createImage(capText);
        try(ServletOutputStream out = response.getOutputStream()) {
            ImageIO.write(bi, "jpg", out);
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
