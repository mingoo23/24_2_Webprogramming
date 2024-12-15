<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>웹프로그래밍 프로젝트</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="styles.css">
    <link  rel="stylesheet" href="playBar.css"></style>
</head>
<body>
    <header>
        <div class="left-menu">
            <div><img src="logo.png" width="30" height="30" alt="로고">&nbsp;&nbsp;&nbsp;</div>
            <a href="#explore" class="tab-header active" data-file="explore.jsp">둘러보기</a>
            <a href="#my-workspace" class="tab-header" data-file="workspace/workspace.jsp">내 작업실</a>
        </div>
        
        <div class="auth right-menu">
            <a href="login.jsp">로그인</a> <a href="#">회원가입</a>
            <button class="menu-btn">&nbsp;☰&nbsp;</button>
        </div>
    </header>

    <main id="main-content">
        <!--초기 로드될 콘텐츠-->
    </main>
	<section class="player">
	
	<!-- 재생 바 -->
  	<article class="progress-bar">
    	<div class="progress" style="width: 90%;"></div>
  	</article>
  	
	<!-- 컨트롤 버튼 -->
	<article class="playerBar">
		<div style="width: 200px;">
		<img src="thumnail.png" width="35" height="35" alt="ì¸ë¤ì¼">
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
    <script src="playBar.js">
    </script>
</body>
<footer>
	<div class="footer">
    	<div><img src="logo.png" width="70" height="70" alt="ë¡ê³ ">&nbsp;&nbsp;&nbsp;</div>
    	<div>
    	<p style="font-size: 10px;">팀명 : 화이팅 | 2024년도 2학기 웹프로그래밍 1분반 팀프로젝트 | 학수번호 : CSE2015-01 | 교수님 : 송양의 <br>
            사용자들끼리 플레이리스트를 공유하고 음악에 대한 소통을 할 수 있는 공간을 제공하는 플랫폼</p>
		<p style="color: #FF7F00; font-size: 10px;">팀장 : 차민우 | 팀원 : 공기훈, 오정인</p>
		</div>
  	</div>
    </footer>
</html>