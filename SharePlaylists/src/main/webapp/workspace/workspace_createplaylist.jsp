<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>새 플레이리스트 추가</title>
</head>
<body>
    <h1>새 플레이리스트 추가</h1>


    <!-- 플레이리스트 생성 폼 --> 
    <form action="${pageContext.request.contextPath}/PlaylistCreateServlet" method="post">
        <div>
            <label for="title">playlist 이름:</label>
            <input type="text" id="title" name="title" required>
        </div>
        <div>
            <label for="songs">playlist에 추가할 음악:</label>
            <input name>
        </div>
        <div>
            <button type="submit">플레이리스트 생성</button>
        </div>
    </form>
    
</body>
</html>
