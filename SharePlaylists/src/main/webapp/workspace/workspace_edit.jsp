<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<link rel="stylesheet" href="./workspace/workspace_styles.css" />

<section id="workspace-listen" class="workspace-tab-content">
    <div align="center">
        <!-- '새 플레이리스트 추가' 버튼 -->
        <button id="add-playlist-btn">새 플레이리스트 추가</button>
    </div>
    <!-- 플레이리스트 생성 폼을 위한 컨테이너 -->
    <div id="create-playlist-content">
    <h1>새 플레이리스트 추가</h1>

    <!-- 플레이리스트 생성 폼 -->
    <form action="${pageContext.request.contextPath}/PlaylistCreateServlet" method="post">
        <div>
            <label for="title">Playlist 이름:</label>
            <input type="text" id="title" name="title" required>
        </div>
        <div>
            <label for="youtubeLink">YouTube 링크 추가:</label>
            <input type="text" id="youtubeLink" placeholder="YouTube 링크를 입력하세요">
            <button type="button" onclick="addYouTubeLink()">추가</button>
        </div>
        <div>
            <h3>추가된 링크 목록:</h3>
            <ul id="linkList">
                <!-- 링크가 여기에 추가됩니다 -->
            </ul>
        </div>
        <div>
            <input type="hidden" name="trackCount" id="trackCount" value="0">
            <button type="submit">플레이리스트 생성</button>
        </div>
    </form>
    
    </div>
</section>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function() {
    $("#add-playlist-btn").click(function() {
        $.ajax({
            url: "togglePlaylistForm",  // 서버의 엔드포인트 URL
            type: "POST",
            data: { isVisible: $("#create-playlist-content").is(":visible") },
            success: function(response) {
                if (response.success) {
                    $("#create-playlist-content").toggle();
                }
            },
            error: function() {
                console.error("플레이리스트 폼 토글 중 오류가 발생했습니다.");
            }
        });
    });
});
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

