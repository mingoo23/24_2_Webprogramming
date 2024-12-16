<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.MemberVo" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>웹프로그래밍 프로젝트</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="playBar.css">
</head>
<body>
    <header>
        <div class="left-menu">
            <div>
                <img src="logo.png" width="30" height="30" alt="로고">&nbsp;&nbsp;&nbsp;
            </div>
            <a href="#explore" class="tab-header active" data-file="explore.jsp">둘러보기</a>
            <a href="#my-workspace" class="tab-header" data-file="workspace/workspace.jsp">내 작업실</a>
        </div>

        <div class="auth right-menu">
            <%
                // 세션에서 사용자 정보 확인
                MemberVo user = (MemberVo) session.getAttribute("user");
                if (user != null) {
            %>
            
                <!-- 로그인 상태: 로그아웃 버튼 표시 -->
                <span>환영합니다, <%= user.getUsername() %> 님</span>
				<a href="javascript:void(0);" onclick="confirmLogout();">로그아웃</a>				
				
				<script>
				    function confirmLogout() {
				        if (confirm('정말 로그아웃 하시겠습니까?')) {
				            // 확인 버튼 클릭 시 로그아웃 서블릿 호출
				            window.location.href = "<%= request.getContextPath() %>/Logout";
				        }
				    }
				</script>            
			<%
                } else {
            %>
                <!-- 비로그인 상태: 로그인/회원가입 버튼 표시 -->
                <a href="<%= request.getContextPath() %>/member/login.jsp">로그인</a>
                <a href="<%= request.getContextPath() %>/member/join.jsp">회원가입</a>
            <%
                }
            %>
            <button class="menu-btn">&nbsp;☰&nbsp;</button>
        </div>
    </header>

    <main id="main-content">
        <!-- 초기 로드될 콘텐츠 -->
    </main>
    <section class="player">
        <!-- 재생 바 -->
        <article class="progress-bar">
            <div class="progress" style="width: 90%;"></div>
        </article>

        <!-- 컨트롤 버튼 -->
        <article class="playerBar">
            <div style="width: 200px;">
                <img src="thumnail.png" width="35" height="35" alt="썸네일">
                &nbsp;Up (Karina Solo)
            </div>
            <div class="controls">
                <button class="btn btn-prev">⏮</button>
                <button class="btn btn-play" id="playButton">▶</button>
                <button class="btn btn-next">⏭</button>
            </div>
            <div style="width: 200px; text-align: right;">
                <button class="btn btn-menu">▲</button>
            </div>
        </article>
    </section>

    <script src="scripts.js"></script>
    <script src="playBar.js"></script>
</body>
<footer>
    <div class="footer">
        <div>
            <img src="logo.png" width="70" height="70" alt="로고">&nbsp;&nbsp;&nbsp;
        </div>
        <div>
            <p style="font-size: 10px;">
                팀명 : 화이팅 | 2024년도 2학기 웹프로그래밍 1분반 팀프로젝트 | 학수번호 : CSE2015-01 | 교수님 : 송양의 <br>
                사용자들끼리 플레이리스트를 공유하고 음악에 대한 소통을 할 수 있는 공간을 제공하는 플랫폼
            </p>
            <p style="color: #FF7F00; font-size: 10px;">
                팀장 : 차민우 | 팀원 : 공기훈, 오정인
            </p>
        </div>
    </div>
</footer>
</html>