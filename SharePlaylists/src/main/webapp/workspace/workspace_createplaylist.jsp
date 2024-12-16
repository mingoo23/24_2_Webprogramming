<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<section id = create-playlist-content style="display: none">
    <h1>새 플레이리스트 추가</h1>

    <!-- 플레이리스트 생성 폼 -->
    <form action="${pageContext.request.contextPath}/PlaylistCreateServlet" method="post">
        <div>
            <label for="title">Playlist 이름:</label>
            <input type="text" id="title" name="title" required>
        </div>
        <div>
            <label for="youtubeLink">YouTube 링크 추가:</label>
            <input type="text" id="youtubeLink" placeholder="YouTube 링크를 입력하세요">
            <button type="button" onclick="addYouTubeLink()">추가</button>
        </div>
        <div>
            <h3>추가된 링크 목록:</h3>
            <ul id="linkList">
                <!-- 링크가 여기에 추가됩니다 -->
            </ul>
        </div>
        <div>
            <input type="hidden" name="trackCount" id="trackCount" value="0">
            <button type="submit">플레이리스트 생성</button>
        </div>
    </form>
</section>

