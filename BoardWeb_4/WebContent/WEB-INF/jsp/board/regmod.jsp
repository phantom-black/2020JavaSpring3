<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${data == null ? '등록' : '수정'}</title>
<style>
	.err { color: red; }
</style>
</head>
<body>
	<div class="err">${msg}</div>
	<div>
		<form id="frm" action="regmod" method="post" onsubmit="return chk()">
			<input type="hidden" name="i_board" value="${data.i_board}">
			<div>제목: <input type="text" name="title" value="${data.title}"></div>
			<hr>
			<div>내용: <textarea name="ctnt">${data.ctnt}</textarea></div>
			<div><input type="submit" value="${data == null ? '등록' : '수정'}"></div>
		</form>
	</div>
	<script>
		function chk() {
			if(frm.title.value == null) {
				alert('제목을 입력해 주세요.')
				frm.title.focus()
				return false
			} else if(frm.ctnt.value == null) {
				alert('내용을 입력해 주세요.')
				frm.ctnt.focus()
				return false
			}
		}
	</script>
</body>
</html>