package member.controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import member.MemberService;
import member.MemberVo;

/**
 * Servlet implementation class EditmyInfo
 */
@WebServlet("/EditmyInfo")
public class EditmyInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditmyInfo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    
    // 수정폼 요구 
    // 폼에 기존 데이터 보여주고 싶음 => 검색 필요 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// 폼 파라메터 값을 불러와 변수에 담기 
		String id = request.getParameter("id");
		
		// db에서 id로 검색
		MemberService service = new MemberService();
		MemberVo vo = service.getMember(id);
		
		// 검색결과를 request에 담는다
		request.setAttribute("m", vo); //vo객체를 뷰페이지에서는 m이라고 부름 
		
		// forward()로 /member/edit.jsp로 이동 
		RequestDispatcher dis = request.getRequestDispatcher("/member/edit.jsp");
		dis.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
	// 수정 완료 요구 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		String username = request.getParameter("username");
		
		MemberService service = new MemberService();
		service.editMyInfo(new MemberVo(id, pwd, username, ""));
		
		response.sendRedirect("/SharePlaylists/MyInfo?id="+id); //내 정보 보여주기 
	}

}