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
            <label for="title">제목:</label>
            <input type="text" id="title" name="title" required>
        </div>
        <div>
            <label for="thumbnail">썸네일 URL:</label>
            <input type="url" id="thumbnail" name="thumbnail" >
        </div>
        <div>
            <label for="trackCount">트랙 수:</label>
            <input type="number" id="trackCount" name="trackCount" min="1">
        </div>
        <div>
            <button type="submit">플레이리스트 생성</button>
        </div>
    </form>
    
</body>
</html>
