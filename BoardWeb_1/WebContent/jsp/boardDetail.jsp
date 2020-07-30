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
	String strI_board = request.getParameter("i_board"); // 항상 가져와야만, 어느 글의 디테일인지 알아야하니까, 안보내면 null
	//request -> 요청, 쿼리스트링 값 가져올 때는 getParameter() <- GET/POST방식 둘 다 사용, 동시에 사용하면 GET방식이 우선
	// i_board 값을 쿼리스트링으로 안 보내면 null값 들어감
	if(strI_board == null) {
%>
	<script>
		alert("잘못된 접근입니다.");
		location.href='/jsp/boardList.jsp'
	</script>
<%
	return;
	}
	
	int i_board = Integer.parseInt(strI_board);

	BoardVO vo = new BoardVO();

	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	// String sql = "SELECT title, ctnt, i_student FROM t_board WHERE i_board = " + strI_board;
	String sql = "SELECT title, ctnt, i_student FROM t_board WHERE i_board = ?";
	
	try {
		con = getCon();
		ps = con.prepareStatement(sql);
		
		// ps.setInt(1, 5); // arg0:물음표의 위치값, arg1: 그 자리에 넣을 값
							// 실수 변환은 setDouble():
		// ps.setString(1, strI_board); // 문자열은 자동으로 '5'와 같이 감싸준다
		ps.setInt(1, i_board);
		// 실행 전에 ps에 set 다 해줘야
		rs = ps.executeQuery(); // select문의 결과 가져옴(String으로 리턴), 나머지는 executeUpdate(int로 리턴) 쓰면 됨
		
		
		
		if(rs.next()) { // 0줄일 수도 있으니까 꼭  rs.next()를 해줘야 함, 내용 들어있는지 확인한 후에 값 집어넣어야
			// 순서대로 가져올 필요는 없음, 컬럼명만 똑바로 적어주면 됨
			String title = rs.getNString("title");
			String ctnt = rs.getNString("ctnt");
			int i_student = rs.getInt("i_student");
			
			vo.setI_board(i_board);
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
		<a href="/jsp/boardList.jsp">리스트로 가기</a>
		<a href="#" onclick="procDel(<%= i_board %>)">삭제</a>
	</div>
	<div>
		상세 페이지 : <%= strI_board %>
		<table>
			<tr>
				<th>제목</th>
				<th>내용</th>
				<th>작성자</th>
			</tr>
			<tr>
				<td><%= vo.getTitle() %></td>
				<td><%= vo.getCtnt() %></td>
				<td><%= vo.getI_student() %></td>
			</tr>
		</table>
	</div>
	<script>
		function procDel(i_board) {
			// alert('i_board: '+i_board);
			if( confirm('삭제하시겠습니까?') ) {
				location.href = '/jsp/boardDel.jsp?i_board='+i_board
			}
		}
	</script>
</body>
</html>