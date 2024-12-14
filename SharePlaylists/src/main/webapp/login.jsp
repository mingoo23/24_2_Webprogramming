<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="styles.css">
<style>
  .table-wrapper {
    border: 2px solid #808080;
    border-radius: 10px;
    padding: 20px; /* 안쪽 여백 */
    width: 400px;
    margin: 0 auto;
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
	<center><h1>로그인</h1></center>

	<form action="/SharePlaylists/MyInfo" method="post">
		<div class="table-wrapper">
			<table>
				<tr>
					<th>ID</th>
					<td><input type="text" name="id"></td>
				</tr>
				<tr>
					<th>PASSWORD</th>
					<td><input type="password" name="psw"></td>
					<td><input type="submit" value="로그인"></td>
				</tr>
				<tr>
					<td colspan="2">
						<a href="<%= request.getContextPath() %>/member/join.jsp">회원가입</a>
					</td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>
