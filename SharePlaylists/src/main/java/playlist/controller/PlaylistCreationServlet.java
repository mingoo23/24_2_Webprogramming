package playlist.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import playlist.Playlist;
import playlist.PlaylistService;

/**
 * Servlet implementation class PlaylistCreationServlet
 * 플레이리스트 생성 서블릿 - 제목만 입력받음
 */
@WebServlet("/PlaylistCreationServlet")
public class PlaylistCreationServlet extends HttpServlet {
	   private static final long serialVersionUID = 1L;
	   
	    private final PlaylistService service = new PlaylistService();
	       
	    /**
	     * @see HttpServlet#HttpServlet()
	     */
	    public PlaylistCreationServlet() {
	        super();
	        // TODO Auto-generated constructor stub
	    }

	   /**
	    * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	    */
	   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	      String PlaylistName = request.getParameter("title");
	      Playlist playlist = new Playlist(PlaylistName);
	      try {
	         service.createPlaylist(PlaylistName);
	         
	      } catch (SQLException e) {
	         e.printStackTrace();
	      }
	      response.sendRedirect(request.getContextPath() + "/index.jsp");

	   }

	}
