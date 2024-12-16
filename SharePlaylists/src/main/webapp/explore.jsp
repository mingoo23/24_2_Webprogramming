<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<link rel="stylesheet" href="./workspace/workspace_styles.css" />

<section id="explore" class="tab-content active">
    <div class="filter-section">
        <button class="filter-btn active" data-filter="latest">최신순</button>
        <button class="filter-btn" data-filter="popular">인기순</button>
    </div>

    <%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // 드라이버 로드
        Class.forName("com.mysql.cj.jdbc.Driver");
        String jdbcUrl = "jdbc:mysql://localhost:3306/MusicApp";
        conn = DriverManager.getConnection(jdbcUrl, "root", "0000");

        // SQL 실행
        stmt = conn.createStatement();
        String sql = "SELECT * FROM playlist ORDER BY playlist_id ASC";
        rs = stmt.executeQuery(sql);

        // ResultSet 확인
        if (rs != null) {
            while (rs.next()) {
                String playlist_title = rs.getString("playlist_title");
    %>
                <div class="playlist-card">
                    <div class="thumbnail">
                        <img src="" alt="썸네일 없음" />
                    </div>
                    <div class="card-content">
                        <div class="title"><%= playlist_title %></div>
                    </div>
                </div>
    <%
            }
        } else {
            out.println("<p>플레이리스트가 존재하지 않습니다.</p>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>DB 연동 오류입니다.: " + e.getMessage() + "</p>");
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
    %>
</section>