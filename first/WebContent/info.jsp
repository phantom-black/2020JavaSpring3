<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.koreait.first.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
	Class.forName("oracle.jdbc.driver.OracleDriver");

	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String userName = "hr";
	String password = "koreait2020";
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	String sql = "SELECT * FROM countries";
	
	List<CountriesVO> list = new ArrayList();
	
	try {
		con = DriverManager.getConnection(url, userName, password);
		ps = con.prepareStatement(sql);
		rs = ps.executeQuery();
		
		while(rs.next()) {
			String country_id = rs.getString("country_id");
			String country_name = rs.getString("country_name");
			int region_id = rs.getInt("region_id");
			
			CountriesVO vo = new CountriesVO();
			vo.setCountry_id(country_id);
			vo.setCountry_name(country_name);
			vo.setRegion_id(region_id);
			
			list.add(vo);
		}
		
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		try {
			rs.close();
			ps.close();
			con.close();
		} catch(Exception e) {}
	}
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Info</title>
</head>
<body>
	<div>나라 정보</div>
	<div>
		<table>
			<tr>
				<th>country_id</th>
				<th>나라명</th>
				<th>지역ID</th>
			</tr>
			
			<%for(CountriesVO vo : list) { %>
				<tr>
					<th><%=vo.getCountry_id() %></th>
					<th><%=vo.getCountry_name() %></th>
					<th><%=vo.getRegion_id() %></th>
				</tr>
			<% } %>
		</table>
	</div>
</body>
</html>