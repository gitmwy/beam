package com.ksh.beam.system.controller.common;

import com.ksh.beam.common.log.LogManager;
import com.ksh.beam.common.log.factory.LogTaskFactory;
import com.ksh.beam.common.log.state.LogSucceed;
import com.ksh.beam.common.shiro.ShiroUtils;
import com.ksh.beam.common.util.CaptchaUtil;
import com.ksh.beam.common.utils.R;
import com.ksh.beam.common.utils.RedisUtil;
import com.ksh.beam.system.dto.LoginForm;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.Assert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

import static com.ksh.beam.common.support.HttpKit.getIp;

@Api(value = "LoginController", tags = {"Login接口"})
@RestController
public class LoginController {

    @Autowired
    private RedisUtil redisUtil;

    @ApiOperation("登陆")
    @PostMapping(value = "/login")
    @ResponseBody
    public Object login(@RequestBody @Valid LoginForm loginForm) {
        if (new CaptchaUtil().isCaptchaOnOff()) {
//            String captcha = ShiroUtils.getCaptcha(Constants.KAPTCHA_SESSION_KEY);
//            if (StringUtils.isBlank(captcha)) {
//                return R.fail("验证码已失效，请点击图片重新刷新");
//            } else if (!loginForm.getCaptcha().equalsIgnoreCase(captcha)) {
//                return R.fail("验证码不正确");
//            }
            Assert.isTrue(loginForm.isConfirmSuccess(), "请拖动滑块完成验证");
        }
        try {
            Subject subject = ShiroUtils.getSubject();
            UsernamePasswordToken token = new UsernamePasswordToken(loginForm.getUsername(), loginForm.getPassword());
            subject.login(token);
            LogManager.me().executeLog(LogTaskFactory.loginSuccessLog(ShiroUtils.getUserId(), getIp()));
        } catch (UnknownAccountException e) {
            e.getStackTrace();
            return R.fail(LogSucceed.FAIL.getMessage());
        } catch (IncorrectCredentialsException e) {
            return R.fail("账号或者密码不正确");
        } catch (LockedAccountException e) {
            return R.fail("账号已被锁定，请联系管理员");
        } catch (AuthenticationException e) {
            return R.fail("账户验证失败");
        }
        return R.ok(ShiroUtils.getUserEntity());
    }

    /**
     * 退出
     */
    @ApiOperation("退出")
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
    @ApiOperation("清除缓存")
    @GetMapping(value = "/clearCache")
    @ResponseBody
    public R clearCache() {
        redisUtil.clearCache();
        return R.ok("清除成功");
    }
}
