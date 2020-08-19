package com.koreait.pjt.board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.koreait.pjt.Const;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.db.BoardDAO;
import com.koreait.pjt.vo.BoardVO;
import com.koreait.pjt.vo.UserVO;

@WebServlet("/regmod")
public class BoardRegmodSer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// 화면 띄우는 용도(등록창/수정창)
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession hs = request.getSession();
		if(null==hs.getAttribute(Const.LOGIN_USER)) {
			response.sendRedirect("/login");
			return;
		}
		
		ViewResolver.forward("/board/regmod", request, response); // 파일 담당, 파일명 넣어야
	}

	// 처리 용도(DB에 등록/수정) 실시
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String ctnt = request.getParameter("ctnt");
		
		System.out.println("title: "+title);
		System.out.println("ctnt: "+ctnt);
		
		HttpSession hs = request.getSession();
		UserVO loginUser = (UserVO)hs.getAttribute(Const.LOGIN_USER);
		
		BoardVO param = new BoardVO();
		param.setTitle(title);
		param.setCtnt(ctnt);
		param.setI_user(loginUser.getI_user());
		
		int result = BoardDAO.insBoard(param);
		System.out.println("result: " + result);
		
		if(result != 1) {
			String msg = "에러가 발생하였습니다. 문제가 계속 발생한다면 관리자에게 문의하십시오.";
			
			request.setAttribute("msg", msg);
			request.setAttribute("data", param);
			
			doGet(request, response);
			return;
		}
		
		response.sendRedirect("/board/list"); // 주소 이동, VIewResolver는 파일 여는 것->로그인체크 다시 해줘야 함
	}

}
