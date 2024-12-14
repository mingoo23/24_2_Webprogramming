package playlist;
import playlist.PlaylistDao;
import playlist.Playlist;

import java.sql.SQLException;
import java.util.List;

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
}
