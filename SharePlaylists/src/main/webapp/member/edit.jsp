<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>수정폼</h3>
	<form action="/SharePlaylists/EditmyInfo" method="post">
		<table border="1">
		<!-- 입력 양식의 value는 입력값임. -->
		<!-- readonly: 값 못 고침, 읽기만 가능 (ID, email) -->
			<tr><th>ID</th><td><input type="text" name="id" value="${m.id }" readonly></td></tr>
			<tr><th>PWD</th><td><input type="text" name="pwd" value="${m.pwd }"></td></tr>
			<tr><th>NAME</th><td><input type="text" name="username" value="${m.username }"></td></tr>
			<tr><th>EMAIL</th><td><input type="text" name="email" value="${m.email }" readonly></td></tr>
			<tr><th>수정</th>
				<td><input type="submit" value="수정">
					<input type="button" value="취소" onclick="javascript:location.href='/SharePlaylists/login.jsp'"></td></tr>
		</table>

	</form>

</body>
</html>