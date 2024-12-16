//package playlist.controller;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import playlist.Playlist;
//import playlist.PlaylistService;
//
//import java.io.IOException;
//import java.sql.SQLException;
//import java.util.List;
//
//@WebServlet("/PlaylistServlet")
//public class PlaylistServlet extends HttpServlet {
//    private final PlaylistService service = new PlaylistService();
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        try {
//            List<Playlist> playlists = service.getAllPlaylists();
//            request.setAttribute("playlists", playlists);
//            request.getRequestDispatcher("/playlist.jsp").forward(request, response);
//        } catch (SQLException e) {
//            e.printStackTrace();
//            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "데이터베이스 오류");
//        }
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String title = request.getParameter("title");
//        String[] links = request.getParameterValues("links");
//
//        Playlist playlist = new Playlist(title);
//        playlistService.addPlaylist(playlist);
//
//        if (links != null) {
//            for (String link : links) {
//                playlistService.addSongToPlaylist(playlist.getId(), link);
//            }
//        }
//
//        response.sendRedirect(request.getContextPath() + "/PlaylistServlet");
//    }
//}
