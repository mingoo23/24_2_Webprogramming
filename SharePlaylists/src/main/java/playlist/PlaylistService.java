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
    
    // 플레이리스트 목록 가져오기
    public List<Playlist> getAllPlaylists() throws SQLException {
        return playlistDao.getAllPlaylists();
    }

//    public void addPlaylist(Playlist playlist) {
//        playlistDao.addPlaylist(playlist);
//    }
//
//    public List<Playlist> getPlaylists() {
//        return playlistDao.getAllPlaylists();
//    }
//
//    public void addSongToPlaylist(int playlistId, String link) {
//        songDao.addSong(playlistId, link);
//        updateTrackCount(playlistId);
//    }
//
//    private void updateTrackCount(int playlistId) {
//        String query = "UPDATE playlist SET track_count = " +
//                       "(SELECT COUNT(*) FROM songs WHERE playlist_id = ?) WHERE playlist_id = ?";
//
//        try (Connection conn = DBConnect.getInstance().conn();
//             PreparedStatement stmt = conn.prepareStatement(query)) {
//
//            stmt.setInt(1, playlistId);
//            stmt.setInt(2, playlistId);
//            stmt.executeUpdate();
//        } catch (SQLException e) {
//            e.printStackTrace();
//            throw new RuntimeException("track_count 갱신 중 오류: " + e.getMessage(), e);
//        }
//    }
}
