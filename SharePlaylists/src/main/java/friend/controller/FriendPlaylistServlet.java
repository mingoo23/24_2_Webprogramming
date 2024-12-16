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
public class FriendPlaylistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FriendService service;

    public FriendPlaylistServlet() {
        this.service = new FriendService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String friendId = request.getParameter("friendId");
        response.setContentType("application/json; charset=UTF-8");

        List<FriendPlaylistDto> playlists = service.getFriendPlaylists(friendId);
        StringBuilder json = new StringBuilder("[");

        for (int i = 0; i < playlists.size(); i++) {
            FriendPlaylistDto p = playlists.get(i);
            json.append(p.toJson());
            if (i < playlists.size() - 1) json.append(",");
        }
        json.append("]");

        response.getWriter().write(json.toString());
    }
}