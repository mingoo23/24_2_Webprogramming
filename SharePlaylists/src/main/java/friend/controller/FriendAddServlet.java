package friend.controller;

import java.io.IOException;

import friend.FriendService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/FriendAdd")
public class FriendAddServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FriendService service;

    public FriendAddServlet() {
        this.service = new FriendService();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 세션에서 사용자 ID 가져오기
        String userId = (String) request.getSession().getAttribute("user");
        String friendId = request.getParameter("friendId");

        System.out.println("Debug: Received userId = " + userId + ", friendId = " + friendId);

        response.setContentType("text/html; charset=UTF-8");
        if (userId == null) {
            System.out.println("Debug: User not logged in. Session userId is null.");
            response.getWriter().write("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
            return;
        }

        // 친구 추가 시도
        boolean result = service.addFriend(userId, friendId);
        if (result) {
            System.out.println("Debug: Friend added successfully for userId = " + userId + ", friendId = " + friendId);
            response.getWriter().write("<script>alert('친구가 성공적으로 추가되었습니다.'); history.back();</script>");
        } else {
            System.out.println("Debug: Failed to add friend. Possible duplication or DB issue.");
            response.getWriter().write("<script>alert('친구 추가에 실패했습니다. 이미 추가된 친구일 수 있습니다.'); history.back();</script>");
        }
    }
}