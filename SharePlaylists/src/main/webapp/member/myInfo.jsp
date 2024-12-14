<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 자바에서 쓰던 변수를 뷰페이지에서 쓸 수 있게 함 -->
<!-- 멤버변수이름을 보면 자동으로 getter 호출함. (getId()) -->
<!-- VO에 setter getter 추가해야 함. -->
<h3>${m.id }님의 정보</h3>
id: ${m.id }<br/>
pwd: ${m.pwd }<br/>
username: ${m.username }<br/>
email: ${m.email }<br/>
<!-- 폼파라메터를 get 방식으로 전달하고 싶으면 url?파람이름=값&파람이름=값&.. -->
<!-- 4. 수정 -->
<input type="button" value="내정보수정" onclick="location.href='/SharePlaylists/EditmyInfo?id=${m.id }'"><br/>
<!-- 5. 탈퇴 -->
<a href="/SharePlaylists/DelmyInfo?id=${m.id }" onclick="javascript:alert('탈퇴하셨습니다.')">탈퇴</a><br/>
</body>
</html>