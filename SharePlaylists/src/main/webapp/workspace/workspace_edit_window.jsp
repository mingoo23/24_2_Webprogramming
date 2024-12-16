<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #121212;
    color: #fff;
}

.td-container {
  display: flex;
  align-items: center; /* 세로 중앙 정렬 */
  gap: 0px; /* 입력창 간격 */
}

.input-window {
  width: 100%;
  padding: 5px;
  font-size: 22px;
}

.button {
  display: block;
  width: 80px;
  padding: 0;
  margin: 10px 20px 10px 0;
  font-weight: 600;
  text-align: center;
  line-height: 50px;
  color: white;
  border-radius: 15px;
  transition: all 0.2s;
  cursor: pointer; /* 커서 변경 */
}

input[type="submit"] {
  border: none; /* 기본 테두리 제거 */
  outline: none; /* 포커스 시 나타나는 윤곽선 제거 */
}

input[type="button"] {
  border: none; /* 기본 테두리 제거 */
  outline: none; /* 포커스 시 나타나는 윤곽선 제거 */
}

.btnOrange {
  background: #ff7f00;
}
.btnOrange.btnPush {
  box-shadow: 0px 5px 0px 0px #a66615;
}
.btnPush:hover {
  margin-top: 15px;
  margin-bottom: 5px;
}
.btnOrange.btnPush:hover {
  box-shadow: 0px 0px 0px 0px #a66615;
}
</style>

<%
	String playlistTitle = request.getParameter("playlistTitle");
	int playlistId = Integer.parseInt(request.getParameter("playlistId"));
%>

<link rel="stylesheet" href="./workspace/workspace_styles.css" />
<body>
<section id="workspace-edit" class="workspace-tab-content">

  <div align="center">
  	<div>&nbsp;&nbsp;&nbsp;</div>
  	<h1><%=playlistTitle%></h1>
    <form action="${pageContext.request.contextPath}/SongsServlet" method="post">
    <table>
    <tr>
    	<th style="font-size: 20px;">유튜브 링크 입력</th>
    	<td>&nbsp;&nbsp;&nbsp;</td>
    	<td><input type="text" id="songId" name="songId" class="input-window" placeholder="https://youtu.be/example1" required></td>
    	<td><input type="hidden" id="playlistId" name="playlistId" value="<%=playlistId%>"></td>
    	<td>&nbsp;&nbsp;&nbsp;</td>
    	<td>
    		<input
              class="button btnPush btnOrange"
              type="submit"
              onclick="addYouTubeLink()"
              value="음악 추가"
            />
    	</td>
    </tr>
    </table>
    </form>
  </div>
</section>
</body>
<script>
   function addYouTubeLink() {
    const inputField = document.getElementById("youtubeLink");
    const link = inputField.value.trim();

    if (link === "") {
        alert("YouTube 링크를 입력해주세요!");
        return;
    }

    // 새로운 리스트 아이템 생성
    const listItem = document.createElement("li");
    listItem.textContent = link;

    // 숨겨진 input에 저장할 값 설정
    const hiddenInput = document.createElement("input");
    hiddenInput.type = "hidden";
    hiddenInput.name = "links"; // links라는 배열로 서블릿에 전달됨
    hiddenInput.value = link;

    // 리스트와 폼에 각각 추가
    listItem.appendChild(hiddenInput);
    document.getElementById("linkList").appendChild(listItem);

    // 입력 필드 초기화
    inputField.value = "";

    // trackCount 업데이트
    const trackCountInput = document.getElementById("trackCount");
    trackCountInput.value = parseInt(trackCountInput.value) + 1;
   }
</script>
