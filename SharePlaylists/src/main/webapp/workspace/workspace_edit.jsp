<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<link rel="stylesheet" href="./explore_styles.css" />
<style>
/* 추가 버튼 스타일 */
.plus-button {
  display: flex;
  align-items: center;
  justify-content: center;
  width: calc(20% - 20px); /* 버튼의 너비 */
  height: 200px; /* 버튼의 높이 */
  color: #808080; /* 텍스트 색상 */
  border: 2px solid #808080; /* 테두리 색상 */
  border-radius: 10px; /* 버튼 둥글게 만들기 */
  cursor: pointer; /* 클릭할 수 있는 포인터 표시 */
  transition: all 0.3s ease; /* 부드러운 전환 효과 */
}

.plus-button .icon {
  font-size: 50px; /* 아이콘 크기 */
}

.plus-button:hover {
  border-color: #aaa; /* 테두리 색 변경 */
  color: #aaa; /* 텍스트 색상 변경 */
}

</style>

<section id="workspace-listen" class="workspace-tab-content">    

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
   <div class="plus-button" onclick="location.href='<%= request.getContextPath() %>/workspace/workspace_createplaylist.jsp'">
     <span class="icon">+</span>
   </div>
   <%
   //플레이리스트 전부 출력하도록
   while(rs.next()){
      //playlist_id는 순서대로 플레이리스트 번호이므로
      int playlist_id = rs.getRow();
      String playlist_title = rs.getString("playlist_title");
   %>
      <div class="playlist-card" onclick="location.href ='<%= request.getContextPath() %>/workspace/workspace_edit_window.jsp?playlistTitle=<%= playlist_title%>'">
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
