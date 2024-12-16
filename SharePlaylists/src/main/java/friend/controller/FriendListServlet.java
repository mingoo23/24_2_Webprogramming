package friend.controller;

import java.io.IOException;
import java.util.List;

import friend.FriendPlaylistDto;
import friend.FriendService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.MemberVo;

@WebServlet("/FriendList")
public class FriendListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 세션에서 사용자 확인
        HttpSession session = request.getSession();
        MemberVo user = (MemberVo) session.getAttribute("user");

        if (user == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "로그인이 필요합니다.");
            return;
        }

        // 친구 플레이리스트 가져오기
        FriendService service = new FriendService();
        List<FriendPlaylistDto> friendPlaylists = service.getFriendPlaylists(user.getId());

        // JSON 형식으로 데이터 반환
        response.setContentType("application/json; charset=UTF-8");
        StringBuilder json = new StringBuilder("[");
        if (friendPlaylists != null && !friendPlaylists.isEmpty()) {
            for (int i = 0; i < friendPlaylists.size(); i++) {
                FriendPlaylistDto dto = friendPlaylists.get(i);
                json.append("{")
                    .append("\"playlistTitle\":\"").append(dto.getPlaylistTitle()).append("\",")
                    .append("\"friendName\":\"").append(dto.getFriendName()).append("\",")
                    .append("\"trackCount\":").append(dto.getTrackCount())
                    .append("}");
                if (i < friendPlaylists.size() - 1) {
                    json.append(",");
                }
            }
        }
        json.append("]");
        response.getWriter().write(json.toString());
    }
}