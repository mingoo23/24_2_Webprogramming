let player;
let playlist = ['phuiiNCxRMg', 'ZZ5LpwO-An4', 'y6120QOlsfU'];
let currentTrack = 0;

function onYouTubeIframeAPIReady() {
    player = new YT.Player('player', {
        height: '360',
        width: '640',
        videoId: playlist[currentTrack],
        playerVars: {
            'playsinline': 1
        },
        events: {
            'onReady': onPlayerReady,
            'onStateChange': onPlayerStateChange
        }
    });
}

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
    const playlistElement = document.getElementById('playlist');
    playlistElement.innerHTML = '';
    playlist.forEach((videoId, index) => {
        const item = document.createElement('div');
        item.textContent = `트랙 ${index + 1}`;
        item.onclick = () => {
            currentTrack = index;
            player.loadVideoById(videoId);
        };
        playlistElement.appendChild(item);
    });
}

document.getElementById('playPauseBtn').onclick = playPause;
document.getElementById('nextBtn').onclick = playNext;