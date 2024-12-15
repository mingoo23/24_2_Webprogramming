<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<h3>로그인</h3>
	<form action="/SharePlaylists/Login" method="post">
		<table border="1">
				<tr><th>ID</th><td><input type="text" name="id" placeholder="아이디를 입력하세요"></td></tr>
				<tr><th>PWD</th><td><input type="password" name="pwd" placeholder="비밀번호를 입력하세요"></td></tr>
				<tr><th>로그인</th><td><input type="submit" value="로그인"></td></tr>
		</table>
	</form>

	<!-- 회원가입 페이지로 이동 -->
	<p>계정이 없으신가요? <a href="/SharePlaylists/Join">회원가입</a></p>
</body>
</html>