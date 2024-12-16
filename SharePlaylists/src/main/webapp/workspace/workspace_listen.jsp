<%@ page import="java.util.List, playlist.Playlist" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<link rel="stylesheet" href="./workspace/workspace_styles.css" />
<%@ page import="java.sql.*" %>

<section id="workspace-listen" class="workspace-tab-content">
<div align="center">
    <h1>내 플레이리스트</h1>
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
            	<img src="thumbnail.png" alt="썸네일 없음" />
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