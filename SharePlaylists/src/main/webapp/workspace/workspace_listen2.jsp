<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, playlist.Playlist" %>

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
        <%
            // 서블릿에서 전달한 플레이리스트 데이터를 JSP에서 사용
            java.util.List<Playlist> playlists = 
                (java.util.List<Playlist>) request.getAttribute("playlists");
            
            if (playlists != null && !playlists.isEmpty()) {
                for (Playlist playlist : playlists) {
        %>
        <li class="playlist-item">
            <img src="<%= playlist.getThumbnail() != null ? playlist.getThumbnail() : "default-thumbnail.jpg" %>" alt="썸네일"/>
            <span><%= playlist.getTitle() %> (<%= playlist.getTrackCount() %> 트랙)</span>
            <a href="playlist-details?playlistId=<%= playlist.getId() %>">보기</a>
        </li>
        <%
                }
            } else {
        %>
        <button id="add-playlist-btn" onclick="location.href='./workspace/workspace-newplaylist.jsp'">
            새 플레이리스트 추가
        </button>
        <%
            }
        %>
    </ul>
</div>
</body>
</html>



