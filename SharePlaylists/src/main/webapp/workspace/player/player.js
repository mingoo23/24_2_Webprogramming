let player;
//let playlist = ['phuiiNCxRMg', 'ZZ5LpwO-An4', 'y6120QOlsfU']; // YouTube 비디오 ID 리스트
let playlistTitles = []; // 제목 저장 배열
let currentTrack = 0;

// YouTube IFrame API가 준비되었을 때 호출되는 함수
function onYouTubeIframeAPIReady() {
  player = new YT.Player('player', {
    height: '360',
    width: '640',
    videoId: playlist[currentTrack], // 초기 재생 영상
    playerVars: {
      'playsinline': 1
    },
    events: {
      'onReady': onPlayerReady,
      'onStateChange': onPlayerStateChange
    }
  });

  // 모든 동영상 제목 가져오기
  fetchPlaylistTitles();
}

// 모든 동영상의 제목을 가져오기
async function fetchPlaylistTitles() {
  const apiKey = "YOUR_API_KEY"; // API 키 입력
  for (let videoId of playlist) {
    const url = `https://www.googleapis.com/youtube/v3/videos?part=snippet&id=${videoId}&key=${apiKey}`;
    try {
      const response = await fetch(url);
      const data = await response.json();
      if (data.items && data.items.length > 0) {
        playlistTitles.push(data.items[0].snippet.title); // 제목 저장
      } else {
        playlistTitles.push("제목 없음");
      }
    } catch (error) {
      console.error("API 요청 오류:", error);
      playlistTitles.push("오류 발생");
    }
  }
  updatePlaylist(); // 제목 갱신 후 화면 업데이트
}

// 플레이어 준비 시 호출
function onPlayerReady(event) {
  updatePlaylist(); // 플레이리스트 갱신
}

// 플레이리스트 화면 갱신
function updatePlaylist() {
  const playlistElement = document.getElementById('playlist');
  playlistElement.innerHTML = '';

  playlist.forEach((videoId, index) => {
    const item = document.createElement('div');
    item.textContent = playlistTitles[index] || `트랙 ${index + 1}`; // 제목이 없으면 트랙 번호 표시
    item.onclick = () => {
      currentTrack = index;
      player.loadVideoById(videoId);
    };
    playlistElement.appendChild(item);
  });
}
