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
	<div class="welcome">${loginUser.nm}님, 환영합니다! <a href="/logout">로그아웃</a></div>
	<div>
		<a href="/regmod">글쓰기</a>
	</div>
	<h1>리스트</h1>
	<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>조회수</th>
			<th>작성자</th>
			<th>등록일시</th>
		</tr>
		<c:forEach items="${list}" var="item">
		<tr class="itemRow" onclick="moveToDetail(${item.i_board})">
			<td>${item.i_board}</td>
			<td>${item.title}</td>
			<td>${item.hits}</td>
			<td>${item.i_user}</td>
			<td>${item.r_dt}</td>
		</tr>
		</c:forEach>
	</table>
		<script>
		function moveToDetail(i_board) {
			//console.log("moveToDetail = i_board: " + i_board)
			location.href = "/board/detail?i_board=" + i_board
		}
	</script>
</body>
</html>