document.addEventListener("DOMContentLoaded", function () {
    console.log("DOMContentLoaded 실행됨"); // DOM 로드 확인

    refreshFriendList();
});

function refreshFriendList() {
    console.log("refreshFriendList 함수 호출됨"); // 함수 호출 확인

    const xhr = new XMLHttpRequest();
    xhr.open('GET', '/SharePlaylists/FriendList', true);

    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            console.log("AJAX 요청 상태: ", xhr.status); // AJAX 상태 확인
            if (xhr.status === 200) {
                console.log("서버 응답: ", xhr.responseText); // 서버에서 받은 JSON 확인
                const friendList = JSON.parse(xhr.responseText);

                const friendListContainer = document.getElementById('friendList');
                friendListContainer.innerHTML = ""; // 기존 내용 초기화

                if (friendList.length > 0) {
                    friendList.forEach(playlist => {
                        const card = `
                            <div class="playlist-card-social">
                                <div class="card-content">
                                    <div class="title">플레이리스트: ${playlist.playlistTitle}</div>
                                    <div class="friend-name">친구 이름: ${playlist.friendName}</div>
                                    <div class="track-count">트랙 수: ${playlist.trackCount}</div>
                                </div>
                            </div>
                        `;
                        friendListContainer.innerHTML += card;
                    });
                } else {
                    friendListContainer.innerHTML = "<p>친구의 플레이리스트가 없습니다.</p>";
                }
            } else {
                console.error("AJAX 실패 상태: ", xhr.status);
            }
        }
    };

    xhr.send();
    console.log("AJAX 요청 전송됨");
}