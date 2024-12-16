package playlist;

import java.sql.*;
import conn.DBConnect;

public class SongDao {
    private Connection conn;

    public SongDao() {
    	try {
    		this.conn = DBConnect.getInstance().conn(); // SQLException 처리
    		} catch (SQLException e) {
    			throw new RuntimeException("DB 연결에 실패했습니다: " + e.getMessage(), e);
    			}
    }

    // 곡 추가
    public void addSong(String songId, int playlistId) throws SQLException {
        String query = "INSERT INTO songs (song_id, playlist_id) VALUES (?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, songId);
            stmt.setInt(2, playlistId);
            stmt.executeUpdate();
        }
    }
}
