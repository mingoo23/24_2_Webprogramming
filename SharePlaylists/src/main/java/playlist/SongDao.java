package playlist;

import java.sql.*;
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
}
