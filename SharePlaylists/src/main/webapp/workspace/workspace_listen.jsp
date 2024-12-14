<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>내 작업실 - 듣기</title>
    <style>
        #my-playlists { list-style-type: none; padding: 0; }
        .playlist-item { margin: 10px 0; }
        .playlist-item img { width: 50px; height: 50px; margin-right: 10px; }
    </style>
</head>
<body>
<div id="workspace-edit">
    <h1>내 플레이리스트</h1>
    <ul id="my-playlists">
        <c:choose>
            <c:when test="${not empty playlists}">
                <c:forEach var="playlist" items="${playlists}">
                    <li class="playlist-item">
                        <img src="${playlist.thumbnail != null ? playlist.thumbnail : 'default-thumbnail.jpg'}" alt="썸네일"/>
                        <span>${playlist.title} (${playlist.trackCount} 트랙)</span>
                        <a href="playlist-details?playlistId=${playlist.id}">보기</a>
                    </li>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <button id="add-playlist-btn" onclick="location.href='./workspace/workspace-newplaylist.jsp'">
                    새 플레이리스트 추가
                </button>
            </c:otherwise>
        </c:choose>
    </ul>
</div>
</body>
</html>
