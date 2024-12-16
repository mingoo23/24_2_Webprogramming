package playlist;

import conn.DBConnect;
import playlist.Playlist;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PlaylistDao {
    private final DBConnect dbConnect = DBConnect.getInstance();

    // 모든 플레이리스트와 그에 속한 곡들을 가져오는 메서드
    public List<Playlist> getAllPlaylists() throws SQLException {
        List<Playlist> playlists = new ArrayList<>();
        String playlistSql = "SELECT playlist_id, playlist_title, track_count FROM playlist";
        String songSql = "SELECT song_id FROM songs WHERE playlist_id = ?"; // 해당 플레이리스트에 속한 곡들 가져오기

        try (Connection conn = dbConnect.conn();
             PreparedStatement pstmt = conn.prepareStatement(playlistSql);
             ResultSet rs = pstmt.executeQuery()) {

            // 모든 플레이리스트를 가져온 후
            while (rs.next()) {
                int playlistId = rs.getInt("playlist_id");
                String playlistTitle = rs.getString("playlist_title");
                int trackCount = rs.getInt("track_count");

                // 각 플레이리스트에 해당하는 곡들 가져오기
                List<String> songs = new ArrayList<>();
                try (PreparedStatement songStmt = conn.prepareStatement(songSql)) {
                    songStmt.setInt(1, playlistId);  // playlist_id로 곡들을 가져옴
                    try (ResultSet songRs = songStmt.executeQuery()) {
                        while (songRs.next()) {
                            songs.add(songRs.getString("song_id"));
                        }
                    }
                }

                // 플레이리스트 객체 생성 후 곡 목록 추가
                playlists.add(new Playlist(playlistId, playlistTitle, trackCount, songs));
            }
        }

        return playlists;
    }
    
 // 특정 사용자의 플레이리스트 가져오기
    public List<Playlist> getPlaylistsByUserId(String userId) throws SQLException {
        List<Playlist> playlists = new ArrayList<>();
        String playlistSql = "SELECT playlist_id, playlist_title, track_count FROM playlist WHERE user_id = ?";
        String songSql = "SELECT song_id FROM songs WHERE playlist_id = ?";

        try (Connection conn = dbConnect.conn();
             PreparedStatement pstmt = conn.prepareStatement(playlistSql)) {
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                int playlistId = rs.getInt("playlist_id");
                String playlistTitle = rs.getString("playlist_title");
                int trackCount = rs.getInt("track_count");

                // 곡 정보 가져오기
                List<String> songs = new ArrayList<>();
                try (PreparedStatement songStmt = conn.prepareStatement(songSql)) {
                    songStmt.setInt(1, playlistId);
                    ResultSet songRs = songStmt.executeQuery();
                    while (songRs.next()) {
                        songs.add(songRs.getString("song_id"));
                    }
                }

                playlists.add(new Playlist(playlistId, playlistTitle, trackCount, songs));
            }
        }

        return playlists;
    }
}
