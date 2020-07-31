<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
</head>
<body>
	<div>
		<form action="/jsp/boardWriteProc.jsp" method="post">
			<div><label>제목: <input type="text" name="title"></label></div>
			<div><label>내용: <textarea name="ctnt"></textarea></label></div>
			<div><label>작성자: <input type="text" name="i_student"></label></div>
			<div><input type="submit" value="글등록"></div>
		</form>
	</div>
</body>
</html>