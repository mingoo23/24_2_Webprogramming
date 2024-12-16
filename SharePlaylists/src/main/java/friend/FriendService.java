package friend;

import conn.DBConnect;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FriendService {
    private final DBConnect dbConnect = DBConnect.getInstance();

    // 친구 추가
    public boolean addFriend(String userId, String friendId) {
        String sql = "INSERT INTO friends (user_id, friend_id) VALUES (?, ?)";
        try (Connection conn = dbConnect.conn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            pstmt.setString(2, friendId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 친구들의 플레이리스트 가져오기
    public List<FriendPlaylistDto> getFriendPlaylists(String userId) {
        List<FriendPlaylistDto> friendPlaylists = new ArrayList<>();
        String sql = "SELECT u.id AS friend_id, u.username AS friend_name, " +
                     "p.playlist_title AS playlist_title, p.playlist_thumbnail AS thumbnail, p.track_count " +
                     "FROM friends f " +
                     "JOIN users u ON f.friend_id = u.id " +
                     "JOIN playlist p ON u.id = p.user_id " +
                     "WHERE f.user_id = ?";
        try (Connection conn = dbConnect.conn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                friendPlaylists.add(new FriendPlaylistDto(
                    rs.getString("friend_id"),
                    rs.getString("friend_name"),
                    rs.getString("playlist_title"),
                    rs.getString("thumbnail"),
                    rs.getInt("track_count")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return friendPlaylists;
    }

    // 전체 친구 수 반환
    public int getTotalFriendCount(String userId) {
        String sql = "SELECT COUNT(*) AS total FROM friends WHERE user_id = ?";
        try (Connection conn = dbConnect.conn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}