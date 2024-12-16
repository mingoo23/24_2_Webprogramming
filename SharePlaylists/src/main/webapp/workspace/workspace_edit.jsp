<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<link rel="stylesheet" href="./explore_styles.css" />

<section id="workspace-listen" class="workspace-tab-content">
    <div align="center">
        <!-- '새 플레이리스트 추가' 버튼 -->
        <a href= "<%= request.getContextPath() %>/workspace/workspace_createplaylist.jsp"><button id="add-playlist-btn" type="button">새 플레이리스트 추가</button></a>
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
