<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="./member_styles.css" />
</head>
<body>
	<div>
	<br>
	<input type="button" value="뒤로 가기" onclick="history.back();">
	</div>
	<center><h1>회원가입</h1></center>
	<form action="<%= request.getContextPath() %>/Join" method="post">
		<div class="table-wrapper">
		<table border="0" align="center">
				<tr>
					<th>ID</th>
					<td><input type="text" name="id" class="input-window"></td>
				</tr>
				<tr>
					<th>PASSWORD</th>
					<td><input type="password" name="pwd" class="input-window"></td>
				</tr>
				<tr>
					<th>NAME</th>
					<td><input type="text" name="username" class="input-window"></td>
				</tr>
				<tr>
					<th>EMAIL</th>
					<td><input type="text" name="email" class="input-window"></td>
					<td><input type="submit" value="가입" class="button btnPush btnOrange"></td>
				</tr>
		</table>
	</div>
	</form>
</body>
</html>