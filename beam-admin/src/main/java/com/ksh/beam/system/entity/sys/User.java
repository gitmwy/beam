package com.ksh.beam.system.entity.sys;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ksh.beam.common.base.entity.DataEntity;
import com.ksh.beam.common.constant.RegexConstant;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.List;

/**
 * 管理员表
 */
@NoArgsConstructor
@Data
@TableName("sys_user")
public class User extends DataEntity<Long> {
	private static final long serialVersionUID = 1L;

	/**
	 * 主键id
	 */
	@TableId
	private Long id;
	/**
	 * 头像
	 */
	private String avatar;
	/**
	 * 账号
	 */
	@NotBlank(message = "登陆账号不能为空")
	private String account;
	/**
	 * 密码
	 */
	private String password;
	/**
	 * md5密码盐
	 */
	private String salt;
	/**
	 * 名字
	 */
	@NotBlank(message = "真实姓名不能为空")
	private String name;
	/**
	 * 部门ID
	 */
	@NotNull(message = "部门不能为空")
	private Long deptId;
	/**
	 * 生日
	 */
	private String birthday;
	/**
	 * 性别（1：男 2：女）
	 */
	private Integer sex;
	/**
	 * 电子邮件
	 */
	@Pattern(regexp = RegexConstant.EMAIL_REGEX, message = "请输入正确的邮箱")
	private String email;
	/**
	 * 电话
	 */
	@NotBlank(message = "手机号不能为空")
	@Size(max = 11)
	@Pattern(regexp = RegexConstant.PHONE_REGEX, message = "请输入正确的手机号")
	private String phone;
	/**
	 * 状态(1：可用  0：不可用 ）
	 */
	private Integer status;
	/**
	 * 保留字段
	 */
	private Integer version;
	/**
	 * 公司ID
	 */
	private Long companyId;
	/**
	 * 公司名称
	 */
	@TableField(exist = false)
	private String companyName;
	/**
	 * 部门名称
	 */
	@TableField(exist = false)
	private String deptName;
	/**
	 * 多个部门ID
	 */
	@TableField(exist = false)
	private String deptIds;
	/**
	 * 选择的角色
	 */
	@NotEmpty(message = "请选择角色")
	@TableField(exist = false)
	private List<Long> roleIds;
	/**
	 * 性别
	 */
	@TableField(exist = false)
	private String sexName;

	@TableField(exist = false)
	private String statusName;

	@Override
	protected Serializable pkVal() {
        return this.id;
	}
}
