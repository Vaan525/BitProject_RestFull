package bit.project.restfull.security;


import org.springframework.security.crypto.password.PasswordEncoder;

import lombok.extern.log4j.Log4j;
@Log4j
public class customNoOpPasswordEncoder implements PasswordEncoder{
      // ��ȣȭ �� ������ ���� �׷����������..
   
   @Override
   public String encode(CharSequence rawPassword) {
	   log.warn("before encode :" + rawPassword);
	   return rawPassword.toString();
   }

   @Override
   public boolean matches(CharSequence rawPassword, String encodedPassword) {
      log.info("matches :" + rawPassword+":"+encodedPassword);
      
      return rawPassword.toString().equals(encodedPassword);
   }

}
