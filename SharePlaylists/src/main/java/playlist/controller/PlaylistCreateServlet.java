package playlist.controller;

import playlist.Playlist;
import playlist.PlaylistService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/PlaylistCreateServlet")
public class PlaylistCreateServlet extends HttpServlet {
    private PlaylistService playlistService = new PlaylistService();
    private static final long serialVersionUID = 1L;

    public PlaylistCreateServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 폼 데이터 가져오기
        String title = request.getParameter("title");

        // 곡들 가져오기 (곡들은 여러 개일 수 있으므로, 콤마로 구분하여 전달되도록 처리)
        String[] songIds = request.getParameterValues("songs");
        List<String> songIdList = new ArrayList<>();
        if (songIds != null) {
            for (String songId : songIds) {
                songIdList.add(songId);  // songId 리스트에 추가
            }
        }

        // 플레이리스트 생성
        Playlist playlist = new Playlist();
        playlist.setTitle(title);

        // 서비스 호출하여 플레이리스트와 곡들을 저장
        playlistService.addPlaylist(playlist, songIdList);

        // 성공 메시지 응답
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().println("플레이리스트가 성공적으로 생성되었습니다.");
    }
}
