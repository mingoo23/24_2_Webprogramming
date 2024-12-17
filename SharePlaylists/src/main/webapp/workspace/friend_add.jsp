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
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>친구 추가 및 플레이리스트</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/workspace/workspace_styles.css">
    <script>
        // 친구 추가 함수
        function addFriend() {
            const friendId = document.getElementById('friendId').value;

            if (!friendId.trim()) {
                alert('ID를 입력해주세요.');
                return;
            }

            // AJAX 요청 생성
            const xhr = new XMLHttpRequest();
            xhr.open('POST', '<%= request.getContextPath() %>/FriendAdd', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        const response = JSON.parse(xhr.responseText);

                        // 결과 메시지
                        const resultMessage = document.getElementById('resultMessage');
                        resultMessage.style.color = response.status === "success" ? "green" : "red";
                        resultMessage.innerText = response.message;

                        // 플레이리스트 새로고침
                        if (response.status === "success") {
                            refreshFriendList();
                        }
                    } else {
                        alert('친구 추가 중 오류가 발생했습니다.');
                    }
                }
            };

            xhr.send('friendId=' + encodeURIComponent(friendId));
        }

        // 친구 플레이리스트 새로고침 함수
        function refreshFriendList() {
            const xhr = new XMLHttpRequest();
            xhr.open('GET', '<%= request.getContextPath() %>/FriendList', true);

            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    const friendList = JSON.parse(xhr.responseText);
                    const friendListContainer = document.getElementById('friendList');
                    friendListContainer.innerHTML = ""; // 기존 내용 초기화

                    if (friendList.length > 0) {
                        friendList.forEach(playlist => {
                            const card = `
                                <div class="playlist">
                                    <p class="playlist-title">플레이리스트 제목: ${playlist.playlistTitle}</p>
                                    <p class="friend-name">친구 이름: ${playlist.friendName}</p>
                                </div>
                            `;
                            friendListContainer.innerHTML += card;
                        });
                    } else {
                        friendListContainer.innerHTML = "<p>친구의 플레이리스트가 없습니다.</p>";
                    }
                }
            };

            xhr.send();
        }

        // 페이지 로드 시 플레이리스트 불러오기
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

        <!-- 친구 추가 폼 -->
        <table border="0" width="70%">
            <tr style="height: 80px">
                <th class="title-category">친구 추가</th>
                <td class="td-container">
                    <input type="text" id="friendId" class="input-window" placeholder="ID를 입력해주세요." required />
                    <button class="button btnPush btnOrange" onclick="addFriend()">친구 추가</button>
                </td>
            </tr>
        </table>

        <!-- 결과 메시지 -->
        <p id="resultMessage" style="color: green;"></p>

        <!-- 친구 플레이리스트 -->
        <h1>친구의 플레이리스트</h1>
        <div id="friendList">
    	<p>친구의 플레이리스트를 불러오는 중...</p>
		</div>
    </div>
</section>
</body>
</html>