package friend.controller;

import java.io.IOException;
import java.util.List;

import friend.FriendPlaylistDto;
import friend.FriendService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/FriendPlaylists")
public class FriendServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FriendService service = new FriendService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 세션에서 userId 가져오기
        String userId = (String) request.getSession().getAttribute("userId");
        
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/member/login.jsp");
            return;
        }

        // 친구들의 플레이리스트 가져오기
        List<FriendPlaylistDto> friendPlaylists = service.getFriendPlaylists(userId);
        request.setAttribute("friendPlaylists", friendPlaylists);

        // JSP로 포워딩
        request.getRequestDispatcher("/workspace/friend_playlists.jsp").forward(request, response);
    }
}