<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>플레이어</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #121212;
        color: #fff;
      }

      .container {
        width: 80%;
        margin: auto;
        overflow: hidden;
        padding: 20px;
      }

      #playlist {
        background-color: white;
        color: black;
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

      .playlist-container {
        display: flex;
        flex-wrap: wrap; /* 줄바꿈 없이 가로로 배치 */
        justify-content: center;
        gap: 20px; /* 카드 사이 간격 */
        padding: 10px;
        width: 80%; /* 부모 요소에 맞게 너비를 100%로 설정 */
        box-sizing: border-box; /* padding을 너비에 포함시켜서 계산 */
      }

      /* 재생바 스타일 */
      .player {
        display: flex;
        flex-direction: column; /* 수직 방향으로 정렬 */
        align-items: center;
        justify-content: center;
        width: 98%;
        margin: 0 auto;
        padding: 10px;
        background-color: #000;
        color: #fff;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
        position: absolute;
        bottom: 0;
      }

      .progress-bar {
        width: 100%; /* 부모의 너비에 맞춤 */
        height: 8px;
        background-color: #444;
        border-radius: 4px;
        margin-bottom: 15px; /* 버튼과의 간격 */
        overflow: hidden;
        position: relative;
      }

      .progress {
        height: 100%;
        background-color: #ff7f00;
        transition: width 0.3s;
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
  <div>
      <br />
      <input type="button" value="뒤로 가기" onclick="history.back();" />
    </div>
    <% String title = request.getParameter("title");%>

    <center>
      <h1><%= title %></h1>
      <div class="playlist-container">
        <table border="0" style="width: 100%; table-layout: fixed">
          <tr>
            <td style="width: 50%">
              <div id="player"></div>
              <center>
                <div class="controls">
                  <button class="btn btn-prev">⏮</button>
                  <button class="btn btn-play" id="playButton">▶</button>
                  <button class="btn btn-next" id="nextBtn">⏭</button>
                </div>
              </center>
            </td>
            <td style="width: 50%"><div id="playlist"></div></td>
          </tr>
        </table>
      </div>
    </center>
    <script src="https://www.youtube.com/iframe_api"></script>
    <script src="player.js"></script>
  </body>
</html>
