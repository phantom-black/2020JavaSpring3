<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.koreait.web.BoardVO" %>

<%!
	//int a = 10; // <%일 때는 메소드 안임, 지역변수이므로 private 못 붙임
	// 메소드 안에 메소드 만들 수 없으므로 <%!와 같이 ! 붙여서 메소드 바깥으로 보내야만
	// request, response 등 내장객체 -> 따로 지정하지 않아도 사용가능
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
	List<BoardVO> boardList = new ArrayList();
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	 
	String sql = " SELECT i_board, title FROM t_board ";
	
	try {
		con = getCon(); // 연결
		ps = con.prepareStatement(sql); // 구문 준비
		rs = ps.executeQuery(); // 실행 
								// select 때만 씀, insert, update, delete 때는 execute()나 executeUpdate() 사용

		while(rs.next()) { // rs.next() <- 행을 가리킴, 안에 내용 잇으면 true, 레코드 있으면 계속 반복
			int i_board = rs.getInt("i_board"); // getInt() <- ()안에 컬럼명
			String title = rs.getNString("title");
			
			BoardVO vo = new BoardVO();
			vo.setI_board(i_board);
			vo.setTitle(title);
			
			boardList.add(vo);
		}
		
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		if(rs != null) { try { rs.close(); } catch(Exception e) {} }
		if(ps != null) { try { ps.close(); } catch(Exception e) {} }
		if(con != null) { try { con.close(); } catch(Exception e) {} }
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>
<body>
	<div>게시판 리스트</div>
	<table>
		<tr>
			<th>No</th>
			<th>제목</th>
		</tr>
		
		<% for(BoardVO vo : boardList) { %>
		<tr>
			<td><%= vo.getI_board() %></td>
			<td><%= vo.getTitle() %></td>
		</tr>
		<% } %>

	</table>
</body>
</html>