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
            xhr.open('POST', 'friend_add.jsp', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

            // 요청 완료 후 결과 처리
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        document.getElementById('resultMessage').innerHTML = xhr.responseText;
                        refreshFriendList();
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
            xhr.open('GET', 'friend_list.jsp', true);

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
        <div id="friendList"></div>
    </div>
</section>
</body>
</html>