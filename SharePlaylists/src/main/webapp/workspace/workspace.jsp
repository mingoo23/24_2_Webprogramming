<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.MemberVo" %>

<%
    // 세션에서 사용자 정보 확인
    MemberVo user = (MemberVo) session.getAttribute("user");

	//로그인하지 않은 경우
	 if (user == null) {
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        /* 알림 메시지 스타일 */
        .notification {
            background-color: #f44336;
            color: white;
            text-align: center;
            padding: 10px;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>
    <div class="notification">
        로그인이 필요합니다. 로그인 페이지로 이동합니다.
    </div>
    <script>
        // 3초 후 로그인 페이지로 이동
        setTimeout(function() {
            window.location.href = '<%= request.getContextPath() %>/member/login.jsp';
        }, 1000);
    </script>
</body>
</html>
	<%
	    return; // 이후 코드 실행 중지
	}
%>

<script src="./workspace/workspace_tab.js"></script>
<link rel="stylesheet" href="./workspace/workspace_styles.css" />
<section id="my-workspace" class="tab-content">
  <div class="workspace-tab">
    <a href="#workspace-listen" class="workspace-header active" data-file="./workspace/workspace_listen.jsp">듣기</a>
    <a href="#workspace-edit" class="workspace-header" data-file="./workspace/workspace_edit.jsp">수정</a>
    <a href="#workspace-social" class="workspace-header" data-file="./workspace/friend_add.jsp">친구</a>
  </div>

  <div id="workspace-content">
  </div>
</section>