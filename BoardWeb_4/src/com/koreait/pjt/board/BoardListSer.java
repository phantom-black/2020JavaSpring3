package com.koreait.pjt.board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.pjt.Const;
import com.koreait.pjt.MyUtils;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.db.BoardDAO;
import com.koreait.pjt.vo.BoardDomain;

@WebServlet("/board/list")
public class BoardListSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		HttpSession hs = request.getSession();
//				
//		if(null==hs.getAttribute(Const.LOGIN_USER)) {
//			response.sendRedirect("/login");
//			return;
//		}
		
		if(MyUtils.isLogout(request)) {
			response.sendRedirect("/login");
			return;
		}
		
		int page = MyUtils.getIntParameter(request, "page");
		page = page == 0 ? 1 : page; // 까뤼한 삼항식~
		System.out.println("page: "+page);
		
		int eIdx = page * Const.RECORD_CNT;
		int sIdx = eIdx - Const.RECORD_CNT;
		
		BoardDomain param = new BoardDomain();
		param.setPage(page);

		param.seteIdx(eIdx);
		param.setsIdx(sIdx);
		
		param.setRecord_cnt(Const.RECORD_CNT); // 한 페이지당 20개 뿌리겠다
		
		request.setAttribute("pagingCnt", BoardDAO.selPagingCnt(param));
		request.setAttribute("list", BoardDAO.selBoardList(param));
		request.setAttribute("paging", page);
		
		ViewResolver.forwardLoginChk("board/list", request, response);
	}
}
