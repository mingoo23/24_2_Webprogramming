package playlist.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import playlist.*;
/**
 * Servlet implementation class SongsServlet
 */
@WebServlet("/SongsServlet")
public class SongsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private SongService songService;
    
	@Override
    public void init() throws ServletException {
        songService = new SongService();
    }
	
	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String songId = request.getParameter("songId");
        int playlistId;

        try {
            playlistId = Integer.parseInt(request.getParameter("playlistId"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid playlist ID");
            return;
        }

        try {
            boolean isAdded = songService.addSongToPlaylist(songId, playlistId);
            if (isAdded) {
                response.setStatus(HttpServletResponse.SC_OK);
//                response.getWriter().write("Song added successfully");
//                request.setAttribute("addedSongId", songId);
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to add song");
            }
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred: " + e.getMessage());
        }
    }
	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int playlistId;

        try {
            playlistId = Integer.parseInt(request.getParameter("playlistId"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid playlist ID");
            return;
        }

        try {
            List<Song> songs = songService.getSongsByPlaylistId(playlistId);
            request.setAttribute("songs", songs);  // 곡 목록을 request에 담아서 전달
            request.getRequestDispatcher("/workspace/player/player.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred: " + e.getMessage());
        }
    }
}
