//package playlist.controller;
//
//import playlist.Playlist;
//import playlist.PlaylistService;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.io.IOException;
//import java.util.List;
//
//@WebServlet("/PlaylistCreateServlet")
//public class PlaylistCreateServlet extends HttpServlet {
//    private PlaylistService playlistService = new PlaylistService();
//    private static final long serialVersionUID = 1L;
//
//    public PlaylistCreateServlet() {
//        super();
//    }
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        // 폼 데이터 가져오기
//        String title = request.getParameter("title");
//        int trackCount = Integer.parseInt(request.getParameter("trackCount"));
//        String[] links = request.getParameterValues("links");
//
//        // Playlist 객체 생성 및 설정
//        Playlist playlist = new Playlist();
//        playlist.setTitle(title);
//        playlist.setTrackCount(trackCount); // Track Count 설정
//
//        // Playlist를 데이터베이스에 추가
//        playlistService.addPlaylist(playlist);
//
//        // 곡들을 songs 테이블에 추가
//        for (String link : links) {
//            playlistService.addSongToPlaylist(playlist.getId(), link);
//        }
//
//        // 플레이리스트 생성 완료 메시지
//        response.setContentType("text/html;charset=UTF-8");
//        response.getWriter().println("플레이리스트가 성공적으로 생성되었습니다. 트랙 수: " + trackCount);
//    }
//}
