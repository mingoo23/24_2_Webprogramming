<%@ page import="java.util.List, playlist.Playlist" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*, member.MemberVo" %>
<link rel="stylesheet" href="./workspace/workspace_styles.css" />

<%
    // 세션에서 로그인된 사용자 정보 확인
    MemberVo user = (MemberVo) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/member/login.jsp");
        return;
    }

    // 로그인된 사용자의 ID
    String userId = user.getId();
%>

<section id="workspace-listen" class="workspace-tab-content">
    <div align="center">
        <h1>내 플레이리스트</h1>
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                // MySQL 연결 설정
                Class.forName("com.mysql.jdbc.Driver");
                String jdbcUrl = "jdbc:mysql://localhost:3306/playlists";
                conn = DriverManager.getConnection(jdbcUrl, "root", "0000");

                // 로그인된 사용자의 플레이리스트만 가져오는 SQL
                String sql = "SELECT * FROM playlist WHERE user_id = ? ORDER BY playlist_id ASC";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, userId); // 현재 로그인된 사용자의 ID를 바인딩
                rs = pstmt.executeQuery();
        %>

        <div class="playlist-container">
            <%
                // 플레이리스트 출력
                while (rs.next()) {
                    String playlistTitle = rs.getString("playlist_title");
            %>
                <div class="playlist-card" onclick="location.href = '<%= request.getContextPath() %>/workspace/player/testyoutube.html'">
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
                out.println("<p>DB 오류: " + e.getMessage() + "</p>");
            } finally {
                // 리소스 정리
                if (rs != null) try { rs.close(); } catch (Exception e) {}
                if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
                if (conn != null) try { conn.close(); } catch (Exception e) {}
            }
        %>

    </div>
</section>