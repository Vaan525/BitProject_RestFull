package bit.restfull.security;


import javax.inject.Inject;


import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import bit.restfull.mapper.LoginMapper;
import bit.restfull.vo.CustomUser;
import bit.restfull.vo.UserVO;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class CustomUserDetailsService implements UserDetailsService {
	
	@Inject
	private LoginMapper loginmapper;
	
	@Override
	public UserDetails loadUserByUsername(String member_id) throws UsernameNotFoundException {
		log.warn("Load User By user NAME: " + member_id);		
				
		UserVO vo = loginmapper.readUser(member_id);
		
		log.warn("queried by UserVO mapper : " + vo);		
		
		return vo == null ? null : new CustomUser(vo);

	}
   
}

