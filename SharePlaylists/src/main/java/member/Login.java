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

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 요청 데이터 가져오기
        System.out.println("Received POST request for /Login");

        String id = request.getParameter("id");
        String pwd = request.getParameter("pwd");

        System.out.println("Received data: id=" + id + ", pwd=" + pwd);

        // 입력값 검증
        if (id == null || id.trim().isEmpty() || pwd == null || pwd.trim().isEmpty()) {
            System.out.println("Empty input detected");
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('아이디와 비밀번호를 모두 입력해주세요.'); history.back();</script>");
            return;
        }

        // 서비스 객체를 통해 사용자 정보 확인
        MemberService service = new MemberService();
        MemberVo member = service.getMember(id);

        if (member != null) {
            // 비밀번호 확인
            if (member.getPwd().equals(pwd)) {
                // 로그인 성공
                HttpSession session = request.getSession();
                session.setAttribute("user", member); // 세션에 사용자 정보 저장
                System.out.println("Session ID: " + session.getId());
                System.out.println("User stored in session: " + session.getAttribute("user"));
                System.out.println("Login successful for user: " + member.getUsername());

                // 메인 페이지로 이동
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            } else {
                // 비밀번호 불일치
                System.out.println("Password mismatch for user: " + id);
                response.setContentType("text/html; charset=UTF-8");
                response.getWriter().println("<script>alert('비밀번호가 올바르지 않습니다.'); history.back();</script>");
            }
        } else {
            // 사용자가 없는 경우
            System.out.println("User not found for id: " + id);
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('존재하지 않는 사용자입니다.'); history.back();</script>");
        }
    }
}