<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>YouTube 플레이리스트 플레이어</title>
    <link rel="stylesheet" href="player.css">
</head>
<body>
    <div class="container">
        <h1>YouTube 플레이리스트 플레이어</h1>
        <div id="player"></div>
        <div id="controls">
            <button id="playPauseBtn">재생/일시정지</button>
            <button id="nextBtn">다음 곡</button>
        </div>
        <div id="playlist"></div>
    </div>
    <script src="https://www.youtube.com/iframe_api"></script>
    <script src="player.js"></script>
</body>
</html>