package com.koreait.board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.board.common.Utils;
import com.koreait.board.db.BoardDAO;
import com.koreait.board.vo.BoardVO;

/**
 * Servlet implementation class BoardWriteSer
 */
@WebServlet("/boardWrite")
public class BoardWriteSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String jsp = "/WEB-INF/view/boardRegmod.jsp";
		request.getRequestDispatcher(jsp).forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String ctnt = request.getParameter("ctnt");
		String strI_student = request.getParameter("i_student");
		
		// 단위테스트, 에러 빨리 찾을 수 있음, 값이 잘 넘어왔는지 꼭 테스트해보고 넘어가기
		System.out.println("title: "+title);
		System.out.println("ctnt: "+ctnt);
		System.out.println("strI_student: "+strI_student);
		
		BoardVO param = new BoardVO();
		param.setTitle(title);
		param.setCtnt(ctnt);
		param.setI_student(Utils.parseStrToInt(strI_student));
		
		int result = BoardDAO.insBoard(param);
		System.out.println("result: " + result);

		
		if(result == 1) { // 정상
			response.sendRedirect("/boardList");
		} else {
			request.setAttribute("msg", "에러가 발생하였습니다.");
			doGet(request, response);
		}
		
		
	}

}
