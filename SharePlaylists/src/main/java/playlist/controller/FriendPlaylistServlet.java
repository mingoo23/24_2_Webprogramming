package playlist.controller;

import playlist.Playlist;
import playlist.PlaylistService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/friend/playlists")
public class FriendPlaylistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final PlaylistService playlistService = new PlaylistService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String friendId = request.getParameter("friendId");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            if (friendId != null && !friendId.isEmpty()) {
                List<Playlist> playlists = playlistService.getPlaylistsByUserId(friendId);

                // JSON 데이터로 변환
                StringBuilder json = new StringBuilder("[");
                for (int i = 0; i < playlists.size(); i++) {
                    json.append(playlists.get(i).toJson());
                    if (i < playlists.size() - 1) json.append(",");
                }
                json.append("]");

                out.print(json.toString());
                System.out.println("Returned playlists for user: " + friendId);
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"error\":\"friendId is missing or invalid\"}");
            }
        }
    }
}