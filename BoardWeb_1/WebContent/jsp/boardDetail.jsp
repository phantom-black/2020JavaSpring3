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
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	BoardVO vo = new BoardVO();
	
	String strI_board = request.getParameter("i_board");
	// request -> 요청, 쿼리스트링 값 가져올 때는 getParameter() <- GET/POST방식 둘 다 사용, 동시에 사용하면 GET방식이 우선
	
	String sql = "SELECT title, ctnt, i_student FROM t_board WHERE i_board = " + strI_board;
	
	try {
		con = getCon();
		ps = con.prepareStatement(sql);
		rs = ps.executeQuery();
		
		if(rs.next()) {
			String title = rs.getNString("title");
			String ctnt = rs.getNString("ctnt");
			int i_student = rs.getInt("i_student");
			
			vo.setI_board(Integer.parseInt(strI_board));
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
<title>상세 페이지</title>
</head>
<body>
	<div>
		상세 페이지 : <%= strI_board %>
		<table>
			<tr>
				<th>No</th>
				<th>제목</th>
				<th>내용</th>
				<th>작성자</th>
			</tr>
			<tr>
				<td><%= vo.getI_board() %></td>
				<td><%= vo.getTitle() %></td>
				<td><%= vo.getCtnt() %></td>
				<td><%= vo.getI_student() %></td>
			</tr>
		</table>
	</div>
</body>
</html>