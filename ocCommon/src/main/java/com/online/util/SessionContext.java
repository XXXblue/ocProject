package com.online.util;


import javax.servlet.http.HttpServletRequest;

/**
 * session工具类
 */
public class SessionContext {
	public static final String IDENTIFY_CODE_KEY = "_consts_identify_code_key_";// 其他人不得占用
	public static final String AUTH_USER_KEY = "_consts_auth_user_key_";// 其他人不得占用



	// 获取验证码
	public static String getIdentifyCode(HttpServletRequest request) {
		if (request.getSession().getAttribute(IDENTIFY_CODE_KEY) != null) {
			return getAttribute(request, IDENTIFY_CODE_KEY).toString();
		} else {
			return null;
		}
	}

	// 获取属性
	public static Object getAttribute(HttpServletRequest request, String key) {
		return request.getSession().getAttribute(key);
	}

	// 设置属性
	public static void setAttribute(HttpServletRequest request, String key, Object value) {
		request.getSession().setAttribute(key, value);
	}

	// 删除属性
	public static void removeAttribute(HttpServletRequest request, String key) {
		request.getSession().removeAttribute(key);
	}

}
