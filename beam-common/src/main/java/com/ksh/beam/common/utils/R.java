package com.ksh.beam.common.utils;

import com.ksh.beam.common.enumeration.RetEnum;

import java.util.HashMap;

/**
 * 封装返回结果类
 **/
public class R<T> extends HashMap<String, Object> {
	private static final long serialVersionUID = 1L;
	
	public R(int code, String msg) {
		put("code", code);
		put("msg", msg);
		put("data", null);
		put("error", true);
	}

	public static R fail() {
		return new R(RetEnum.ERROR.getRet(),RetEnum.ERROR.getMsg());
	}
	
	public static R fail(String msg) {
		return fail(RetEnum.ERROR.getRet(), msg);
	}
	
	public static R fail(int code, String msg) {
		return new R(code,msg);
	}

	public static <T> R<T> fail(T data) {
		R r = new R(RetEnum.ERROR.getRet(),RetEnum.ERROR.getMsg());
		r.put("data",data);
		return r;
	}


	public static <T> R<T> fail(int code,String msg,T data) {
		R r = new R(code,msg);
		r.put("data",data);
		return r;
	}

	public static R ok() {
		R r = new R(RetEnum.SUCCESS.getRet(),RetEnum.SUCCESS.getMsg());
		r.put("error",false);
		return r;
	}

	public static R ok(String msg) {
		R r = new R(RetEnum.SUCCESS.getRet(),msg);
		r.put("data",msg);
		r.put("error",false);
		return r;
	}

	public static R ok(int code, String msg) {
		R r = new R(code,msg);
		r.put("error",false);
		return r;
	}

	public static <T> R<T> ok(T data) {
		R r = new R(RetEnum.SUCCESS.getRet(),RetEnum.SUCCESS.getMsg());
		r.put("data",data);
		r.put("error",false);
		return r;
	}

	public static <T> R<T> ok(int code,String msg,T data) {
		R r = new R(code,msg);
		r.put("data",data);
		r.put("error",false);
		return r;
	}

	@Override
	public R put(String key, Object value) {
		super.put(key, value);
		return this;
	}
}
