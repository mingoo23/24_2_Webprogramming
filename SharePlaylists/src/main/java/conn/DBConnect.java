package conn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {
    private static DBConnect dbconn = new DBConnect();
    private String url = "jdbc:mysql://localhost:3306/MusicApp?serverTimezone=UTC"; // DB URL
    private String username = "root"; // DB 사용자 이름
    private String password = "0000"; // DB 비밀번호

    private DBConnect() {}

    public static DBConnect getInstance() {
        return dbconn; 
    }

    public Connection conn() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL 드라이버 로드 실패");
            e.printStackTrace();
            throw new SQLException("드라이버 로드 오류", e);
        }
    }

    // **테스트 메서드**: 연결 확인용
    public static void testConnection() {
        try (Connection conn = DBConnect.getInstance().conn()) {
            if (conn != null) {
                System.out.println("DB 연결 성공!");
            } else {
                System.out.println("DB 연결 실패...");
            }
        } catch (SQLException e) {
            System.out.println("DB 연결 중 오류 발생:");
            e.printStackTrace();
        }
    }
}