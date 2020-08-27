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
	a {
		text-decoration: none;
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
	.fontCenter {
		text-align: center;
	}
	.pageSelected {
		font-size: 20px;
		font-weight: bold;
		/*pointer-events: none;*/ 
	}
</style>
</head>
<body>
	
	<div class="container">
		<div class="usr-name">
			<span id="usr-color">${loginUser.nm}</span>님 환영합니다
			<a href="/logout"><button id="logout">로그아웃</button></a>
		</div>
		<div>
			<form id="selFrm" action="/board/list" method="get">
				<input type="hidden" name="page" value="${param.page == null ? 1 : param.page}">
				레코드 수 : 
				<select name="record_cnt" onchange="changeRecordCnt()">
					<c:forEach begin="10" end="30" step="10" var="item">
						<c:choose>
							<c:when test="${param.record_cnt == item || param.record_cnt == null }">
								<option value="${item}" selected>${item}개</option>
							</c:when>
							<c:otherwise>
								<option value="${item}">${item}개</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
			</form>
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
		<div class="fontCenter">
			<c:forEach begin="1" end="${pagingCnt}" var="item">
				<c:choose>
					<c:when test="${param.page == item || (param.page == null && item == 1)}">
						<span class="pageSelected">${item}</span>
					</c:when>
					<c:otherwise>
						<span><a href="/board/list?page=${item}">${item}</a></span>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
		<div>
			<a href="/regmod"><button id="write" class="pointerCursor">글작성</button></a>
		</div>
	</div>
	<script>	
		function changeRecordCnt() {
			selFrm.submit()
		}
	
		function moveToDetail(i_board) {
			location.href = '/board/detail?i_board=' + i_board
		}
	</script>
</body>
</html>