package com.koreait.pjt.board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.koreait.pjt.Const;
import com.koreait.pjt.MyUtils;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.db.BoardDAO;
import com.koreait.pjt.vo.BoardDomain;
import com.koreait.pjt.vo.BoardVO;
import com.koreait.pjt.vo.UserVO;

@WebServlet("/regmod")
public class BoardRegmodSer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// 화면 띄우는 용도(등록창/수정창)
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		HttpSession hs = request.getSession();
//		if(null==hs.getAttribute(Const.LOGIN_USER)) {
//			response.sendRedirect("/login");
//			return;
//		}
		if(MyUtils.isLogout(request)) {
			response.sendRedirect("/login");
			return;
		}
		
		String strI_board = request.getParameter("i_board");
		
		if(strI_board != null) {
			int i_board = MyUtils.parseStrToInt(strI_board);
			BoardVO param = new BoardVO();
			param.setI_board(i_board);
			request.setAttribute("data", BoardDAO.selBoard(param));
		}

		ViewResolver.forwardLoginChk("board/regmod", request, response); // 파일 담당, 파일명 넣어야
	}

	// 처리 용도(DB에 등록/수정) 실시
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String strI_board = request.getParameter("i_board"); // ""가 넘어옴
		String title = request.getParameter("title");
		String ctnt = request.getParameter("ctnt");
		
		UserVO loginUser = MyUtils.getLoginUser(request);
		
		System.out.println("title: "+title);
		System.out.println("ctnt: "+ctnt);
		
		String filterCtnt1 = scriptFilter(ctnt);
		String filterCtnt2 = swearWordFilter(filterCtnt1);
		
		BoardVO param = new BoardVO();
		param.setTitle(title);
		param.setCtnt(filterCtnt2);
		param.setI_user(loginUser.getI_user());
		
		int result=0;
		
		if("".equals(strI_board)) { // 등록
			result = BoardDAO.insBoard(param);
			response.sendRedirect("/board/list"); // 주소 이동, VIewResolver는 파일 여는 것->로그인체크 다시 해줘야 함
		} else { // 수정
			int i_board = MyUtils.parseStrToInt(strI_board);
			param.setI_board(i_board);
			result = BoardDAO.updBoard(param);
			System.out.println("result: " + result);
			response.sendRedirect("/board/detail?i_board="+strI_board);
		}
		
//		if(result != 1) {
//			String msg = "에러가 발생하였습니다. 문제가 계속 발생한다면 관리자에게 문의하십시오.";
//			
//			request.setAttribute("msg", msg);
//			request.setAttribute("data", param);
//			
//			doGet(request, response);
//			return;
//		}
	}
	
	// 욕 필터
	private String swearWordFilter(final String ctnt) {
		String[] filters = {"개새끼", "미친년", "ㄱㅐㅅㅐㄲㅣ"};
		String result = ctnt;
		for(int i=0; i<filters.length; i++) {
			result = result.replace(filters[i], "**");
		}
		return result;
	}
	
	// 스크립트 필터
		private String scriptFilter(final String ctnt) {
			String[] filters = {"<script>", "</script>"};
			String[] filterReplaces = {"&lt;script&gt;", "/&lt;script&gt;"};
			
			String result = ctnt;
			for(int i=0; i<filters.length; i++) {
				result = result.replace(filters[i], filterReplaces[i]);
			}
			return result;
		}
}
