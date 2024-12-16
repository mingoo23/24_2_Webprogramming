package playlist;

import java.util.List;

public class SongService {
    private SongDao songDao;

    public SongService() {
        this.songDao = new SongDao();
    }
    
    public boolean addSongToPlaylist(String songId, int playlistId) throws Exception {
        if (songId == null || songId.isEmpty()) {
            throw new IllegalArgumentException("Song ID cannot be null or empty");
        }

        return songDao.insertSong(songId, playlistId);
    }
    
 // 주어진 playlistId에 해당하는 곡 목록을 반환하는 메서드
    public List<Song> getSongsByPlaylistId(int playlistId) throws Exception {
        if (playlistId <= 0) {
            throw new IllegalArgumentException("Invalid playlist ID");
        }

        return songDao.getSongsByPlaylistId(playlistId);
    }
}
