<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상세페이지</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link
	    rel="stylesheet"
	    href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.0.0/animate.min.css"
	  />
    <style>
        * {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #faf9f7;
        }
        *:focus { outline: none; }
        .container {
            width: 800px;
            margin: 30px auto;
        }
        table {
            border: 1px solid black;
            border-collapse: collapse;
        }
        th, td {
            /* border: 1px solid black; */
            padding: 8px;
        }
        #title {
            border-bottom: 1px solid #58585a;
        }
        /* .boardInfo {
            border-bottom: 1px solid #58585a;
        } */
        #nm {
            width: 10%;
        }
        #nm-1 {
            width: 23%;
        }
        #date {
            width: 10%;
        }
        #date-1 {
            width: 20%;
        }
        #hits {
            width: 10%;
        }
        #hits-1 {
            width: 5%;
        }
        #ynLike {
        	width: 5%;
        }
        #likeCnt {
        	width: 17%;
        	font-size: 12px;
        	line-height: 15px;
        }
        #likeCnt span {
        	font-weight: bold;
        	font-size: 18px;
        	color: #6fa8aa;
        }
        .ctnt {
            border-right: 1px solid #58585a;
            border-left: 1px solid #58585a;
            border-bottom: 1px solid #58585a;
            height: 200px;
            padding: 10px;
        }
        .btn a {
  			display: inline-block;
  			width: 100px;
            text-decoration: none;
            color: #58585a;
            background-color: #f5d1ca;
            text-align: center;
            border: none;
            padding: 8px;
            border-radius: 10px;
            margin-top: 20px;
            margin-right: 20px;
            font-weight: bold;
            font-size: 0.9em;
        }
        .btn button {
        	cursor: pointer;
            display: inline-block;
  			width: 100px;
            text-decoration: none;
            color: #58585a;
            background-color: #f5d1ca;
            text-align: center;
            border: none;
            border-radius: 10px;
            font-weight: bold;
            font-size: 0.9em;
        }
        #delFrm {
            display: inline-block;
        }
        .pointerCursor { 	cursor: pointer; }
        .material-icons { color: #f00; }
        .marginTop30 { margin-top: 30px; }
        
        /* 댓글창 */
        #cmt { width: 690px; }
        .cmtTable { width: 800px; }
        .cmtTable th { border-bottom: 1px solid #000; }
        
        .cmtCtnt { width: 45%; }
        .cmtUser { width: 20%; }
        .cmtDate { width: 15%; }
        .cmtBtn { width: 20%; }
        
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
			opacity: 0;
			transition-duration: 500ms;
		}
		#id_like:hover #likeListContainer {
			opacity: 1;
		}
    </style>
</head>

