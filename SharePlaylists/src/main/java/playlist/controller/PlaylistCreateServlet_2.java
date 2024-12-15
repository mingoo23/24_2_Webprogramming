//package playlist.controller;
//
//import playlist.PlaylistService;
//import playlist.Playlist;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.io.IOException;
//
//@WebServlet("/SharePlaylists/workspace/createPlaylist")
//public class PlaylistCreateServlet extends HttpServlet {
//    private PlaylistService playlistService = new PlaylistService();
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        // 폼 데이터 가져오기
//    	String title = request.getParameter("title");
//        String thumbnail = request.getParameter("thumbnail");
//        int trackCount = Integer.parseInt(request.getParameter("trackCount"));
//        
//        // 기본 유효성 검사
//        if (title == null || title.trim().isEmpty()) {
//            request.setAttribute("errorMessage", "제목은 필수 항목입니다.");
//            request.getRequestDispatcher("/workspace_createplaylist.jsp").forward(request, response);
//            return;
//        }
//
//        try {
//
//            // 플레이리스트 생성 및 저장
//            Playlist playlist = new Playlist();
//            playlist.setTitle(title);
//            playlist.setThumbnail(thumbnail);
//            playlist.setTrackCount(trackCount);
//
//            playlistService.addPlaylist(playlist);
//
//            // 성공 시 원래 페이지로 리다이렉트
////            response.sendRedirect("/workspace_createplaylist.jsp");
//            response.setContentType("text/html;charset=UTF-8");
//            response.getWriter().println("플레이리스트가 성공적으로 생성되었습니다.");
//       } catch (NumberFormatException e) {
////            request.setAttribute("errorMessage", "트랙 수는 숫자여야 합니다.");
////            request.getRequestDispatcher("/workspace_createplaylist.jsp").forward(request, response);
//        }
//    }
//}
