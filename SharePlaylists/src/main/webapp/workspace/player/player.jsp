<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="playlist.SongService" %>
<%@ page import="playlist.Song" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>플레이어</title>
    <style>
        /* 간단한 스타일 */
        body {
            font-family: Arial, sans-serif;
            background-color: #121212;
            color: #fff;
            margin: 0;
            padding: 0;
        }

        #player {
            margin: 20px auto;
            text-align: center;
        }

        #playlist {
            margin: 20px auto;
            width: 80%;
            background: #fff;
            color: #000;
            border-radius: 5px;
            padding: 10px;
        }

        #playlist div {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            cursor: pointer;
        }

        #playlist div:hover {
            background-color: #f0f0f0;
        }
    </style>
</head>
<body>
    <%
        // 요청에서 playlistId를 가져옴
        int playlistId = Integer.parseInt(request.getParameter("playlist_id"));

        // SongService를 사용해 노래 목록을 가져옴
        SongService songService = new SongService();
        List<Song> songs = songService.getSongsByPlaylistId(playlistId);

        // JavaScript 배열로 변환
        StringBuilder jsPlaylistArray = new StringBuilder("[");
        for (int i = 0; i < songs.size(); i++) {
            // Java의 정규식으로 YouTube 비디오 ID 추출
            String songId = songs.get(i).getSongId();
            String youtubeVideoId = songId.replaceAll(
                "^(?:https?:\\/\\/)?(?:www\\.)?(?:youtu\\.be\\/|youtube\\.com\\/(?:watch\\?v=|embed\\/|v\\/|shorts\\/))([^#&?]{11}).*",
                "$1"
            );

            jsPlaylistArray.append("\"").append(youtubeVideoId).append("\"");
            if (i < songs.size() - 1) {
                jsPlaylistArray.append(",");
            }
        }
        jsPlaylistArray.append("]");
    %>

    <h1>플레이리스트 ID: <%= playlistId %></h1>

    <!-- 플레이어와 플레이리스트 영역 -->
    <div id="player"></div>
    <div id="playlist"></div>

    <!-- YouTube IFrame API -->
    <script src="https://www.youtube.com/iframe_api"></script>
    <script>
        // JSP에서 전달된 playlist 배열
        let playlist = <%= jsPlaylistArray.toString() %>;
        let player;
        let currentTrack = 0;

        // 유튜브 비디오 ID 추출 함수 (JS에서도 사용 가능)
        function getYoutubeVideoId(url) {
            const regex = /(?:youtu\.be\/|youtube\.com\/(?:watch\?v=|embed\/|v\/|shorts\/))([^#&?]{11})/;
            const match = url.match(regex);
            return match ? match[1] : null;
        }

        // YouTube IFrame API가 준비되었을 때 호출
        function onYouTubeIframeAPIReady() {
            player = new YT.Player('player', {
                height: '360',
                width: '640',
                videoId: playlist[currentTrack], // 첫 번째 곡
                playerVars: { 'playsinline': 1 },
                events: {
                    'onReady': onPlayerReady,
                    'onStateChange': onPlayerStateChange
                }
            });
        }

        // 플레이어가 준비되었을 때
        function onPlayerReady() {
            updatePlaylist();
        }

        // 곡이 종료되었을 때 다음 곡으로 자동 재생
        function onPlayerStateChange(event) {
            if (event.data === YT.PlayerState.ENDED) {
                playNext();
            }
        }

        // 다음 곡 재생
        function playNext() {
            currentTrack = (currentTrack + 1) % playlist.length;
            player.loadVideoById(playlist[currentTrack]);
        }

        // 이전 곡 재생
        function playPrev() {
            currentTrack = (currentTrack - 1 + playlist.length) % playlist.length;
            player.loadVideoById(playlist[currentTrack]);
        }

        // 플레이리스트 업데이트
        function updatePlaylist() {
            const playlistElement = document.getElementById('playlist');
            playlistElement.innerHTML = '';

            playlist.forEach((videoId, index) => {
                const item = document.createElement('div');
                item.textContent = `트랙 ${index + 1}`; // 트랙 번호 표시
                item.onclick = () => {
                    currentTrack = index;
                    player.loadVideoById(videoId);
                };
                playlistElement.appendChild(item);
            });
        }
    </script>
</body>
</html>
