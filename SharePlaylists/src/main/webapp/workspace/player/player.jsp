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
        /* 버튼 스타일 */
        .controls {
        display: flex;
        align-items: center;
        justify-content: center; /* 중앙 정렬 */
        gap: 10px;
        }

        .btn {
        background: none;
        border: none;
        color: #ff7f00;
        font-size: 1.5rem;
        cursor: pointer;
        transition: transform 0.2s;
        }

        .btn:hover {
        transform: scale(1.2);
        }

        .playerBar {
        display: flex;
        justify-content: space-between;
        align-items: center; /* 세로 정렬을 위한 선택 (중앙 정렬) */
        width: 100%; /* 부모 컨테이너 너비를 기준으로 배치 */
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
	<div>
      <br />
      <input type="button" value="뒤로 가기" onclick="history.back();" />
    </div>
    <center><h1>플레이리스트 ID: <%= playlistId %></h1>

    <!-- 플레이어와 플레이리스트 영역 -->
    <div id="player"></div>
    <div class="controls">
	    <button class="btn btn-prev">⏮</button>
	    <button class="btn btn-play" id="playButton">▶</button>
	    <button class="btn btn-next" id="nextBtn">⏭</button>
	</div>
    <div id="playlist"></div>
	
	</center>
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
        
     // 재생/일시정지 토글
        function playPause() {
          const playButton = document.getElementById("playButton");

          if (player.getPlayerState() === YT.PlayerState.PLAYING) {
            player.pauseVideo();
            playButton.textContent = "▶"; // Play 상태
          } else {
            player.playVideo();
            playButton.textContent = "❚❚"; // Pause 상태
          }
        }

        // 다음 트랙 재생
        function playNext() {
          currentTrack = (currentTrack + 1) % playlist.length; // 다음 트랙으로 순환
          player.loadVideoById(playlist[currentTrack]);
          updatePlayButton();
        }

        // 이전 트랙 재생
        function playPrev() {
          currentTrack = (currentTrack - 1 + playlist.length) % playlist.length; // 이전 트랙으로 순환
          player.loadVideoById(playlist[currentTrack]);
          updatePlayButton();
        }

        // 플레이리스트 화면 갱신
        function updatePlaylist() {
          const playlistElement = document.getElementById('playlist');
          playlistElement.innerHTML = '';

          playlist.forEach((videoId, index) => {
            const item = document.createElement('div');
            item.textContent = `트랙 ${index + 1}`; // 트랙 이름
            item.onclick = () => {
              currentTrack = index;
              player.loadVideoById(videoId);
              updatePlayButton();
            };
            playlistElement.appendChild(item);
          });
        }

        // 플레이 버튼 상태 업데이트
        function updatePlayButton() {
          const playButton = document.getElementById("playButton");
          playButton.textContent = "❚❚"; // 새 비디오가 재생되면 Pause 버튼으로
        }

        // 버튼 이벤트 리스너 추가
        document.addEventListener("DOMContentLoaded", function () {
          const playButton = document.getElementById("playButton");
          const prevButton = document.querySelector(".btn-prev");
          const nextButton = document.getElementById("nextBtn");

          // 재생/일시정지 버튼
          playButton.addEventListener("click", playPause);

          // 이전 곡 버튼
          prevButton.addEventListener("click", function () {
            console.log("이전 곡 재생");
            playPrev();
          });

          // 다음 곡 버튼
          nextButton.addEventListener("click", function () {
            console.log("다음 곡 재생");
            playNext();
          });
        });
    </script>
</body>
</html>
