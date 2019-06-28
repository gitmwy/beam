package com.hsshy.beam.common.quartz;

import com.hsshy.beam.common.exception.BeamException;
import com.hsshy.beam.common.utils.SpringContextHolder;
import com.hsshy.beam.common.utils.ToolUtil;
import org.springframework.util.ReflectionUtils;

import java.lang.reflect.Method;

/**
 * 执行定时任务
 */
public class ScheduleRunnable implements Runnable {
	private Object target;
	private Method method;
	private String params;
	
	public ScheduleRunnable(String beanName, String methodName, String params) throws NoSuchMethodException, SecurityException {
		this.target = SpringContextHolder.getBean(beanName);
		this.params = params;
		
		if(ToolUtil.isNotEmpty(params)){
			this.method = target.getClass().getDeclaredMethod(methodName, String.class);
		}else{
			this.method = target.getClass().getDeclaredMethod(methodName);
		}
	}

	@Override
	public void run() {
		try {
			ReflectionUtils.makeAccessible(method);
			if(ToolUtil.isNotEmpty(params)){
				method.invoke(target, params);
			}else{
				method.invoke(target);
			}
		}catch (Exception e) {
			throw new BeamException("执行定时任务失败", e);
		}
	}
}
