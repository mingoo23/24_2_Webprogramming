package PlaylistServlet;

import playlist.PlaylistService;
import playlist.Playlist;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/createPlaylist")
public class PlaylistCreateServlet extends HttpServlet {
    private PlaylistService playlistService = new PlaylistService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 폼 데이터 가져오기
        String title = request.getParameter("title");
        String thumbnail = request.getParameter("thumbnail");
        String trackCountStr = request.getParameter("trackCount");

        // 기본 유효성 검사
        if (title == null || title.trim().isEmpty() || trackCountStr == null) {
            request.setAttribute("errorMessage", "제목과 트랙 수는 필수 항목입니다.");
            request.getRequestDispatcher("workspace-newplaylist.jsp").forward(request, response);
            return;
        }

        try {
            int trackCount = Integer.parseInt(trackCountStr);

            // 플레이리스트 생성 및 저장
            Playlist playlist = new Playlist();
            playlist.setTitle(title);
            playlist.setThumbnail(thumbnail);
            playlist.setTrackCount(trackCount);

            playlistService.addPlaylist(playlist);

            // 성공 시 플레이리스트 목록 페이지로 리다이렉트
            response.sendRedirect("workspace_listen.jsp");
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "트랙 수는 숫자여야 합니다.");
            request.getRequestDispatcher("workspace-newplaylist.jsp").forward(request, response);
        }
    }
}

