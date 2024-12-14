package conn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

// 싱글톤
public class DBConnect {
    private static DBConnect dbconn = new DBConnect();
    private String url = "jdbc:mysql://localhost:3306/MusicApp?serverTimezone=UTC";
    private String username = "root"; // MySQL 사용자 이름
    private String password = "0000"; // MySQL 비밀번호

    private DBConnect() {}

    public static DBConnect getInstance() {
        return dbconn; // 모든 db 작업을 이 conn 객체로 실행
    }

    // db 연결할 때 쓰는 클래스. Connection 타입으로 반환.
    public Connection conn() throws SQLException {
        try {
            // 드라이버 로드
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // 디버그 로그 추가
            System.out.println("Connecting to database with URL: " + url);
            System.out.println("Using username: " + username);
            // 세션 수립 (로그인)
            return DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("MySQL 드라이버 로드 실패");
        }
    }
    public void testConnection() {
        try (Connection conn = this.conn()) {
            if (conn != null) {
                System.out.println("Database connection successful!");
            } else {
                System.out.println("Failed to connect to the database.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error during database connection test.");
        }
    }
}