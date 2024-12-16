package playlist;

import conn.DBConnect;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class PlaylistDao {
    private Connection conn;

    public PlaylistDao() {
    	try {
    		this.conn = DBConnect.getInstance().conn(); // SQLException 처리
    		} catch (SQLException e) {
    			throw new RuntimeException("DB 연결에 실패했습니다: " + e.getMessage(), e);
    			}
    }

    // 플레이리스트 추가
    public int addPlaylist(String playlistTitle) throws SQLException {
        String query = "INSERT INTO playlist (playlist_title) VALUES (?)";
        try (PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, playlistTitle);
            stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // 생성된 playlist_id 반환
            }
        }
        return -1; // 실패
    }

    // 뷰에서 플레이리스트 가져오기
    public List<Playlist> getAllPlaylists() throws SQLException {
        String query = "SELECT * FROM playlist_with_track_count";
        List<Playlist> playlists = new ArrayList<>();
        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                playlists.add(new Playlist(
                        rs.getInt("playlist_id"),
                        rs.getString("playlist_title"),
                        rs.getInt("track_count")
                ));
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


//
//public class PlaylistDao {
//    private final DBConnect dbConnect = DBConnect.getInstance();
//
//    public void addPlaylist(Playlist playlist) {
//        String query = "INSERT INTO playlist (playlist_title, track_count) VALUES (?, ?)";
//
//        try (Connection conn = dbConnect.conn();
//             PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
//
//            stmt.setString(1, playlist.getTitle());
//            stmt.setInt(2, playlist.getTrackCount());
//            stmt.executeUpdate();
//
//            ResultSet rs = stmt.getGeneratedKeys();
//            if (rs.next()) {
//                playlist.setId(rs.getInt(1));
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//            throw new RuntimeException("플레이리스트 저장 중 오류: " + e.getMessage(), e);
//        }
//    }
//
//    public List<Playlist> getAllPlaylists() {
//        List<Playlist> playlists = new ArrayList<>();
//        String query = "SELECT playlist_id, playlist_title, track_count FROM playlist";
//
//        try (Connection conn = dbConnect.conn();
//             PreparedStatement stmt = conn.prepareStatement(query);
//             ResultSet rs = stmt.executeQuery()) {
//
//            while (rs.next()) {
//                playlists.add(new Playlist(
//                    rs.getInt("playlist_id"),
//                    rs.getString("playlist_title"),
//                    rs.getInt("track_count")
//                ));
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//            throw new RuntimeException("플레이리스트 조회 중 오류: " + e.getMessage(), e);
//        }
//
//        return playlists;
//    }
//}
