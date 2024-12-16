package playlist;

import java.util.List;

import java.sql.*;
import conn.DBConnect;
import playlist.*;

public class PlaylistService {
    private final PlaylistDao playlistDao = new PlaylistDao();
    private final SongDao songDao = new SongDao();
    
    // 플레이리스트 추가
    public int createPlaylist(String title) throws SQLException {
        return playlistDao.addPlaylist(title);
    }

    // 곡 추가
    public void addSongToPlaylist(String songId, int playlistId) throws SQLException {
        songDao.addSong(songId, playlistId);
    }
    
    // 플레이리스트 유저 아이디로 가져오기
    public List<Playlist> getPlaylistsByUserId(String userId) {
        try {
            return playlistDAO.getPlaylistsByUserId(userId);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to fetch playlists for user: " + userId, e);
        }
    }

}