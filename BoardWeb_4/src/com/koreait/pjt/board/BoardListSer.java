package com.koreait.pjt.board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.koreait.pjt.MyUtils;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.db.BoardDAO;
import com.koreait.pjt.vo.BoardDomain;
import com.koreait.pjt.vo.UserVO;

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
		//
//		HttpSession hs = (HttpSession)request.getSession();
		
		UserVO loginUser = MyUtils.getLoginUser(request);
		if(loginUser == null) {
			response.sendRedirect("/login");
			return;
		}
		
		// 제목/내용/제목내용 검색 옵션
		String searchType = request.getParameter("searchType");
		searchType = (searchType == null) ? "a" : searchType;
		
		// 검색 내용
		String searchText = request.getParameter("searchText");
		searchText = (searchText == null ? "" : searchText);
		
		// 페이징
		int page = MyUtils.getIntParameter(request, "page");
		page = (page == 0 ? 1 : page);
		
		int recordCnt = MyUtils.getIntParameter(request, "record_cnt");
		recordCnt = (recordCnt == 0 ? 10 : recordCnt);
		
		
		BoardDomain param = new BoardDomain();
		param.setI_user(loginUser.getI_user());
		param.setRecord_cnt(recordCnt);
		param.setSearchType(searchType);
		param.setSearchText("%"+searchText+"%");
		int pagingCnt = BoardDAO.selPagingCnt(param);
		
//		Integer beforeRecordCnt = (Integer)hs.getAttribute("recordCnt"); // 이전 레코드수 가져오기
		
		//이전 레코드수 값이 있고, 이전 레코드수보다 변경한 레코드 수가 더 크다면 마지막 페이지수로 변경
//		if(beforeRecordCnt != null && beforeRecordCnt < recordCnt) {  
//			page = pagingCnt; // 마지막 페이지 값으로 변경
//		}
		if(page > pagingCnt) {
			page = pagingCnt; // 마지막 페이지 값으로 변경
		}
		request.setAttribute("searchType", searchType);
		request.setAttribute("page", page);
		System.out.println("page : " + page);
		
		int eIdx = page * recordCnt;
		int sIdx = eIdx - recordCnt;
		
		param.setsIdx(sIdx);
		param.seteIdx(eIdx);
		
		request.setAttribute("pagingCnt", pagingCnt);
		
		List<BoardDomain> list = BoardDAO.selBoardList(param);
		//하이라이트 처리
		if(!"".equals(searchText) && "a".equals(searchType) || "c".equals(searchType)) {
			for(BoardDomain item : list) {
					String title = item.getTitle();
					title = title.replace(searchText
							, "<span class=\"highlight\">" + searchText + "</span>");
					item.setTitle(title);
			}
		}
		
		request.setAttribute("list", list);
		
//		hs.setAttribute("recordCnt", recordCnt); // 현재 레코드수 저장
		ViewResolver.forward("board/list", request, response);
	}
}
