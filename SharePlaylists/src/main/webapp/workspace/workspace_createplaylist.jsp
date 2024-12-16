<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<link rel="stylesheet" href="./workspace/workspace_styles.css" />
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

<body>
<section id = create-playlist-content>
		<!-- 입력 폼 영역 -->
        <div id="create-playlist-content" style="display: block; margin-top: 20px;">
        <center><h1>새 플레이리스트 추가</h1>

    	<!-- 플레이리스트 생성 폼 -->
		<form action="${pageContext.request.contextPath}/PlaylistCreationServlet" method="post">
        <div>
            <label for="title">Playlist 이름:</label>
            <input type="text" id="title" name="title" required>
        </div>
        
        <!-- 노래 입력은 내부에서 -->
        <!-- <div>
            <label for="youtubeLink">YouTube 링크 추가:</label>
            <input type="text" id="youtubeLink" placeholder="YouTube 링크를 입력하세요">
            <button type="button" onclick="addYouTubeLink()">추가</button>
        </div>          
        <div>
            <h3>추가된 링크 목록:</h3>
            <ul id="linkList">-->
                <!-- 링크가 여기에 추가됩니다 -->
        <!--  </ul>
        </div>  -->
         
        <div>
            <!-- <input type="hidden" name="trackCount" id="trackCount" value="0"> -->
            <button type="submit">플레이리스트 생성</button>
        </div>
    </form>
    </center>
</section>
</body>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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