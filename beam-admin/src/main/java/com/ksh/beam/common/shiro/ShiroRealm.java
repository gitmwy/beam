package com.ksh.beam.common.shiro;

import com.ksh.beam.common.factory.impl.ConstantFactory;
import com.ksh.beam.common.utils.ToolUtil;
import com.ksh.beam.system.entity.sys.User;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authc.credential.CredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * 认证
 */
public class ShiroRealm extends AuthorizingRealm {

	/**
	 * 认证(登录时调用)
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
		UsernamePasswordToken usernamePasswordToken = (UsernamePasswordToken)authenticationToken;
		String account = usernamePasswordToken.getUsername();
		//查询用户信息
		User user = ConstantFactory.me().getUserByAccount(account);
		//账号不存在
		if(user == null) {
			throw new UnknownAccountException("该账号名不存在");
		}
		//账号锁定
		if(user.getStatus() == 0){
			throw new LockedAccountException("账号已被锁定，请联系管理员");
		}
		ShiroUser shiroUser = shiroUser(user);

		return new SimpleAuthenticationInfo(shiroUser, user.getPassword(), ByteSource.Util.bytes(user.getSalt()), getName());
	}

    /**
     * 授权(验证权限时调用)
     */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		ShiroUser shiroUser = (ShiroUser) principals.getPrimaryPrincipal();
		List<String> roleNameList = shiroUser.getRoleNames();
		List<String> permsList = ConstantFactory.me().findPermissionsByUserId(shiroUser.getId());
		//用户权限列表
		Set<String> permsSet = new HashSet<>();
		for(String perms : permsList){
			if(ToolUtil.isEmpty(perms)){
				continue;
			}
			permsSet.addAll(Arrays.asList(perms.trim().split(",")));
		}
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
		info.setStringPermissions(permsSet);
		info.addRoles(roleNameList);
		return info;
	}

	@Override
	public void setCredentialsMatcher(CredentialsMatcher credentialsMatcher) {
		super.setCredentialsMatcher(credentialsMatcher);
	}

	private ShiroUser shiroUser(User user) {
		ShiroUser shiroUser = new ShiroUser();

		shiroUser.setId(user.getId());
		shiroUser.setAccount(user.getAccount());
		shiroUser.setDeptId(user.getDeptId());
		shiroUser.setDeptName(ConstantFactory.me().getDeptName(user.getDeptId()));
		shiroUser.setName(user.getName());
		shiroUser.setAvatar(user.getAvatar());

		List<Long> roleList = ConstantFactory.me().getRoleIdsById(user.getId());
		List<String> roleNameList = new ArrayList<>();
		for (Long roleId : roleList) {
			roleNameList.add(ConstantFactory.me().getSingleRoleName(roleId));
		}
		shiroUser.setRoleList(roleList);
		shiroUser.setRoleNames(roleNameList);

		return shiroUser;
	}
}
