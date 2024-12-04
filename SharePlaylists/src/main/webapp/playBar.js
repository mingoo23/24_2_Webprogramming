// 버튼 상태를 토글하는 함수
function togglePlayButton() {
  const playButton = document.getElementById("playPauseBtn"); // 버튼 객체 가져오기

  if (playButton.textContent === "▶") {
    // Play 상태 -> Pause로 변경
    playButton.textContent = "❚❚";
    console.log("Play 상태");
  } else {
    // Pause 상태 -> Play로 변경
    playButton.textContent = "▶";
    console.log("Pause 상태");
  }
}
