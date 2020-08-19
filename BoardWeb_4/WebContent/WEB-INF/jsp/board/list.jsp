<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리스트</title>
<style>
	table {
		border-collapse: collapse;
		border: 1px solid #000; 
	 }
	 th, td { border: 1px solid #000; }
	.itemRow:hover { background-color: #ecf-f1; cursor : pointer; }
</style>
</head>
<body>
	<div class="welcome">${loginUser.nm}님, 환영합니다!</div>
	<div>
		<a href="/regmod">글쓰기</a>
	</div>
	<h1>리스트</h1>
	<table>
		<tr>
			<th>No</th>
			<th>글 제목</th>
			<th>조회수</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
		<c:forEach items="${list}" var="item">
		<tr>
			<td>${item.i_board}</td>
			<td>${item.title}</td>
			<td>${item.hits}</td>
			<td>${item.i_user}</td>
			<td>${item.r_dt}</td>
		</tr>
		</c:forEach>
	</table>
</body>
</html>