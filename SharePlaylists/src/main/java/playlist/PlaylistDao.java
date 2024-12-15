package playlist;
import conn.DBConnect;
import playlist.Playlist;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PlaylistDao {
    private final DBConnect dbConnect = DBConnect.getInstance();

    public List<Playlist> getAllPlaylists() throws SQLException {
        List<Playlist> playlists = new ArrayList<>();
        String sql = "SELECT playlist_id, playlist_title, playlist_thumbnail, track_count FROM playlist";

        try (Connection conn = dbConnect.conn();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                playlists.add(new Playlist(
                    rs.getInt("playlist_id"),
                    rs.getString("playlist_title"),
                    rs.getString("playlist_thumbnail"),
                    rs.getInt("track_count")
                ));
            }
        }

        return playlists;
    }
}
