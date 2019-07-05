package com.hsshy.beam.sys.controller;

import com.google.code.kaptcha.Constants;
import com.hsshy.beam.common.log.LogManager;
import com.hsshy.beam.common.log.factory.LogTaskFactory;
import com.hsshy.beam.common.shiro.ShiroUtils;
import com.hsshy.beam.common.util.KaptchaUtil;
import com.hsshy.beam.common.utils.R;
import com.hsshy.beam.common.utils.RedisUtil;
import com.hsshy.beam.sys.dto.LoginForm;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import static com.hsshy.beam.common.support.HttpKit.getIp;

@RestController
public class LoginController {

    @Autowired
    private RedisUtil redisUtil;

    @PostMapping(value = "/login")
    @ResponseBody
    public Object login(@RequestBody LoginForm loginForm) {
        if (new KaptchaUtil().isKaptchaOnOff()) {
            String kaptcha = ShiroUtils.getKaptcha(Constants.KAPTCHA_SESSION_KEY);
            if (StringUtils.isBlank(kaptcha)) {
                return R.fail("验证码已失效，请点击图片重新刷新");
            } else if (!loginForm.getKaptcha().equalsIgnoreCase(kaptcha)) {
                return R.fail("验证码不正确");
            }
        }
        String msg = "";
        try {
            Subject subject = ShiroUtils.getSubject();
            UsernamePasswordToken token = new UsernamePasswordToken(loginForm.getUsername(), loginForm.getPassword());
            subject.login(token);
            LogManager.me().executeLog(LogTaskFactory.loginSuccessLog(ShiroUtils.getUserId(), getIp()));
        } catch (UnknownAccountException e) {
            msg = e.getMessage();
            return R.fail(msg);
        } catch (IncorrectCredentialsException e) {
            msg = "账号或者密码不正确";
            return R.fail(msg);
        } catch (LockedAccountException e) {
            msg = "账号已被锁定，请联系管理员";
            return R.fail(msg);
        } catch (AuthenticationException e) {
            msg = "账户验证失败";
            return R.fail(msg);
        }finally {
            if(StringUtils.isNotBlank(msg)){
                LogManager.me().executeLog(LogTaskFactory.loginFailLog(loginForm.getUsername(), msg, getIp()));
            }
        }
        return R.ok(ShiroUtils.getUserEntity());
    }

    /**
     * 退出
     */
    @GetMapping(value = "/logout")
    @ResponseBody
    public Object logout() {
        LogManager.me().executeLog(LogTaskFactory.exitLog(ShiroUtils.getUserId(), getIp()));
        ShiroUtils.logout();
        return R.ok("退出成功");
    }

    /**
     * 清除缓存
     */
    @GetMapping(value = "/clearCache")
    @ResponseBody
    public R clearCache() {
        redisUtil.clearCache();
        return R.ok("清除成功");
    }
}
