package com.cn.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 管理端访问控制：未以管理员身份登录时，禁止访问后台页面和后台 Servlet。
 * 拦截范围在 web.xml 的 filter-mapping 中配置。
 */
public class AdminAuthFilter implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) resp;

		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("admin") != null) {
			chain.doFilter(req, resp);
			return;
		}

		response.sendRedirect(request.getContextPath() + "/pages/user/memberLogin.jsp");
	}

	@Override
	public void destroy() {
	}
}
