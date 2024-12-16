package playlist.controller;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.MemberVo;

//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;

import playlist.Playlist;
import playlist.PlaylistService;

/**
 * Servlet implementation class PlaylistCreationServlet
 * 플레이리스트 생성 서블릿 - 제목만 입력받음
 */
@WebServlet("/PlaylistCreationServlet")
public class PlaylistCreationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final PlaylistService service = new PlaylistService();

    /**
     * @see HttpServlet#HttpServlet()
     */
    public PlaylistCreationServlet() {
        super();
        System.out.println("[DEBUG] PlaylistCreationServlet initialized."); // 초기화 로그
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("[DEBUG] Received POST request.");

        // 세션에서 사용자 정보 가져오기
        HttpSession session = request.getSession();
        MemberVo user = (MemberVo) session.getAttribute("user"); // 세션에 저장된 MemberVo 객체 가져오기

        // 로그인되지 않은 경우 처리
        if (user == null) {
            System.out.println("[ERROR] User not logged in.");
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('로그인이 필요합니다.'); location.href='member/login.jsp';</script>");
            return;
        }

        String userId = user.getId(); // MemberVo 객체에서 userId 가져오기
        System.out.println("[DEBUG] User ID: " + userId);

        // 파라미터 확인
        String playlistName = request.getParameter("title");
        System.out.println("[DEBUG] Playlist title received: " + playlistName);

        // 파라미터 유효성 검사
        if (playlistName == null || playlistName.trim().isEmpty()) {
            System.out.println("[ERROR] Playlist title is null or empty.");
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('플레이리스트 제목을 입력해주세요.'); history.back();</script>");
            return;
        }

        try {
            // 서비스 호출
            int playlistId = service.createPlaylist(playlistName, userId);
            System.out.println("[DEBUG] Playlist created successfully: ID = " + playlistId);

            // 리다이렉트
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } catch (SQLException e) {
            System.out.println("[ERROR] SQLException occurred while creating playlist.");
            e.printStackTrace();
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('플레이리스트 생성 중 오류가 발생했습니다.'); history.back();</script>");
        } catch (Exception e) {
            System.out.println("[ERROR] Unexpected exception occurred.");
            e.printStackTrace();
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('예기치 못한 오류가 발생했습니다.'); history.back();</script>");
        }
    }
}