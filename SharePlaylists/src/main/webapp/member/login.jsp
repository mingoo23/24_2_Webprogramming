<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>로그인</title>
<link rel="stylesheet" href="./member_styles.css" />
</head>
<body>
    <div>
	<br>
	<input type="button" value="뒤로 가기" onclick="history.back();">
	</div>
    <center><h1>로그인</h1></center>
    <form action="/SharePlaylists/Login" method="post">
      <div class="table-wrapper">
        <table>
          <tr>
            <th>ID</th>
            <td>
              <input type="text" name="id" placeholder="아이디를 입력하세요" class="input-window" />
            </td>
          </tr>
          <tr>
            <th>PASSWORD</th>
            <td>
              <input
                type="password"
                name="pwd"
                placeholder="비밀번호를 입력하세요"
                class="input-window"
              />
            </td>
            <td><input type="submit" value="로그인" class="button btnPush btnOrange" /></td>
          </tr>
          <tr>
          <td colspan="2">
          <p>
     계정이 없으신가요?
     <a href="<%= request.getContextPath() %>/member/join.jsp">회원가입</a>
    </p>
          </td>
          </tr>
        </table>
      </div>
    </form>  
    <!-- 회원가입 페이지로 이동 -->
    
  </body>
</html>
