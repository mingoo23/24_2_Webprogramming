<%@page import="com.mysql.cj.protocol.ResultsetRowsOwner"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<section id="explore" class="tab-content active">
    <div class="filter-section">
        <button class="filter-btn active" data-filter="latest">최신순</button>
        <button class="filter-btn" data-filter="popular">인기순</button>
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
	
	//플레이리스트 전부 출력하도록
	while(rs.next()){
		//playlist_id는 순서대로 플레이리스트 번호이므로
		int playlist_id = rs.getRow();
		String playlist_title = rs.getString("playlist_title");
		String playlist_thumbnail = rs.getString("playlist_thumbnail");
		int track_count = Integer.parseInt(rs.getString("track_count"));
	
	%>
    <div class="playlist-grid">
		<img alt="썸네일 없음" src="<%=rs.getString("playlist_thumbnail") %>">
		
		<p><%=track_count%></p>
		<p><%=playlist_title %></p>
    </div>
    <%
    playlist_id--;//필요한지 모르겠음
	}
    %>
</section>