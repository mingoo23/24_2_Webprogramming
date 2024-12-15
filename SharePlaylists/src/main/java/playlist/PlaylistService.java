package playlist;
import playlist.PlaylistDao;
import playlist.Playlist;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import conn.DBConnect;

public class PlaylistService {
    private final PlaylistDao playlistDAO = new PlaylistDao();

    public List<Playlist> getPlaylists() {
        try {
            return playlistDAO.getAllPlaylists();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to fetch playlists", e);
        }
    }
    
    //플레이리스트 생성
    public void addPlaylist(Playlist playlist) {
        String query = "INSERT INTO playlist (playlist_title, playlist_thumbnail, track_count) VALUES (?, ?, ?)";

        try (Connection conn = DBConnect.getInstance().conn();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, playlist.getTitle());
            stmt.setString(2, playlist.getThumbnail());
            stmt.setInt(3, playlist.getTrackCount());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("플레이리스트 저장 중 오류 발생: " + e.getMessage(), e);
        }
        
    }
}


