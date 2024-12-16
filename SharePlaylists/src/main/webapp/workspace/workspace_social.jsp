<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, friend.FriendService, friend.FriendPlaylistDto, member.MemberVo" %>

<%
    // 세션에서 사용자 정보 확인
    MemberVo user = (MemberVo) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/member/login.jsp");
        return;
    }

    // FriendService를 통해 친구의 플레이리스트 가져오기
    FriendService service = new FriendService();
    List<FriendPlaylistDto> friendPlaylists = service.getFriendPlaylists(user.getId());
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>친구 플레이리스트</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/workspace/workspace_styles.css">
</head>
<body>
<section id="workspace-social" class="workspace-tab-content">
    <div align="center">
        <h1>친구 추가 및 플레이리스트</h1>
        <p>환영합니다, <%= user.getUsername() %>님!</p>

        <!-- 친구 추가 입력 -->
        <table border="0" width="70%" align="center">
    <tr style="height: 80px">
        <th class="title-category" style="text-align: right; padding-right: 10px;">친구 추가</th>
        <td>
            <form action="<%= request.getContextPath() %>/FriendAdd" method="post">
                <table>
                    <tr>
                        <!-- 아이디 입력칸 -->
                        <td>
                            <input type="text" name="friendId" class="input-window" placeholder="ID를 입력해주세요." size="80" />
                        </td>
                        <!-- 버튼과 간격 -->
                        <td style="padding-left: 20px;">
                            <button type="submit" class="button btnPush btnOrange" style="margin-left: 20px;">친구 추가</button>
                        </td>
                    </tr>
                </table>
            </form>
        </td>
    </tr>
</table>

        <!-- 친구의 플레이리스트 출력 -->
        <h2>친구의 플레이리스트</h2>
        <div id="friendList">
            <%
                if (friendPlaylists == null || friendPlaylists.isEmpty()) {
            %>
                <p>친구의 플레이리스트가 없습니다.</p>
            <%
                } else {
                    for (FriendPlaylistDto playlist : friendPlaylists) {
            %>
                <div class="playlist-card-social" style="border: 1px solid #ddd; margin: 10px; padding: 10px; width: 50%;">
                    <div class="card-content">
                        <div class="title">플레이리스트: <%= playlist.getPlaylistTitle() %></div>
                        <div class="friend-name">친구 이름: <%= playlist.getFriendName() %></div>
                        <div class="track-count">트랙 수: <%= playlist.getTrackCount() %></div>
                    </div>
                </div>
            <%
                    }
                }
            %>
        </div>
    </div>
</section>
</body>
</html>