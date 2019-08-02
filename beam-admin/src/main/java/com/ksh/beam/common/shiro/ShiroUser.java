package com.ksh.beam.common.shiro;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

@Data
@NoArgsConstructor
public class ShiroUser implements Serializable {

	/**
	 * 主键id
	 */
	private Long id;
	/**
	 * 头像
	 */
	private String avatar;
	/**
	 * 账号
	 */
	private String account;
	/**
	 * 名字
	 */
	private String name;
	/**
	 * 部门id
	 */
	private Long deptId;
	/**
	 * 角色集
	 */
	private List<Long> roleList;
	/**
	 * 部门名称
	 */
	private String deptName;
	/**
	 * 角色名称集
	 */
	private List<String> roleNames;
}
