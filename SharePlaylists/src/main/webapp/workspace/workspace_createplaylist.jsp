<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<section id = create-playlist-content>
    <h1>새 플레이리스트 추가</h1>

    <!-- 플레이리스트 생성 폼 -->
    	<form action="${pageContext.request.contextPath}/PlaylistCreationServlet" method="post">
        <div>
            <label for="title">Playlist 이름:</label>
            <input type="text" id="title" name="title" required>
        </div>
        <div>
            <button type="submit">플레이리스트 생성</button>
        </div>
    </form>
</section>
