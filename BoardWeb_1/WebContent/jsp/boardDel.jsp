<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%!
	Connection getCon() throws Exception {
		String url="jdbc:oracle:thin:@localhost:1521:orcl";
		String username="hr";
		String password="koreait2020";
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con = DriverManager.getConnection(url, username, password); // 주솟값
		
		System.out.println("접속 성공!");
		return con;
	}
%>
<%
	String strI_board = request.getParameter("i_board");
	int i_board = Integer.parseInt(strI_board);
	Connection con = null;
	PreparedStatement ps = null;
	
	String sql = "DELETE FROM t_board WHERE i_board = ?";
	// 자바에서 날리는 건 기본적으로 auto commit <- 자동으로 커밋됨, 끄려면 따로 세팅해줘야
	int result = -1; // 문법 오류 나면 -1, 값 없으면 -, 값 있으면 1
	try {
		con = getCon();
		ps = con.prepareStatement(sql);
		ps.setInt(1, i_board);
		
		result = ps.executeUpdate();
		
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		if(ps != null) { try { ps.close(); } catch(Exception e) {} }
		if(con != null) { try { con.close(); } catch(Exception e) {} }
	}
	
	System.out.println("result: "+result);
	switch(result) {
	case -1:
		response.sendRedirect("/jsp/boardDetail.jsp?err=-1&i_board="+i_board);
		break;
	case 0:
		response.sendRedirect("/jsp/boardDetail.jsp?err=0&i_board="+i_board);
		break;
	case 1:
		response.sendRedirect("/jsp/boardList.jsp");
		break;
	}
%>