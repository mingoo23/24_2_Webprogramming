package friend.controller;

import java.io.IOException;

import friend.FriendService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.MemberService;
import member.MemberVo;

@WebServlet("/FriendAdd")
public class FriendAddServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FriendService service;

    public FriendAddServlet() {
        this.service = new FriendService();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 세션에서 MemberVo 객체 가져오기
        HttpSession session = request.getSession();
        MemberVo user = (MemberVo) session.getAttribute("user");

        if (user == null) {
            System.out.println("Debug: User not logged in. Session user is null.");
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().write("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
            return;
        }

        // 사용자 ID와 추가할 친구 ID 가져오기
        String userId = user.getId(); // MemberVo에서 사용자 ID 가져옴
        String friendId = request.getParameter("friendId");

        System.out.println("Debug: Received userId = " + userId + ", friendId = " + friendId);

        // FriendService를 통해 친구 추가 시도
        FriendService friendService = new FriendService();
        boolean result = friendService.addFriend(userId, friendId);

        response.setContentType("application/json; charset=UTF-8"); // JSON 형식으로 반환
        if (result) {
            System.out.println("Debug: Friend added successfully.");
            response.getWriter().write("{\"status\":\"success\", \"message\":\"친구가 성공적으로 추가되었습니다.\"}");
        } else {
            System.out.println("Debug: Failed to add friend.");
            response.getWriter().write("{\"status\":\"error\", \"message\":\"친구 추가에 실패했습니다. 이미 추가된 친구일 수 있습니다.\"}");
        }
    }
}