package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import conn.DBConnect;

public class MemberDao {
    private DBConnect dbconn;

    public MemberDao() {
        dbconn = DBConnect.getInstance();
    }

    // (primary key) id로 검색 (1 or 0개 검색)
    public MemberVo select(String id) {
        MemberVo vo = null;
        Connection conn = null;
        try {
            conn = dbconn.conn(); // 예외 처리
            String sql = "SELECT * FROM users WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);

            ResultSet rs = pstmt.executeQuery(); // select 실행
            if (rs.next()) { // 첫 줄로 이동하여 데이터 있는지 확인
                vo = new MemberVo(
                    rs.getString("id"),
                    rs.getString("password"),
                    rs.getString("username"),
                    rs.getString("email")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return vo;
    }

    // insert (회원가입)
    public void insert(MemberVo vo) {
        Connection conn = null;
        try {
            conn = dbconn.conn(); // DB 연결
            String sql = "INSERT INTO users (id, password, username, email) VALUES (?, ?, ?, ?)";
            System.out.println("Preparing SQL: " + sql);
            System.out.println("With data: id=" + vo.getId() + ", pwd=" + vo.getPwd() + ", username=" + vo.getUsername() + ", email=" + vo.getEmail());

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, vo.getId());
            pstmt.setString(2, vo.getPwd());
            pstmt.setString(3, vo.getUsername());
            pstmt.setString(4, vo.getEmail());

            int num = pstmt.executeUpdate(); // 실행
            if (num > 0) {
                System.out.println(num + " row(s) inserted successfully.");
            } else {
                System.out.println("No rows inserted. Check your data.");
            }
        } catch (SQLException e) {
            System.out.println("SQL Exception occurred while inserting data.");
            System.out.println("Error Code: " + e.getErrorCode());
            System.out.println("SQL State: " + e.getSQLState());
            System.out.println("Message: " + e.getMessage());
            e.printStackTrace(); // 전체 스택 추적
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.out.println("Error while closing the connection.");
                e.printStackTrace();
            }
        }
    }
    // update (id -> password, username)
    public void update(MemberVo vo) {
        Connection conn = null;
        try {
            conn = dbconn.conn(); // 예외 처리
            String sql = "UPDATE users SET password = ?, username = ? WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, vo.getPwd());
            pstmt.setString(2, vo.getUsername());
            pstmt.setString(3, vo.getId());
            int num = pstmt.executeUpdate();
            System.out.println(num + "줄이 수정되었습니다.");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    public void delete(String id) {
        if (id == null || id.trim().isEmpty()) {
            System.out.println("삭제할 ID가 유효하지 않습니다.");
            return;
        }

        Connection conn = null;
        try {
            conn = dbconn.conn(); // 예외 처리
            conn.setAutoCommit(false); // 트랜잭션 시작

            // 삭제할 데이터 확인
            String selectSql = "SELECT * FROM users WHERE id = ?";
            PreparedStatement selectPstmt = conn.prepareStatement(selectSql);
            selectPstmt.setString(1, id);
            ResultSet rs = selectPstmt.executeQuery();

            if (!rs.next()) {
                System.out.println("삭제할 데이터가 존재하지 않습니다. ID: " + id);
                return;
            } else {
                System.out.println("삭제할 데이터: " +
                    "ID=" + rs.getString("id") +
                    ", Username=" + rs.getString("username") +
                    ", Email=" + rs.getString("email"));
            }

            // 데이터 삭제
            String deleteSql = "DELETE FROM users WHERE id = ?";
            PreparedStatement deletePstmt = conn.prepareStatement(deleteSql);
            deletePstmt.setString(1, id);
            int num = deletePstmt.executeUpdate();

            if (num > 0) {
                System.out.println(num + "줄이 삭제되었습니다.");
            } else {
                System.out.println("삭제되지 않았습니다. ID: " + id);
            }

            conn.commit(); // 변경사항 저장
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback(); // 문제 발생 시 롤백
                System.out.println("롤백되었습니다.");
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}