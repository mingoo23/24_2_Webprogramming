package playlist.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import playlist.Playlist;
import playlist.PlaylistService;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import conn.DBConnect;

@WebServlet("/PlaylistServlet")
public class PlaylistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//String playlisyTitle = request.getParameter("")
	}
	
    private final PlaylistService service = new PlaylistService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Playlist> playlists = service.getAllPlaylists();
            request.setAttribute("playlists", playlists);
            request.getRequestDispatcher("/playlist.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "데이터베이스 오류");
        }
    }
}
