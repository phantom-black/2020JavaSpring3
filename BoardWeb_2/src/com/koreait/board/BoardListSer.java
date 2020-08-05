package com.koreait.board;

import java.io.IOException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.board.db.BoardDAO;
import com.koreait.board.vo.BoardVO;

@WebServlet("/boardList") // <- 원하는 주솟값 적어주면 주소 맵핑됨, jsp container가 들고 있다가 저 주솟값 분석해서 연결된 객체에 Get/Post방식으로 보낼 때에 각각의 메소드를 실행  
									  // 원래는 보안상 파일명과 이름 다르게 해야 함, 파일명 유추할 수 없도록 해야
									  // 여기에 웹서블릿 주소 안 적을 거면 xml에 엄청 길게 적어야 함
public class BoardListSer extends HttpServlet {
	private static final long serialVersionUID = 1L; // 멤버필드
       
    /*public BoardListSer() {	// 파라미터를 받지 않는 생성자 = 기본생성자   1. 클래스명과 동일  2. 리턴타입 적으면 안된다
        super(); // super 바로 위의 부모, this는 나 자신    super/this 옆에 괄호() 있으면 -> 생성자
    }*/

    @Override // 있으면 실수 방지 -> 적어주는 게 좋다
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// 고객이 나한테 보낸 모든 정보가 request에 담겨 있음
    	
    	List<BoardVO> list = BoardDAO.selBoardList(); // 객체지향 -> 객체에게 일 시킴
    	request.setAttribute("data", list);
    	
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/boardList.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
