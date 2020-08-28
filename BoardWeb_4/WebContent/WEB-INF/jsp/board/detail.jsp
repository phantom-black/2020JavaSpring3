<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상세페이지</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
        * {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #faf9f7;
        }
        *:focus {
            outline: none;
        }
        .container {
            width: 700px;
            margin: 30px auto;
        }
        table {
            border: 1px solid black;
            border-collapse: collapse;
        }
        th,
        td {
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
            width: 33%;
        }
        #date {
            width: 12%;
        }
        #date-1 {
            width: 25%;
        }
        #hits {
            width: 10%;
        }
        #hits-1 {
            width: 10%;
        }
        .ctnt {
            border-right: 1px solid #58585a;
            border-left: 1px solid #58585a;
            border-bottom: 1px solid #58585a;
            height: 200px;
            padding: 10px;
        }
        .btn {
        	margin: 20px 0;
        }
        .btn a {
        	display: inline-block;
        	margin-right: 20px;
        	border-radius: 10px;
        	width: 100px;
            text-decoration: none;
            text-align: center;
            color: #58585a;
            background-color: #f5d1ca;
        }
        .btn button {
            background-color: #f5d1ca;
            text-align: center;
            border: none;
            padding: 8px;
            color: #58585a;
            font-weight: bold;
            font-size: 0.9em;
            cursor: pointer;
        }
        #delFrm {
            display: inline-block;
        }
        .material-icons {
        	color: #f00;
        }
        .pointerCursor {
        	cursor: pointer;
        }
        .marginTop30 {
        	margin=top: 30px;
        }
        #cmt {
        	width: 630px;
        }
    </style>
</head>

<body>
    <div class="container">
        <table>
            <tr id="title">
                <th>제목</th>
                <th colspan="6">${data.title}</th>
            </tr>
            <tr class="boardInfo">
                <th id="nm">작성자</th>
                <td id="nm-1">${data.nm }</td>
                <th id="date">작성일시</th>
                <td id="date-1"> ${data.r_dt } <small>${data == null ? '' : '수정' }</small> </td>
                <th id="hits">조회수</th>
                <td id="hits-1">${data.hits }</td>
                <td class="pointerCursor" onclick="toggleLike(${data.yn_like})">
                	<c:if test="${data.yn_like==0 }">
                		<span class="material-icons">favorite_border</span>
                	</c:if>
                	<c:if test="${data.yn_like==1 }">
                		<span class="material-icons">favorite</span>
                	</c:if>
                </td>
            </tr>
        </table>
        <div class="ctnt">
            ${data.ctnt }
        </div>
        <div class="btn">
             <a href="/board/list?page=${param.page}&record_cnt=${param.record_cnt}&searchText=${param.searchText}"><button type="button">목록</button></a>
             <c:if test="${loginUser.i_user == data.i_user }">
                <a href="/regmod?i_board=${data.i_board}">
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
        		<div>
        			<input type="text" id="cmt" name="cmt" placeholder="댓글내용">
        			<input type="submit" id="cmtSubmit" value="전송">
        			<input type="button" value="취소" onclick="clkCmtCancel()">
        		</div>
        	</form>
        </div>
        <div class="marginTop30">
        	<table>
        		<tr>
        			<th>내용</th>
        			<th>글쓴이</th>
        			<th>등록일</th>
        			<th>비고</th>
        		</tr>
        		<c:forEach items="${cmtList}" var="item">
        			<tr>
        				<td>${item.cmt}</td>
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
    			location.href = '/board/cmt?i_board=${data.i_board}&i_cmt=' + i_cmt
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
	    	location.href="/board/toggleLike?page=${param.page}&record_cnt=${param.record_cnt}&searchText}&i_board=${data.i_board}&yn_like="+yn_like // 쿼리스트링 =좌변: key값, =우변: value값
	    }
    
        function submitDel() {
            delFrm.submit()
        }
    </script>
</body>
</html>