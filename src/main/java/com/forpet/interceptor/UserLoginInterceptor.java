package com.forpet.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.forpet.domain.MemberVO;

public class UserLoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		boolean result = false;
		
		// 인증된 사용자인지 여부 체크 (세션 객체 확인)
		HttpSession session = request.getSession();
		MemberVO user = (MemberVO) session.getAttribute("loginStatus");
		
		// 로그인하지 않았을 경우
		if(user == null) { 
			result = false;
			
			// Ajax요청 여부 체크
			if(isAjaxRequest(request)) {

				response.sendError(400); // Ajax요청시 응답에러 코드400 리턴.
				
			}else {
				
				getDestination(request); // 원래 요청주소 저장.
				response.sendRedirect("/member/login");
			}
		}else { // 로그인 했을 경우
			result = true;
		}
		
		return result; // true이면 컨트롤러로 제어가 넘어감.
	}

	/* Ajax요청 체크 */
	private boolean isAjaxRequest(HttpServletRequest request) {
		
		boolean isAjax = false;
		
		// Ajax요청시 헤더에 AJAX : "true"로 작업해둬야 함.
		String header = request.getHeader("AJAX");
		if("true".equals(header)) {
			isAjax = true;
		}
		
		return isAjax;
	}

	/* 원래 요청주소 저장 */
	private void getDestination(HttpServletRequest request) {
		
		String uri = request.getRequestURI();    
		String query = request.getQueryString(); 
	
		if(query == null || query.equals("null")) {
			query = "";
		}else {
			query = "?" + query;
		}
		
		String destination = uri + query;
		
		if(request.getMethod().equals("GET")) {
			// 사용자가 로그인하지 않은 상태에서 요청한 원래의 주소를 세션으로 저장.
			request.getSession().setAttribute("dest", destination);
		}
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		
		super.afterCompletion(request, response, handler, ex);
	}

	
}
