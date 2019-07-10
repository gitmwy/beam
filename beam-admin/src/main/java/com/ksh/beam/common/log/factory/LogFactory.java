package com.ksh.beam.common.log.factory;

import com.ksh.beam.common.log.state.LogSucceed;
import com.ksh.beam.common.log.state.LogType;
import com.ksh.beam.sys.entity.sys.LoginLog;
import com.ksh.beam.sys.entity.sys.OperationLog;

import java.util.Date;

public class LogFactory {

    /**
     * 创建操作日志
     */
    public static OperationLog createOperationLog(LogType logType, Long userId, String bussinessName, String clazzName, String methodName, String msg, LogSucceed succeed, Long time) {
        OperationLog operationLog = new OperationLog();
        operationLog.setLogType(logType.getMessage());
        operationLog.setLogName(bussinessName);
        operationLog.setUserId(userId);
        operationLog.setClassName(clazzName);
        operationLog.setMethod(methodName);
        operationLog.setCreateTime(new Date());
        operationLog.setSucceed(succeed.getMessage());
        operationLog.setMessage(msg);
        operationLog.setExecuteTime(String.valueOf(time));
        return operationLog;
    }

    /**
     * 创建登录日志
     */
    public static LoginLog createLoginLog(LogType logType, Long userId, String msg, String ip, LogSucceed succeed) {
        LoginLog loginLog = new LoginLog();
        loginLog.setLogName(logType.getMessage());
        loginLog.setUserId(userId);
        loginLog.setCreateTime(new Date());
        loginLog.setSucceed(succeed.getMessage());
        loginLog.setIpAddress(ip);
        loginLog.setMessage(msg);
        return loginLog;
    }
}
