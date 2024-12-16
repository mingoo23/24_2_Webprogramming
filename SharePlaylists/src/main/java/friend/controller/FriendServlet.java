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
import playlist.Playlist;

@WebServlet("/Friend")
public class FriendServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FriendService service = new FriendService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String userId = (String) request.getSession().getAttribute("userId");
        response.setContentType("application/json; charset=UTF-8");

        if (userId == null) {
            response.getWriter().write("{\"error\":\"로그인이 필요합니다.\"}");
            return;
        }

        List<FriendPlaylistDto> playlists = service.getFriendPlaylists(userId);
        int totalFriends = service.getTotalFriendCount(userId);

        StringBuilder json = new StringBuilder("{\"totalCount\":").append(totalFriends).append(",\"friends\":[");
        for (int i = 0; i < playlists.size(); i++) {
            json.append(playlists.get(i).toJson());
            if (i < playlists.size() - 1) json.append(",");
        }
        json.append("]}");

        response.getWriter().write(json.toString());
    }
}