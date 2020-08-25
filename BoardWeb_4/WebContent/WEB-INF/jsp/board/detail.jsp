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
             <a href="/board/list"><button type="button">목록</button></a>
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
    </div>

    <script>
        function submitDel() {
            delFrm.submit()
        }
        
        function toggleLike(yn_like) {
        	location.href="/board/toggleLike?i_board=${data.i_board}&yn_like="+yn_like // 쿼리스트링 =좌변: key값, =우변: value값
        }
    </script>
</body>
</html>