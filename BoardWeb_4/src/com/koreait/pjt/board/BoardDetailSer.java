package com.koreait.pjt.board;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.pjt.MyUtils;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.db.BoardDAO;
import com.koreait.pjt.vo.UserVO;


@WebServlet("/board/detail")
public class BoardDetailSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserVO loginUser = MyUtils.getLoginUser(request);
		if(loginUser==null) {
			response.sendRedirect("/login");
			return;
		}

		String strI_board = request.getParameter("i_board");
		int i_board = MyUtils.parseStrToInt(strI_board);
		
		// 단독으로 조회수 올리기 방지! --- [start]
		ServletContext application = getServletContext(); // 어플리케이션 내장객체 얻어오기
													// getServletContext()는 부모인 HttpServlet으로부터 상속받은 메소드
		Integer readI_user = (Integer)application.getAttribute("read_" + strI_board); // Integer(객체형) : int(일반변수)와 같이 쓰지만 null 담을 수 있다
		
		if(readI_user==null || readI_user != loginUser.getI_user()) { // int와 Integer 값 비교 가능
			// 조회수를 올려주세요!!
			BoardDAO.addHits(i_board);
			
			application.setAttribute("read_"+strI_board, loginUser.getI_user());
		}
		// 단독으로 조회수 올리기 방지! --- [end]
		
		request.setAttribute("data", BoardDAO.selBoard(i_board));
		ViewResolver.forward("board/detail", request, response); // 주솟값 아니라 파일명
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
