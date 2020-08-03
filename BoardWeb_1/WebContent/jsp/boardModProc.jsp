<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.koreait.web.BoardVO" %>
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
	// request.setCharacterEncoding("UTF-8");
	String title = request.getParameter("title");
	String ctnt = request.getParameter("ctnt");
	String strI_student = request.getParameter("i_student");
	
	if( "".equals(title) || "".equals(ctnt) || "".equals(strI_student) ) {
		response.sendRedirect("/jsp/boardWrite.jsp?err=10");
		return;
	}
	
	int i_student = Integer.parseInt(strI_student);
	
	Connection con = null;
	PreparedStatement ps = null;
	
	String sql = " INSERT INTO t_board (i_board, title, ctnt, i_student) "
				+ " SELECT nvl(max(i_board), 0) + 1, ?, ?, ? "
				+ " FROM t_board ";
	
	int result = -1;
	try {
		con = getCon();
		ps = con.prepareStatement(sql);
		
		ps.setNString(1, title);
		ps.setNString(2, ctnt);
		ps.setInt(3, i_student);
		
		result = ps.executeUpdate();

	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		if(ps != null) { try{ ps.close(); } catch(Exception e) {} }
		if(con != null) { try{ con.close(); } catch(Exception e) {} }
	}
	
	System.out.println("result: "+result);
	
	int err = 0;
	switch(result) {
		case 1:
			response.sendRedirect("/jsp/boardList.jsp");
			return; 
		case 0:
			err = 10;
			break;
		case -1:
			err = 20;
			break;
	}
	response.sendRedirect("/jsp/boardWrite.jsp?err="+err);
	return;
%>