package member;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Join
 */
@WebServlet("/Join") // 이 페이지를 접근할 때 쓸 경로. 웹 용 url 
public class Join extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Join() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    //get 방식으로 요청시 -> 회원가입 폼을 준다. -> 사용자가 폼 양식을 채워서 submit 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//1. 요청 받음
		//2. 서비스 메서드 요청을 처리 
		//3. 처리 결과 페이지로 이동 
		MemberVo member = new MemberVo("testId", "testPwd", "testUsername", "test@example.com"); // 샘플 데이터
	    request.setAttribute("m", member); // JSP에서 참조할 객체 설정
		// RequestDispatcher: request, response 객체를 가지고 페이지를 이동하는 객체.
		// 생성자 파라메터로 이동할 뷰 페이지 경로를 넣어줌
		// forward(): 포워드 방식으로 이동. (서버 내에서 사용하던 request, response객체를 "가지고" 페이지 이동)
		// redirect(): 서버에서 클라이언트에게 다시 페이지 요청하도록 함 
		
		// forward는 같은 서버에서 이동하기 때문에 /WebProgramming/ 쓸 필요 없음.
		RequestDispatcher dis = request.getRequestDispatcher("/member/join.jsp");
		dis.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	// -> 사용자가 입력한 데이터로 회원가입을 완료함 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// 회원가입 폼에 입력한 값을 변수에 담기 
		System.out.println("Received POST request for /Join");

	    String id = request.getParameter("id");
	    String pwd = request.getParameter("pwd");
	    String username = request.getParameter("username");
	    String email = request.getParameter("email");

	    System.out.println("Received data: id=" + id + ", pwd=" + pwd + ", username=" + username + ", email=" + email);

	    MemberService service = new MemberService();
	    try {
	        service.join(new MemberVo(id, pwd, username, email));
	        System.out.println("User successfully registered!");
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
		
		//회원가입이 완료되면 첫 페이지 login.jsp로 
	
		
		// redirect 는 외부에서 접근하기 때문에 /SharePlaylists/ 필요함 
		response.sendRedirect("/SharePlaylists/login.jsp");
		
	}
}