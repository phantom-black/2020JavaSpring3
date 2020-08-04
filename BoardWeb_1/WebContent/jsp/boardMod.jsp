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
	String strI_board = request.getParameter("i_board");
	int i_board = Integer.parseInt(strI_board);
	
	BoardVO vo = new BoardVO();
	
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	String sql = " SELECT title, ctnt, i_student FROM t_board WHERE i_board = ? ";
	
	try {
		con = getCon();
		ps = con.prepareStatement(sql);
		ps.setInt(1, i_board);
		rs = ps.executeQuery();
		
		if(rs.next()) {
			String title = rs.getNString("title");
			String ctnt = rs.getNString("ctnt");
			int i_student = rs.getInt("i_student");
			
			vo.setTitle(title);
			vo.setCtnt(ctnt);
			vo.setI_student(i_student);
		}
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		if(rs != null) { try{ rs.close(); } catch(Exception e) {} }
		if(ps != null) { try{ ps.close(); } catch(Exception e) {} }
		if(con != null) { try{ con.close(); } catch(Exception e) {} }
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정</title>
</head>
<body>
	<div>
		<form id="frm" action="/jsp/boardModProc.jsp" method="post" onsubmit="return chk()">
			<input type="hidden" name="i_board" value="<%= i_board %>">
			<div><label>제목: <input type="text" name="title" value="<%= vo.getTitle() %>"></label></div>
			<div><label>내용: <textarea name="ctnt"><%= vo.getCtnt() %></textarea></label></div>
			<div><label>작성자: <input type="text" name="i_student" value="<%= vo.getI_student() %>"></label></div>
			<div><input type="submit" value="글 수정"></div>
		</form>
	</div>
</body>
</html>