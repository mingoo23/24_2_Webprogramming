<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<link rel="stylesheet" href="./explore_styles.css" />

<section id="workspace-listen" class="workspace-tab-content">
    <div align="center">
        <!-- '새 플레이리스트 추가' 버튼 -->
        <button id="add-playlist-btn">새 플레이리스트 추가</button>
        
        <!-- 입력 폼 영역 -->
        <div id="create-playlist-content" style="display: block; margin-top: 20px;">
            <h1>새 플레이리스트 추가</h1>

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
        </div>
        
        
        
        <%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	try{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcUrl = "jdbc:mysql://localhost:3306/playlists";
		conn = DriverManager.getConnection(jdbcUrl,"root","0000");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		//playlist 테이블에서 플레이리스트 모두 가져옴
		String sql = "SELECT * FROM playlist ORDER BY playlist_id ASC";
		rs = stmt.executeQuery(sql);
	}catch(Exception e){
		out.println("DB 연동 오류입니다.: " + e.getMessage());
	}
	
	rs.last();
	rs.beforeFirst();

	%>
	<div class="playlist-container">
	<%
	//플레이리스트 전부 출력하도록
	while(rs.next()){
		//playlist_id는 순서대로 플레이리스트 번호이므로
		int playlist_id = rs.getRow();
		String playlist_title = rs.getString("playlist_title");
	%>
	
		<div class="playlist-card" onclick="클릭시 내부 뷰 구현">
        	<div class="thumbnail">
            	<img src="thumnail.png" alt="썸네일 없음" />
            </div>
            <div class="card-content">
                <div class="title"><%= playlist_title %></div>
            </div>
		</div>
	
    <%
	}
    %>
    </div>
</section>

<script>
//입력창 보이게/안보이게 부분 여기 작성


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
}
</script>
