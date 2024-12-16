<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
	String playlistTitle = request.getParameter("playlistTitle");
	//int playlistId = Integer.parseInt(request.getParameter("playlistId"));
%>

<link rel="stylesheet" href="./workspace/workspace_styles.css" />
<section id="workspace-edit" class="workspace-tab-content">

  <div align="center">
  	<h2><%=playlistTitle%></h2>
    <form action="${pageContext.request.contextPath}/SongsServlet" method="post">
    	<label for="songId">Song ID (YouTube Link):</label><br>
    	<input type="text" id="songId" name="songId" placeholder="https://youtu.be/example1" required><br><br>
    	<label for="playlistId">Playlist ID:</label><br>
    	<input type="number" id="playlistId" name="playlistId" placeholder="1" required><br><br>
    	<button type="submit">Add Song</button>
    </form>
  </div>
</section>
