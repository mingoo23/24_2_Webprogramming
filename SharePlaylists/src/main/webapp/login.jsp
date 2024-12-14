<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>webProg</h3>
	<!-- 링크 이동은 get 방식 => doGet 실행 -->
	<!-- "Servlet 주소" -->
	
	<!-- 2. 회원가입 -->
	<a href="/SharePlaylists/Join">회원가입</a><br/>
	
	<!-- 3. id 검색 -->
	<form action="/SharePlaylists/MyInfo" method="post">
		검색할 id:<input type="text" name="id">
		<input type="submit" value = "검색"> 
	</form>
	
</body>
</html>