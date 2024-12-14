package member;

import java.util.Scanner;

//입력을 view 페이지에서 받을거라 코드가 간결해짐 

//Service: 기능 제공 클래스
//컨트롤러(Servlet)에 요청이 오면 그 요청을 처리할 기능 구현 
// => Service 에 메서드로 구현 
public class MemberService {
	private MemberDao dao;

	public MemberService() {
		dao = new MemberDao();
	}

	// 파라메터에 사용자 입력값 있음
	public void join(MemberVo vo) { // 회원가입
		dao.insert(vo);
	}

	// 파라메터로 id 받아서 동일한 id있는지 검색해 vo객체 반환 
	public MemberVo getMember(String id) { // id로 검색
		return dao.select(id);
	}

	// 수정할 새 값을 파람으로 받음 
	public void editMyInfo(MemberVo vo) { // 내정보 수정
		dao.update(vo);
	}

	public boolean delMember(String id) {
	    MemberDao dao = new MemberDao();
	    try {
	        dao.delete(id);
	        System.out.println("회원 삭제 성공: ID=" + id);
	        return true;
	    } catch (Exception e) {
	        System.out.println("회원 삭제 실패: ID=" + id);
	        e.printStackTrace();
	        return false;
	    }
	}

}