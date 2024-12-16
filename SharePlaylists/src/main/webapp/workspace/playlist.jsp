<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>플레이리스트</title>
</head>
<body>
    <h1>플레이리스트 목록</h1>

    <form action="${pageContext.request.contextPath}/PlaylistServlet" method="post">
        <label>플레이리스트 이름:</label>
        <input type="text" name="title" required><br>

        <label>유튜브 링크:</label>
        <input type="text" name="links"><br>

        <button type="submit">플레이리스트 생성</button>
    </form>

    <h2>저장된 플레이리스트:</h2>
    <ul>
        <c:forEach var="playlist" items="${playlists}">
            <li>${playlist.title} (곡 수: ${playlist.trackCount})</li>
        </c:forEach>
    </ul>
</body>
</html>
