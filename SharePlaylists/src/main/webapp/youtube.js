let player;
let playlist = ["phuiiNCxRMg", "ZZ5LpwO-An4", "y6120QOlsfU"];
let currentTrack = 0;

// document.getElementById("playButton").onclick = playPause;
document.getElementById("nextBtn").onclick = playNext;

function onYouTubeIframeAPIReady() {
  player = new YT.Player("player", {
    height: "360",
    width: "640",
    videoId: playlist[currentTrack],
    playerVars: {
      playsinline: 1,
    },
    events: {
      onReady: onPlayerReady,
      onStateChange: onPlayerStateChange,
    },
  });
}

const playButton = document.getElementById("playButton");

// 버튼 상태 토글 및 동영상 제어 통합 함수
playButton.addEventListener("click", () => {
  if (player.getPlayerState() === YT.PlayerState.PLAYING) {
    // YouTube 동영상 일시정지
    player.pauseVideo();

    // 버튼 텍스트를 Pause에서 Play로 변경
    playButton.textContent = "▶";
    console.log("Pause 상태");
  } else {
    // YouTube 동영상 재생
    player.playVideo();

    // 버튼 텍스트를 Play에서 Pause로 변경
    playButton.textContent = "❚❚";
    console.log("Play 상태");
  }
});

function onPlayerReady(event) {
  updatePlaylist();
}

function onPlayerStateChange(event) {
  if (event.data == YT.PlayerState.ENDED) {
    playNext();
  }
}

function playPause() {
  if (player.getPlayerState() == YT.PlayerState.PLAYING) {
    player.pauseVideo();
  } else {
    player.playVideo();
  }
}

function playNext() {
  currentTrack = (currentTrack + 1) % playlist.length;
  player.loadVideoById(playlist[currentTrack]);
}

function updatePlaylist() {
  const playlistElement = document.getElementById("playlist");
  playlistElement.innerHTML = "";
  playlist.forEach((videoId, index) => {
    const item = document.createElement("div");
    item.textContent = `트랙 ${index + 1}`;
    item.onclick = () => {
      currentTrack = index;
      player.loadVideoById(videoId);
    };
    playlistElement.appendChild(item);
  });
}
