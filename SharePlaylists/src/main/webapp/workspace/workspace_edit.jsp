<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, member.MemberVo" %>

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

<%
    // 세션에서 로그인된 사용자 정보 확인
    MemberVo user = (MemberVo) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/member/login.jsp");
        return;
    }

    // 현재 로그인한 사용자의 ID 가져오기
    String userId = user.getId();
%>

<section id="workspace-listen" class="workspace-tab-content">
    <div align="center">
        <h1>내 플레이리스트</h1>
    </div>        
    
    <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String jdbcUrl = "jdbc:mysql://localhost:3306/playlists";
            conn = DriverManager.getConnection(jdbcUrl, "root", "0000");

            // 현재 로그인된 사용자(userId)의 플레이리스트만 가져오기
            String sql = "SELECT * FROM playlist WHERE user_id = ? ORDER BY playlist_id ASC";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
    %>

    <!-- '새 플레이리스트 추가' 버튼 -->
    <div class="playlist-container">
        <div class="plus-button" onclick="location.href='<%= request.getContextPath() %>/workspace/workspace_createplaylist.jsp'">
            <span class="icon">+</span>
        </div>

        <%
            // 플레이리스트 출력
            while (rs.next()) {
                int playlistId = rs.getInt("playlist_id");
                String playlistTitle = rs.getString("playlist_title");
        %>
                <div class="playlist-card" onclick="location.href='<%= request.getContextPath() %>/workspace/workspace_edit_window.jsp?playlistTitle=<%= playlistTitle %>&playlistId=<%= playlistId %>'">
                    <div class="thumbnail">
                        <img src="thumnail.png" alt="썸네일 없음" />
                    </div>
                    <div class="card-content">
                        <div class="title"><%= playlistTitle %></div>
                    </div>
                </div>
        <%
            }
        %>
    </div>

    <%
        } catch (Exception e) {
            out.println("<p>DB 연동 오류: " + e.getMessage() + "</p>");
        } finally {
            // 리소스 정리
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }
    %>
</section>