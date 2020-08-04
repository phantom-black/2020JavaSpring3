<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String strI_board = request.getParameter("i_board");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리스트</title>
</head>
<body>
	<div>리스트</div>
	<div><%=strI_board %></div>
</body>
</html>