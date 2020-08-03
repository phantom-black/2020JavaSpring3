<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String i_board = request.getParameter("i_board");
	
	String msg = "";
	String err = request.getParameter("err");
	
	if(err != null) {
		switch(err) {
			case "10":
				msg="수정할 수 없습니다.";
				break;
			case "20":
				msg="DB 에러 발생";
				break;
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정</title>
<style>
	#msg {
		color: red;
	}
</style>
</head>
<body>
	<div id="msg"><%=msg %></div>
	<div>
		<form id="frm" action="/jsp/boardModProc.jsp" method="post" onsubmit="return chk()">
			<div><label>제목: <input type="text" name="title"></label></div>
			<div><label>내용: <textarea name="ctnt"></textarea></label></div>
			<div><label>작성자: <input type="text" name="i_student"></label></div>
			<div><input type="submit" value="글 수정"></div>
		</form>
	</div>
	<script>
		function eleValid(ele) {
			if(ele.value.length == 0) {
				alert(nm+'을(를) 입력해 주세요.')
				ele.focus()
				return true
			}
		}
		
		function chk() {
			//frm.title.value // 자식의 name 안에 들어있는 값
			//console.log(`title : \${frm.title.value}`)
			if(eleValid(frm.title, '제목')) {
				return false
			} else if(eleValid(frm.ctnt, '내용')) {
				return false
			} else if(eleValid(frm.i_student, '작성자')) {
				return false
			}
			
			
			/*if(frm.title.value=='') {
				alert('제목을 입력해 주세요.')
				frm.title.focus()
				return false
			} else if( frm.ctnt.value.length == 0 ) {
				alert('내용을 입력해 주세요.')
				frm.ctnt.focus()
				return false
			} else if(frm.i_student.value.length == 0) {
				alert('내용을 입력해주세요.')
				frm.i_student.focus()
				return false
			}*/

		}
	</script>
</body>
</html>