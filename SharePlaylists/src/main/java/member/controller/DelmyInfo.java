package member.controller;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import member.MemberService;

/**
 * Servlet implementation class DelmyInfo
 */
@WebServlet("/DelmyInfo")
public class DelmyInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DelmyInfo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 폼 파라미터 값을 가져옴
        String id = request.getParameter("id");
        System.out.println("삭제 요청 받은 ID: " + id);


        // ID 유효성 검사
        if (id == null || id.trim().isEmpty()) {
            System.out.println("유효하지 않은 ID로 삭제 요청을 받았습니다.");
            response.sendRedirect("/SharePlaylists/Error.jsp"); // 에러 페이지로 리다이렉트
            return;
        }

        // DB에서 ID로 검색해서 삭제
        MemberService service = new MemberService();
        service.delMember(id);
        System.out.println("디버깅중: ID=" + id);

        // 삭제 완료 후 메인 페이지로 이동
        response.sendRedirect("/SharePlaylists/home.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");

        if (id == null || id.trim().isEmpty()) {
            System.out.println("유효하지 않은 ID로 삭제 요청을 받았습니다.");
            response.sendRedirect("/SharePlaylists/Error.jsp");
            return;
        }

        MemberService service = new MemberService();
        boolean isDeleted = service.delMember(id);

        if (isDeleted) {
            response.sendRedirect("/SharePlaylists/home.jsp?message=탈퇴가 완료되었습니다.");
        } else {
            response.sendRedirect("/SharePlaylists/Error.jsp?message=탈퇴에 실패했습니다.");
        }
    }

}