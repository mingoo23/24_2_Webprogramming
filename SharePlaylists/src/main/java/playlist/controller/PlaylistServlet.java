package playlist.controller;

import playlist.Playlist;
import playlist.PlaylistService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/workspace-listen")
public class PlaylistServlet extends HttpServlet {
    private final PlaylistService playlistService = new PlaylistService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 서비스 호출하여 플레이리스트 데이터 가져오기
        List<Playlist> playlists = playlistService.getPlaylists();

        // JSP에 데이터 전달
        request.setAttribute("playlists", playlists);

        // JSP로 포워딩
        request.getRequestDispatcher("workspace_listen.jsp").forward(request, response);
    }
}

