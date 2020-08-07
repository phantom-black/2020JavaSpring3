package com.koreait.board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.koreait.board.db.BoardDAO;
import com.koreait.board.vo.BoardVO;
import com.koreait.board.common.Utils;

/**
 * Servlet implementation class BoardDetailSer
 */
@WebServlet("/boardDetail") // location이라고 부름
public class BoardDetailSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String strI_board = request.getParameter("i_board");
		
		int i_board = Utils.parseStrToInt(strI_board);
		if(i_board == 0) {
			response.sendRedirect("/boardList");
			return;
		}
		
		BoardVO param = new BoardVO();
		param.setI_board(i_board);
		
		BoardVO data = BoardDAO.selBoard(param); // 수정이 유연해짐, 다른 값을 또 보내야 할 때...! 파라미터 안에 담아뒀기 때문에 파라미터 수정할 필요 없어짐
		
		request.setAttribute("data", data);
		
		String jsp = "/WEB-INF/view/boardDetail.jsp";
		request.getRequestDispatcher(jsp).forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
