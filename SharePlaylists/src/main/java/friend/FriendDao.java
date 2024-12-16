package friend;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import conn.DBConnect;
import playlist.Playlist;

public class FriendDao {
    private DBConnect dbConnect;

    public FriendDao() {
        dbConnect = DBConnect.getInstance();
    }

    // 친구 추가 (중복 검사 포함)
    public boolean addFriend(Friend friend) {
        String checkSql = "SELECT * FROM friends WHERE user_id = ? AND friend_id = ?";
        String insertSql = "INSERT INTO friends (user_id, friend_id) VALUES (?, ?)";

        try (Connection conn = dbConnect.conn()) {
            System.out.println("Debug: Checking for duplicate friend entry. userId=" 
                + friend.getUserId() + ", friendId=" + friend.getFriendId());
            
            // 중복 검사
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setString(1, friend.getUserId());
                checkStmt.setString(2, friend.getFriendId());
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next()) {
                    System.out.println("Debug: Duplicate friend entry found in DB.");
                    return false; // 중복된 친구
                }
            }

            // 친구 추가
            System.out.println("Debug: Attempting to insert friend into DB.");
            try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                insertStmt.setString(1, friend.getUserId());
                insertStmt.setString(2, friend.getFriendId());
                int result = insertStmt.executeUpdate();
                System.out.println("Debug: Rows affected = " + result);
                return result > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Debug: Exception occurred while adding friend.");
            return false;
        }
    }

    // 친구의 플레이리스트 조회
    public List<Playlist> getFriendPlaylists(String friendId) {
        List<Playlist> playlists = new ArrayList<>();
        String sql = "SELECT playlist_title, track_count, playlist_thumbnail FROM playlists WHERE user_id = ?";

        try (Connection conn = dbConnect.conn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, friendId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                playlists.add(new Playlist(
                    rs.getString("playlist_title"),
                    rs.getInt("track_count"),
                    rs.getString("playlist_thumbnail")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return playlists;
    }
}