<body>
    <div class="container">
        <table>
            <tr id="title">
                <th>제목</th>
                <th colspan="7" id="elTitle">${data.title}</th>
            </tr>
            <tr class="boardInfo">
                <th id="nm">작성자</th>
                <td id="nm-1">
                	<div class="containerPImg">
						<c:choose>
							<c:when test="${data.profile_img != null}">
								<img class="pImg" src="/img/user/${data.i_user}/${data.profile_img}">
							</c:when>
							<c:otherwise>
								<img class="pImg" src="/img/default_profile.jpg">
							</c:otherwise>
						</c:choose>
					</div>
                	${data.nm }
                </td>
                <th id="date">작성일시</th>
                <td id="date-1"> ${data.r_dt } <small>${data == null ? '' : '수정' }</small> </td>
                <th id="hits">조회수</th>
                <td id="hits-1">${data.hits }</td>
                <td id="ynLike" class="pointerCursor" onclick="toggleLike(${data.yn_like})">
                	<c:if test="${data.yn_like==0 }">
                		<span class="material-icons">favorite_border</span>
                	</c:if>
                	<c:if test="${data.yn_like==1 }">
                		<span class="material-icons">favorite</span>
                	</c:if>
                </td>
                <td id="likeCnt">
                	<c:if test="${data.like_cnt > 0}">
                		<div id="id_like"  class="pointerCursor">
                			<span>${data.like_cnt}</span>명의 사람이<br>이 글을 좋아합니다.
                			<div id="likeListContainer">
                				<c:forEach items="${likeList}" var="item">
                					<div>
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
										${item.nm}
                					</div>
                				</c:forEach>
                			</div>
                		</div>
                	</c:if>
                </td>
            </tr>
        </table>
        <div class="ctnt" id="elCtnt">
            ${data.ctnt }
        </div>
        <div class="btn">
             <a href="/board/list?page=${param.page}&record_cnt=${param.record_cnt}&searchText=${param.searchText}&searchType=${param.searchType}"><button type="button">목록</button></a>
             <c:if test="${loginUser.i_user == data.i_user }">
                <a href="/regmod?searchText=${param.searchText}&searchType=${param.searchType}&i_board=${data.i_board}">
                	<button type="submit">수정</button>
                </a>
                <form id="delFrm" action="/board/del" method="post">
                    <input type="hidden" name="i_board" value="${data.i_board}">
                    <a href="#" onclick="submitDel()"><button type="submit">삭제</button></a>
                </form>
            </c:if>
        </div>
        
        <div class="marginTop30">
        	<form id="cmtFrm" action="/board/cmt" method="post">
        		<input type="hidden" name="i_cmt" value="0">
        		<input type="hidden" name="i_board" value="${data.i_board}">
        		<input type="hidden" name="searchText" value="${param.searchText}">
        		<input type="hidden" name="searchType" value="${param.searchType}">
        		<div>
        			<input type="text" id="cmt" name="cmt" placeholder="댓글내용">
        			<input type="submit" id="cmtSubmit" value="전송">
        			<input type="button" value="취소" onclick="clkCmtCancel()">
        		</div>
        	</form>
        </div>
        <div class="marginTop30">
        	<table class="cmtTable">
        		<tr>
        			<th class="cmtCtnt">내용</th>
        			<th> </th>
        			<th class="cmtUser">글쓴이</th>
        			<th class="cmtDate">등록일</th>
        			<th class="cmtBtn">비고</th>
        		</tr>
        		<c:forEach items="${cmtList}" var="item">
        			<tr>
        				<td>${item.cmt}</td>
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
        				<td>
        					<c:if test="${item.i_user==loginUser.i_user}">
        						<button onclick="clkCmtDel(${item.i_cmt})">삭제</button>
        						<button onclick="clkCmtMod(${item.i_cmt}, ${item.cmt})">수정</button>
        					</c:if>
        				</td>
        			</tr>
        		</c:forEach>
        	</table>
        </div>
    </div>

    <script>
    	function clkCmtCancel() {
    		cmtFrm.i_cmt.value = 0
    		cmtFrm.cmt = ''
    		cmtSubmit.value = '전송'
    	}
    	
    	function clkCmtDel(i_cmt) {
    		if(confirm('삭제하시겠습니까?')) {
    			location.href = '/board/cmt?searchText=${param.searchText}&searchType=${param.searchType}&i_board=${data.i_board}&i_cmt=' + i_cmt
    		}
    	}
    
    	// 댓글 수정
    	function clkCmtMod(i_cmt, cmt) {
    		console.log('i_cmt: '+i_cmt)
    		
    		cmtFrm.i_cmt.value = i_cmt
    		cmtFrm.cmt.value = cmt
    		
    		cmtSubmit.value = '수정'
    	}
    
	    function toggleLike(yn_like) {
	    	location.href="/board/toggleLike?page=${param.page}&record_cnt=${param.record_cnt}&searchText=${param.searchText}&searchType=${param.searchType}&i_board=${data.i_board}&yn_like="+yn_like // 쿼리스트링 =좌변: key값, =우변: value값
	    }
    
        function submitDel() {
            delFrm.submit()
        }
        
        function doHighlight() {
        	var searchText = '${param.searchText}'
        	var searchType = '${param.searchType}'
        	
        	switch(searchType) {
        	case 'a': // 제목
        		var txt = elTitle.innerText
        		txt = txt.replace(new RegExp('${param.searchText}', 'gi'), '<span class="highlight">'+searchText+'</span>')
        		elTitle.innerHTML = txt
        		break;
        	case 'b': // 내용
        		var txt = elCtnt.innerText
        		txt = txt.replace(new RegExp('${param.searchText}', 'gi'), '<span class="highlight">'+searchText+'</span>')
        		elCtnt.innerHTML = txt
        		break;
        	case 'c': // 제목+내용
        		var txt = elTitle.innerText
        		txt = txt.replace(new RegExp('${param.searchText}', 'gi'), '<span class="highlight">'+searchText+'</span>')
        		elTitle.innerHTML = txt
        		
        		txt = elCtnt.innerText
        		txt = txt.replace(new RegExp('${param.searchText}', 'gi'), '<span class="highlight">'+searchText+'</span>')
        		elCtnt.innerHTML = txt
        		break;
        	}
        }
        
        doHighlight()
    </script>
</body>
</html>