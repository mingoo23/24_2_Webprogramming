package playlist;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import conn.DBConnect;

public class SongDao {

	private static final String INSERT_SONG_SQL = "INSERT INTO songs (song_id, playlist_id) VALUES (?, ?)";
	
	public boolean insertSong(String songId, int playlistId) throws SQLException{
		try (Connection connection = DBConnect.getInstance().conn();
	             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_SONG_SQL)) {
	            preparedStatement.setString(1, songId);
	            preparedStatement.setInt(2, playlistId);

	            int rowsAffected = preparedStatement.executeUpdate();
	            return rowsAffected > 0;
	        }
	}
	
    public List<Song> getSongsByPlaylistId(int playlistId) {
        List<Song> songs = new ArrayList<>();
        String sql = "SELECT song_id FROM songs WHERE playlist_id = ?";

        try (Connection conn = DBConnect.getInstance().conn(); // DBConnect 사용
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, playlistId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String songId = rs.getString("song_id");
                    songs.add(new Song(songId));  // Song 객체에 곡 ID만 담은 예시
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return songs;
    }
}
