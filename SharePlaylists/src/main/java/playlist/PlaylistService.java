package playlist;

import conn.DBConnect;
import playlist.Playlist;
import playlist.PlaylistDao;

import java.sql.*;
import java.util.List;

public class PlaylistService {
    private final PlaylistDao playlistDAO = new PlaylistDao();

    // 모든 플레이리스트와 그에 속한 곡들을 가져오는 메서드
    public List<Playlist> getPlaylists() {
        try {
            return playlistDAO.getAllPlaylists();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to fetch playlists", e);
        }
    }

    // 플레이리스트 생성 및 곡 추가
    public void addPlaylist(Playlist playlist, List<String> songIds) {
        String playlistQuery = "INSERT INTO playlist (playlist_title, track_count) VALUES (?, ?)";
        String songQuery = "INSERT INTO songs (song_id, playlist_id) VALUES (?, ?)";

        try (Connection conn = DBConnect.getInstance().conn()) {
            // 플레이리스트 정보 삽입
            try (PreparedStatement playlistStmt = conn.prepareStatement(playlistQuery, Statement.RETURN_GENERATED_KEYS)) {
                playlistStmt.setString(1, playlist.getTitle());
                playlistStmt.setInt(2, songIds.size()); // 트랙 수는 songIds의 크기

                playlistStmt.executeUpdate();

                // 플레이리스트 ID 얻기
                try (ResultSet generatedKeys = playlistStmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int playlistId = generatedKeys.getInt(1);

                        // 곡 정보 삽입
                        try (PreparedStatement songStmt = conn.prepareStatement(songQuery)) {
                            for (String songId : songIds) {
                                songStmt.setString(1, songId);
                                songStmt.setInt(2, playlistId);
                                songStmt.addBatch();  // 배치로 곡 삽입
                            }
                            songStmt.executeBatch();  // 배치 실행
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("플레이리스트 저장 중 오류 발생: " + e.getMessage(), e);
        }
    }
}
