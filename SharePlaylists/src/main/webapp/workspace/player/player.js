let player;
let playlist = ['phuiiNCxRMg', 'ZZ5LpwO-An4', 'y6120QOlsfU']; // YouTube 비디오 ID 리스트
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
}

// 플레이어 준비 시 호출
function onPlayerReady(event) {
  updatePlaylist(); // 플레이리스트 갱신
}

// 영상이 끝나면 다음 트랙 자동 재생
function onPlayerStateChange(event) {
  if (event.data === YT.PlayerState.ENDED) {
    playNext();
  }
}

// 재생/일시정지 토글
function playPause() {
  const playButton = document.getElementById("playButton");

  if (player.getPlayerState() === YT.PlayerState.PLAYING) {
    player.pauseVideo();
    playButton.textContent = "▶"; // Play 상태
  } else {
    player.playVideo();
    playButton.textContent = "❚❚"; // Pause 상태
  }
}

// 다음 트랙 재생
function playNext() {
  currentTrack = (currentTrack + 1) % playlist.length; // 다음 트랙으로 순환
  player.loadVideoById(playlist[currentTrack]);
  updatePlayButton();
}

// 이전 트랙 재생
function playPrev() {
  currentTrack = (currentTrack - 1 + playlist.length) % playlist.length; // 이전 트랙으로 순환
  player.loadVideoById(playlist[currentTrack]);
  updatePlayButton();
}

// 플레이리스트 화면 갱신
function updatePlaylist() {
  const playlistElement = document.getElementById('playlist');
  playlistElement.innerHTML = '';

  playlist.forEach((videoId, index) => {
    const item = document.createElement('div');
    item.textContent = `트랙 ${index + 1}`; // 트랙 이름
    item.onclick = () => {
      currentTrack = index;
      player.loadVideoById(videoId);
      updatePlayButton();
    };
    playlistElement.appendChild(item);
  });
}

// 플레이 버튼 상태 업데이트
function updatePlayButton() {
  const playButton = document.getElementById("playButton");
  playButton.textContent = "❚❚"; // 새 비디오가 재생되면 Pause 버튼으로
}

// 버튼 이벤트 리스너 추가
document.addEventListener("DOMContentLoaded", function () {
  const playButton = document.getElementById("playButton");
  const prevButton = document.querySelector(".btn-prev");
  const nextButton = document.getElementById("nextBtn");

  // 재생/일시정지 버튼
  playButton.addEventListener("click", playPause);

  // 이전 곡 버튼
  prevButton.addEventListener("click", function () {
    console.log("이전 곡 재생");
    playPrev();
  });

  // 다음 곡 버튼
  nextButton.addEventListener("click", function () {
    console.log("다음 곡 재생");
    playNext();
  });
});
