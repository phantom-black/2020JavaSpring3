<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리스트</title>
<style>
	* {
		font-family: 'Noto Sans KR', sans-serif;
	}
	*:focus { 
		outline:none; 
	}
	body{
		background-color: #faf9f7;
	}
	.container {
		width: 800px;
		margin: 0 auto; 
		padding: 20px;
	}
	.usr-name {
		text-align: right;
	}
	#usr-color {
		color: #ef9173;
		font-weight: bold;
	}
	table {
		width: 800px;
		margin: 70px auto; 
		border: 0.5px solid #58585a;
		border-collapse: collapse;
	}
	tr, td{
		text-align : center;
		padding: 7px;
	}
	th {
		text-align : center;
		padding: 7px;
		border-bottom: 0.5px solid #58585a;
	}
	.itemRow:hover {
		background: #f5d1ca;
		cursor : pointer;
	}
	button a {
		color: #58585a;
		text-decoration: none;
	}
	#logout {
		background-color: #f5d1ca;
		text-align: center;
		padding: 5px;
		color: #58585a;
		border: none;
		border-radius: 10px;
		font-weight: bold;
	}
	#write {
		width: 100px;
		background-color: #f5d1ca;
		text-align: center;
		border: none;
		padding: 8px;
		color: #58585a;
		border-radius: 10px;
		font-weight : bold;
	}
	.pointerCursor {
		cursor: pointer;
	}
</style>
</head>
<body>
	
	<div class="container">
		<div class="usr-name">
			<span id="usr-color">${loginUser.nm}</span>님 환영합니다
			<button id="logout"><a href="/logout">로그아웃</a></button>
		</div>
		<table>
			<tr>
				<th>No</th>
				<th>제목</th>
				<th>조회수</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
			<c:forEach items="${list}" var="item">
				<tr class="itemRow" onclick="moveToDetail(${item.i_board})">
					<td>${item.i_board}</td>
					<td>${item.title}</td>
					<td>${item.hits}</td>
					<td>${item.nm}</td>
					<td>${item.r_dt}</td>
				</tr>
			</c:forEach>
		</table>
		<div>
			<a href="/regmod"><button id="write" class="pointerCursor">글작성</button></a>
		</div>
	</div>
	<script>
		function moveToDetail(i_board) {
			location.href = '/board/detail?i_board=' + i_board
		}
	</script>
</body>
</html>