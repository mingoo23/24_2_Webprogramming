<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
  body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #121212;
    color: #fff;
  }
  .table-wrapper {
    border: 2px solid #808080; /* 테두리 설정 */
    border-radius: 10px; /* 테두리 둥글게 */
    padding: 20px; /* 안쪽 여백 */
    width: 400px; /* 테두리 박스의 너비 설정 */
    margin: 0 auto; /* 가운데 정렬 */
  }

  .table-wrapper table {
    width: 100%; /* 테이블이 감싸는 div에 맞게 */
    border-collapse: collapse; /* 테이블 셀 경계 */
  }

  .table-wrapper th, .table-wrapper td {
    padding: 10px; /* 셀 안쪽 여백 */
    text-align: left; /* 텍스트 정렬 */
  }
</style>
</head>
<body>
	<center><h1>회원가입</h1></center>
	<form action="/SharePlaylists/Join" method="post">
	<div class="table-wrapper">
		<table border="0" align="center">
				<tr>
					<th>ID</th>
					<td><input type="text" name="id"></td>
				</tr>
				<tr>
					<th>PASSWORD</th>
					<td><input type="password" name="pwd"></td>
				</tr>
				<tr>
					<th>NAME</th>
					<td><input type="text" name="username"></td>
				</tr>
				<tr>
					<th>EMAIL</th>
					<td><input type="text" name="email"></td>
					<td><input type="submit" value="가입"></td>
				</tr>
		</table>
	</div>
	</form>
</body>
</html>