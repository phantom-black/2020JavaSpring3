<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리스트</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
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
	.containerPImg {
		display: inline-block;
		width: 30px;
		height: 30px;
		border-radius: 50%;
		overflow: hidden;
	}
	.pImg {
		object-fit: cover;
		width: 100%;
		height: 100%;
	}
	.highlight {
		color: red;
		font-style: italic;
		font-weight: bold;
	}
	#id_like { 
		position: relative; 
	}
	#likeListContainer {
		position: absolute;
		left: 0px;
		top: 35px;
		width: 130px;
		height: 150px;
		padding: 5px;
		border: 1px solid #bdc3c7;
		overflow-y: auto;
		background-color: #faf9f7;
		display: none;
	}
</style>
</head>
<body>
	<div class="container">
		<div class="usr-name">
			<span id="usr-color">${loginUser.nm}</span>님 환영합니다
			<a href="/profile">프로필</a>
			<a href="/logout"><button id="logout">로그아웃</button></a>
		</div>
		<div>
			<form id="selFrm" action="/board/list" method="get">
				<input type="hidden" name="page" value="${page}">
				<input type="hidden" name="searchText" value="${param.searchText}">
				레코드 수 :
				<select name="record_cnt" onchange="changeRecordCnt()">
					<c:forEach begin="10" end="30" step="10" var="item">
						<c:choose>
							<c:when test="${param.record_cnt == item}">
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
				<th>좋아요</th>
				<th> </th>
				<th> </th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
			<c:forEach items="${list}" var="item">
				<tr class="itemRow">
					<td onclick="moveToDetail(${item.i_board})">${item.i_board}</td>
					<td onclick="moveToDetail(${item.i_board})">${item.title} (${item.cmt_cnt})</td>
					<td>${item.hits} </td>
					<td><span onclick="getLikeList(${item.i_board}, ${item.like_cnt}, this)">${item.like_cnt}</span></td>
					<td>
						<c:if test="${item.yn_like==0 }">
	                		<span class="material-icons">favorite_border</span>
	                	</c:if>
	                	<c:if test="${item.yn_like==1 }">
	                		<span class="material-icons">favorite</span>
	                	</c:if>
					</td>
					<td>
						<div class="containerPImg">
							<c:choose>
								<c:when test="${item.profile_img != null}">
									<img class="pImg" src="/img/user/${item.i_user}/${item.profile_img}">
								</c:when>
								<c:otherwise>
									<img class="pImg" src="/img/default_profile.jpg">
								</c:otherwise>
							</c:choose>
						</div>
					</td>
					<td>${item.nm}</td>
					<td>${item.r_dt}</td>
				</tr>
			</c:forEach>
		</table>
		<div>
			<form action="/board/list">
				<select name="searchType">
					<option value="a" ${searchType == 'a' ? 'selected' : ''}>제목</option>
					<option value="b" ${searchType == 'b' ? 'selected' : ''}>내용</option>
					<option value="c" ${searchType == 'c' ? 'selected' : ''}>제목+내용</option>
				</select>
				<input type="search" name="searchText" value="${param.searchText}">
				<input type="submit" value="검색">
			</form>
		</div>
		<div class="fontCenter">
			<c:forEach begin="1" end="${pagingCnt}" var="item">
				<c:choose>
					<c:when test="${page == item}">
						<span class="pageSelected">${item}</span>
					</c:when>
					<c:otherwise>
						<span>
							<a href="/board/list?page=${item}&record_cnt=${param.record_cnt}&searchText=${param.searchText}&searchType=${searchType}">${item}</a>
						</span>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
		<div>
			<a href="/regmod"><button id="write">글작성</button></a>
		</div>
	</div>
	<div id="likeListContainer">
	</div>
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
	<script>
		let beforeI_board = 0
		function getLikeList(i_board, cnt, span) {
			console.log("i_board: " + i_board)

			if(cnt == 0) { return }
			
			if(beforeI_board == i_board) {
				likeListContainer.style.display = 'none'
				return
			} else if(beforeI_board != i_board) {
				beforeI_board = i_board
				likeListContainer.style.display = 'unset'
			}
			
			const locationX = window.scrollX + span.getBoundingClientRect().left
			const loactionY = window.scrollY + span.getBoundingClientRect().top + 30
			
			likeListContainer.style.left = `\${locationX}px`
			likeListContainer.style.top = `\${loactionY}px`
			
			likeListContainer.style.opacity = 1
			likeListContainer.innerHTML = ""
			
			axios.get('/board/like', {
				params: {
					i_board: i_board // key와 변수명이 같을 때는 i_board만 적어도 됨
				}
			}).then(function(res) { // axios.post 하면 포스트 방식으로 날리는 것
				if(res.data.length > 0) {
					for(let i=0; i<res.data.length; i++) {
						const result = makeLikeUser(res.data[i])
						likeListContainer.innerHTML += result
					}
				}
			})
		}
		
		function makeLikeUser(one) {
			const img = one.profile_img == null ? 
					'<img class="pImg" src="/img/default_profile.jpg">'
					:
					`<img class="pImg" src="/img/user/\${one.i_user}/\${one.profile_img}">`
			
			const ele = `<div class="likeItemContainer">
									<div class="profileContainer">
										<div class="profile">
											\${img}
										</div>
									</div>
									<div class="nm">\${one.nm}</div>
								</div>
								`
			return ele
		}
	
		function changeRecordCnt() {
			selFrm.submit()
		}
	
		function moveToDetail(i_board) {
			location.href = '/board/detail?page=${page}&record_cnt=${param.record_cnt}&searchType=${searchType}&searchText=${param.searchText}&i_board=' + i_board
		}
	</script>
</body>
</html>