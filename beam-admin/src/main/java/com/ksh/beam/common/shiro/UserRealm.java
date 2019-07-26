package com.ksh.beam.common.shiro;

import com.ksh.beam.common.shiro.factory.ShiroFactroy;
import com.ksh.beam.common.utils.ToolUtil;
import com.ksh.beam.system.entity.sys.User;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authc.credential.CredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * 认证
 */
@Component
public class UserRealm extends AuthorizingRealm {

    /**
     * 授权(验证权限时调用)
     */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		IShiro shiroFactory = ShiroFactroy.me();
		ShiroUser shiroUser = (ShiroUser) principals.getPrimaryPrincipal();

		List<String> roleNameList = shiroUser.getRoleNames();

		List<String> permsList = shiroFactory.findPermissionsByUserId(shiroUser.getId());
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

	/**
	 * 认证(登录时调用)
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) throws AuthenticationException {
		IShiro shiroFactory = ShiroFactroy.me();
		UsernamePasswordToken token = (UsernamePasswordToken)authcToken;
		User user = shiroFactory.user(token.getUsername());

		ShiroUser shiroUser = shiroFactory.shiroUser(user);

		return shiroFactory.info(shiroUser,user,getName());
	}

	@Override
	public void setCredentialsMatcher(CredentialsMatcher credentialsMatcher) {
		super.setCredentialsMatcher(credentialsMatcher);
	}
}
