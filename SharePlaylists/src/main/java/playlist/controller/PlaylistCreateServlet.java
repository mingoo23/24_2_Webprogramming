package playlist.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import playlist.Playlist;
import playlist.PlaylistService;

/**
 * Servlet implementation class PlaylistCreateServlet
 */
@WebServlet("/PlaylistCreateServlet")
public class PlaylistCreateServlet extends HttpServlet {
	private PlaylistService playlistService = new PlaylistService();
	private static final long serialVersionUID = 1L;    
	public PlaylistCreateServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//폼 데이터 가져오기
		String title = request.getParameter("title");
		String thumbnail = request.getParameter("thumbnail");
		int trackCount = Integer.parseInt(request.getParameter("trackCount"));
		doGet(request, response);
		
		Playlist playlist = new Playlist();
		playlist.setTitle(title);
		playlist.setThumbnail(thumbnail);
		playlist.setTrackCount(trackCount);
		
		playlistService.addPlaylist(playlist);
		
		response.setContentType("text/html;charset=UTF-8");
        response.getWriter().println("플레이리스트가 성공적으로 생성되었습니다.");
	}

}
