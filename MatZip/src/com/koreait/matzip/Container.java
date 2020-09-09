package com.koreait.matzip;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/")
public class Container extends HttpServlet { // 호출은 tomcat이
	private static final long serialVersionUID = 1L;
	
	private HandlerMapper mapper;
	
	public Container() { // 기본생성자
		mapper = new HandlerMapper();
	}
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		System.out.println("uri : " + request.getRequestURI());
//		String[] uriArr = request.getRequestURI().split("/");
//		
//		for(int i=0; i<uriArr.length; i++) {
//			System.out.println("uriArr[" + i + "] : " + uriArr[i]);	
//		}
		
		proc(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		proc(request, response);
	}

	// proc로 몰아주면 관리하기 편함
	private void proc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String temp = mapper.nav(request); // 보통 템플릿 파일명
		
		if(temp.indexOf(":") >= 0) {
			String prefix = temp.substring(0, temp.indexOf(":"));
			String value = temp.substring(temp.indexOf(":") + 1);
			
			System.out.println("prefix: " + prefix);
			System.out.println("value: " + value);
			
			if("redirect".equals(prefix)) {
//				System.out.println("sub : " + temp.substring(0, temp.indexOf("/")));
				response.sendRedirect(value);
				return;
				
			} else if("ajax".equals(prefix)) {
				response.setCharacterEncoding("UTF-8");
				response.setContentType("application/json");
				PrintWriter out = response.getWriter();
				
				System.out.println("value: " + value);
				out.print(value);
				return;
			}
		}
		
		switch(temp) {
		case "405":
			temp = "/WEB-INF/view/error.jsp";
			break;
		case "404":
			temp = "/WEB-INF/view/notFound.jsp";
			break;
		}
		
		request.getRequestDispatcher(temp).forward(request,  response);
	}
}