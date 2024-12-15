<%@ page import="java.util.List, playlist.Playlist" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<link rel="stylesheet" href="./workspace/workspace_styles.css" />

<section id="workspace-listen" class="workspace-tab-content">
<div align="center">
    <h1>내 플레이리스트</h1>
    
  
    
    <ul id="my-playlists">
        <%
            // 플레이리스트가 존재하는지 확인
            List<Playlist> playlists = (List<Playlist>) request.getAttribute("playlists");
            
            if (playlists != null && !playlists.isEmpty()) {
                // 플레이리스트가 존재하면 반복문으로 출력
                for (Playlist playlist : playlists) {
        %>
                    <li class="playlist-item">
                        <!-- 썸네일 이미지가 있으면 표시하고, 없으면 기본 이미지 표시 -->
                        <img src="<%= playlist.getThumbnail() != null && !playlist.getThumbnail().isEmpty() ? playlist.getThumbnail() : "default-thumbnail.jpg" %>" alt="썸네일"/>
                        
                        <!-- 플레이리스트 제목과 트랙 수 출력 -->
                        <span><%= playlist.getTitle() %> (<%= playlist.getTrackCount() %> 트랙)</span>
                        
                        <!-- 플레이리스트 상세 페이지로 링크 -->
                        <a href="playlist-details?playlistId=<%= playlist.getId() %>">보기</a>
                    </li>
        <%
                }
            } else {
        %>
                <!-- 플레이리스트가 없으면 '새 플레이리스트 추가' 버튼 표시 -->
                <button id="add-playlist-btn" onclick="location.href='./workspace/workspace_createplaylist.jsp'">
                    새 플레이리스트 추가
                </button>
        <%
            }
        %>
    </ul>
</div>
</section>
