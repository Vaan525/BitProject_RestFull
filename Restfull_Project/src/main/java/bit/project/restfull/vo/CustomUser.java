package bit.project.restfull.vo;

import java.util.Collection;

import java.util.Collections;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CustomUser extends User {

	private UserVO user;
	/* principal.user < 요 객체*/
	
	public CustomUser(String userid, String password, Collection<? extends GrantedAuthority> authorities) {
		super(userid, password, authorities);
		// TODO Auto-generated constructor stub
	}
	
	public CustomUser(UserVO uservo) {
		super(uservo.getMember_id(), uservo.getPw(), Collections.singletonList(new SimpleGrantedAuthority(uservo.getAuthorities())));
		this.user = uservo;
	}
	
}
