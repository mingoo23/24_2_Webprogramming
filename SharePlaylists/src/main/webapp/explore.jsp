<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>


<link rel="stylesheet" href="explore_styles.css" />
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

	%>
	<div class="playlist-container">
	<%
	//플레이리스트 전부 출력하도록
	while(rs.next()){
		//playlist_id는 순서대로 플레이리스트 번호이므로
		int playlist_id = rs.getRow();
		String playlist_title = rs.getString("playlist_title");
	%>
	
		<div class="playlist-card" onclick="">
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
    <%-- <%
            }
        } 
        else {
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
    %> --%>
    </div>
</section>