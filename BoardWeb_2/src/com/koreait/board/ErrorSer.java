package com.koreait.board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/errPage")
public class ErrorSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String err = request.getParameter("err");
		String target = request.getParameter("target");
		String msg = null;
		
		switch(err) {
			case "1":
				msg = "삭제할 수 없습니다.";
				break;
			case "2":
				msg = "잘못된 접근입니다.";
				break;
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("target", target);
		
		String jsp = "/WEB-INF/view/errPage.jsp";
		request.getRequestDispatcher(jsp).forward(request, response);
	}
}