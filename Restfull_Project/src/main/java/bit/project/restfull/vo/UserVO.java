package bit.project.restfull.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
// 소셜로그인시에 필요 
@Builder
public class UserVO {

	private String member_id;
	private String pw;
	private String name;
	private String birth;
	private String gender;
	private String phone;
	private String email;
	private int enabled;
	private String grade_name;
	private String authority_name;
	private String login_type;
	
	// 초기 생성자
	public UserVO() {
		this("member_id", "pw", "name", "birth", "gender", "phone", "email", 1, "뚜벅이", "ROLE_USER","Normal");
	}	
	
	// 가입시 권한부여
	public String getAuthorities() {
		String authorities = "ROLE_USER";
		
		if(getName().trim().toUpperCase().equals("ADMIN"))
			authorities = "ROLE_ADMIN";
		
		return authorities;
	}
}