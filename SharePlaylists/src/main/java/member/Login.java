package member;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login") // 로그인 경로 설정
public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 로그인 화면을 반환
        RequestDispatcher dis = request.getRequestDispatcher("/member/login.jsp"); // 로그인 JSP로 포워딩
        dis.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 요청 데이터 가져오기
        System.out.println("[INFO] Received POST request for /Login");

        String id = request.getParameter("id");
        String pwd = request.getParameter("pwd");

        System.out.println("[DEBUG] Received data: id=" + id + ", pwd=" + pwd);

        // 입력값 검증
        if (id == null || id.trim().isEmpty() || pwd == null || pwd.trim().isEmpty()) {
            System.out.println("[ERROR] Empty input detected");
            alertAndGoBack(response, "아이디와 비밀번호를 모두 입력해주세요.");
            return;
        }

        // 서비스 객체를 통해 사용자 정보 확인
        MemberService service = new MemberService();
        MemberVo member = null;

        try {
            member = service.getMember(id);
        } catch (Exception e) {
            System.out.println("[ERROR] Exception while fetching user data: " + e.getMessage());
            e.printStackTrace();
            alertAndGoBack(response, "서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
            return;
        }

        // NullPointerException 방지
        if (member == null) {
            System.out.println("[ERROR] User not found for id: " + id);
            alertAndGoBack(response, "존재하지 않는 사용자입니다.");
            return;
        }

        // 비밀번호 확인
        if (member.getPwd() != null && member.getPwd().equals(pwd)) {
            // 로그인 성공
            HttpSession session = request.getSession();
            session.setAttribute("user", member); // 세션에 사용자 정보 저장
            System.out.println("[INFO] Login successful for user: " + member.getUsername());
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } else {
            // 비밀번호 불일치
            System.out.println("[ERROR] Password mismatch for user: " + id);
            alertAndGoBack(response, "비밀번호가 올바르지 않습니다.");
        }
    }

    /**
     * 클라이언트에 경고창을 표시하고 이전 페이지로 돌아가는 메서드
     */
    private void alertAndGoBack(HttpServletResponse response, String message) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        response.getWriter().println("<script>alert('" + message + "'); history.back();</script>");
    }
}