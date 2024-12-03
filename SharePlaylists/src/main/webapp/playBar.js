const playButton = document.getElementById("playButton");

// 버튼 상태 토글 함수
playButton.addEventListener("click", () => {
  if (playButton.textContent === "▶") {
    // Play 상태 -> Pause로 변경
    playButton.textContent = "❚❚";
    console.log("Play 상태");
  } else {
    // Pause 상태 -> Play로 변경
    playButton.textContent = "▶";
    console.log("Pause 상태");
  }
});