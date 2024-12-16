package member.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/Logout")
public class Logout extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 세션 종료
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
            System.out.println("User logged out successfully.");
        }

        // 메인 페이지로 이동
        response.sendRedirect("/SharePlaylists/index.jsp");
    }
}