<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="friend.FriendService, friend.FriendPlaylistDto, java.util.List, member.MemberVo" %>
<%
    // 세션에서 로그인된 사용자 객체 가져오기
    MemberVo user = (MemberVo) session.getAttribute("user");

    // 로그인되지 않은 사용자는 로그인 페이지로 이동
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/member/login.jsp");
        return;
    }

    String userId = user.getId(); // 사용자의 ID 가져오기

    // FriendService 객체 생성
    FriendService service = new FriendService();

    // 친구들의 플레이리스트 가져오기
    List<FriendPlaylistDto> friendPlaylists = service.getFriendPlaylists(userId);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>친구 추가 페이지</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/workspace/workspace_styles.css">
    <script>
    function addFriend() {
        const friendId = document.getElementById('friendId').value;

        // 비어있으면 경고
        if (!friendId.trim()) {
            alert('ID를 입력해주세요.');
            return;
        }

        // AJAX 요청 생성
        const xhr = new XMLHttpRequest();
        xhr.open('POST', '<%= request.getContextPath() %>/FriendAdd', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

        // 요청 완료 후 결과 처리
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    const response = JSON.parse(xhr.responseText); // JSON 응답 파싱

                    // 결과 메시지 출력
                    const resultMessage = document.getElementById('resultMessage');
                    resultMessage.style.color = response.status === "success" ? "green" : "red";
                    resultMessage.innerText = response.message;

                    // 친구 리스트 새로고침 (성공한 경우만)
                    if (response.status === "success") {
                        refreshFriendList();
                    }
                } else {
                    alert('친구 추가 중 오류가 발생했습니다.');
                }
            }
        };

        // 데이터 전송
        xhr.send('friendId=' + encodeURIComponent(friendId));
    }

        // 친구 리스트 새로고침 함수
        function refreshFriendList() {
            const xhr = new XMLHttpRequest();
            xhr.open('GET', '<%= request.getContextPath() %>/FriendList', true);

            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    document.getElementById('friendList').innerHTML = xhr.responseText;
                }
            };

            xhr.send();
        }

        // 페이지 로드 시 친구 리스트 불러오기
        window.onload = function () {
            refreshFriendList();
        };
    </script>
</head>
<body>
<section id="workspace-social" class="workspace-tab-content">
    <div align="center">
        <h1>친구 추가</h1>        
        <p>환영합니다, <%= user.getUsername() %>님!</p>

        <%-- 친구 추가 폼 --%>
        <table border="0" width="70%">
            <tr style="height: 80px">
                <th class="title-category">친구 추가</th>
                <td class="td-container">
                    <input
                        type="text"
                        id="friendId"
                        class="input-window"
                        placeholder="ID를 입력해주세요."
                        required
                    />
                    <button class="button btnPush btnOrange" onclick="addFriend()">친구 추가</button>
                </td>
            </tr>
        </table>

        <%-- 결과 메시지 --%>
        <p id="resultMessage" style="color: green;"></p>

        <%-- 친구들의 플레이리스트 출력 --%>
        <div id="friendList">
		    <% if (friendPlaylists != null && !friendPlaylists.isEmpty()) { %>
		        <% for (FriendPlaylistDto playlist : friendPlaylists) { %>
		            <div class="playlist-container">
		                <div class="playlist-card">
		                    <div class="thumbnail">
		                        <img src="<%= playlist.getThumbnail() %>" alt="플레이리스트 썸네일" />
		                    </div>
		                    <div class="card-content">
		                        <div class="track-count"><%= playlist.getTrackCount() %> Tracks</div>
		                        <div class="title"><%= playlist.getPlaylistTitle() %></div>
		                    </div>
		                </div>
		            </div>
		        <% } %>
		    <% } else { %>
		        <p>추가된 친구가 없습니다. 친구를 추가해보세요!</p>
		        
		    <% } %>
		</div>
    </div>
</section>
</body>
</html>