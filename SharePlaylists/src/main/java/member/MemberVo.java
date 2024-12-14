package member;

public class MemberVo {
	private String id;
	private String pwd;
	private String username;
	private String email;
	
	public MemberVo() {}
	
	public MemberVo(String id, String pwd, String username, String email) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.username = username;
		this.email = email;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "내 정보 [id=" + id + ", pwd=" + pwd + ", username=" + username + ", email=" + email + "]";
	}
}