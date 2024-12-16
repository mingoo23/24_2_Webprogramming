<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
	String playlistTitle = request.getParameter("playlistTitle");
	//int playlistId = Integer.parseInt(request.getParameter("playlistId"));
%>

<link rel="stylesheet" href="./workspace/workspace_styles.css" />
<section id="workspace-edit" class="workspace-tab-content">

  <div align="center">
  	<h2><%=playlistTitle%></h2>
    <form action="${pageContext.request.contextPath}/SongsServlet" method="post">
    	<label for="songId">Song ID (YouTube Link):</label><br>
    	<input type="text" id="songId" name="songId" placeholder="https://youtu.be/example1" required><br><br>
    	<label for="playlistId">Playlist ID:</label><br>
    	<input type="number" id="playlistId" name="playlistId" placeholder="1" required><br><br>
    	<button type="submit" onclick="addYouTubeLink()">Add Song</button>
    </form>
  </div>
</section>

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
