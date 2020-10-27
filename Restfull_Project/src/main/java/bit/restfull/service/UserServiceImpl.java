package bit.restfull.service;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import bit.restfull.mapper.LoginMapper;
import bit.restfull.vo.PagingVO;
import bit.restfull.vo.UserVO;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@NoArgsConstructor
@AllArgsConstructor
public class UserServiceImpl implements UserService {

	@Autowired
	private BCryptPasswordEncoder passEncoder; 
	@Autowired
	private LoginMapper loginMapper;

	public void addUser(UserVO userVO){ 
		String pw = userVO.getPw(); 
		
		String encode = passEncoder.encode(pw);
		  
		userVO.setPw(encode);
		loginMapper.insertUser(userVO); 
	} 
	
	public void modifyUser(UserVO userVO) {
		
		String pw = userVO.getPw(); 
		log.info(pw);
		String encode = passEncoder.encode(pw);
		  
		userVO.setPw(encode);
		
		loginMapper.modifyUser(userVO);; 
		
		log.info(userVO);
		
	}
	 
	
	public void userDelete(UserVO userVO) {
		
		String member_id = userVO.getMember_id();
		log.info(member_id);
		loginMapper.delMember(member_id);
		
	}
	
	
	public String getEncodePassword(String pw) {
		log.info("pw"+pw);
		return passEncoder.encode(pw);
	}
	
	public int getUser(String member_id) {
		return loginMapper.idChk(member_id);
	}

	@Override
	public void adminModifyUser(UserVO userVO) {
		String pw = userVO.getPw(); 
		log.info(pw);
		String encode = passEncoder.encode(pw);
		
		userVO.setPw(encode);
		loginMapper.adminModifyUser(userVO);; 
	}

	@Override
	public int countMember() {
		return loginMapper.countMember();
	}

	@Override
	public List<UserVO> userList(PagingVO pagingVO){
		return loginMapper.userList(pagingVO);
	}

	@Override
	public UserVO getUserVO(String member_id) {
		return loginMapper.getUserVO(member_id);
	}
	
	@Override 
	public String findID(HttpServletResponse response, String email) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String id = loginMapper.findID(email);
		
		if (id == null) {
			out.println("<script>");
			out.println("alert('가입된 아이디가 없습니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
			return null;
		} else {
			return id;
		}
	
	}

	@Override
	public void findPW(HttpServletResponse response, UserVO userVO) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		// 아이디가 없으면
		
		if(loginMapper.idChk(userVO.getMember_id()) == 0) {
			out.print("아이디가 없습니다.");
			out.close();
		}
		// 가입에 사용한 이메일이 아니면
		else if(!userVO.getEmail().equals(loginMapper.readUser(userVO.getMember_id()).getEmail())) {
			out.print("잘못된 이메일 입니다.");
			out.close();
		}else {
			// 임시 비밀번호 생성
			String pw = "";
			for (int i = 0; i < 12; i++) {
				pw += (char) ((Math.random() * 26) + 97);
			}
			
			userVO.setPw(pw);
			System.out.println(pw);
			sendMail(userVO, "findPW");
			// 비밀번호 변경
			
			String encode = passEncoder.encode(pw);
			
			userVO.setPw(encode);
			
			loginMapper.findPW(userVO);
			// 비밀번호 변경 메일 발송
			
			out.print("이메일로 임시 비밀번호를 발송하였습니다.");
			out.close();
		}
	}
	

	@Override
	public void sendMail(UserVO userVO, String div) {
		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.gmail.com";
		String hostSMTPid = "justicia0310@gmail.com";
		String hostSMTPpwd = ""; //여기만 채우고 돌리자 (비번 넣어주는곳)

		// 보내는 사람 EMail, 제목, 내용
		String fromEmail = "restFullAdmin@gmail.com";
		String fromName = "RestFull 관리자";
		String subject = "";
		String msg = "";
		
		if(div.equals("findPW")) {
			subject = "RestFull 로그인 임시 비밀번호 입니다.";
			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
			msg += "<h3 style='color: blue;'>";
			msg += userVO.getMember_id() + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
			msg += "<p>임시 비밀번호 : ";
			msg += userVO.getPw() + "</p></div>";
		}
		// 받는 사람 E-Mail 주소
		String mail = userVO.getEmail();
		try {
			HtmlEmail email = new HtmlEmail();
			email.setDebug(true);
			email.setCharset(charSet);
			email.setSSL(true);
			email.setHostName(hostSMTP);
			email.setSmtpPort(587);

			email.setAuthentication(hostSMTPid, hostSMTPpwd);
			email.setTLS(true);
			email.addTo(mail, charSet);
			email.setFrom(fromEmail, fromName, charSet);
			email.setSubject(subject);
			email.setHtmlMsg(msg);
			email.send();
		} catch (Exception e) {
			System.out.println("메일발송 실패 : " + e);
		}
	}

	@Override
	public int idChk(String member_id) {
		return loginMapper.idChk(member_id);
	}

	@Override
	public UserVO getUserByIdandAutho(String id, String login_type) {
		return loginMapper.KreadUserByIdandAutho(id, login_type);
	}
}
