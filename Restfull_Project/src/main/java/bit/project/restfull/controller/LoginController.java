package bit.project.restfull.controller;


import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import bit.project.restfull.service.UserService;
import bit.project.restfull.vo.ResponseVO;
import bit.project.restfull.vo.UserVO;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@NoArgsConstructor
@AllArgsConstructor
//로그인 관련 기능
public class LoginController {
	
	private UserService userService;
	
	//로그인
	@GetMapping("/login")
	public String loginForm(Model model) {
	    
		log.info("ToLogin");
		return "login/login";
	}
	
	//로그아웃.
	@GetMapping("/logout")
	public String logout(HttpSession session) throws Exception{
		
		log.info("/member/logout");
		//세션 객체는  HttpServletRequest (login안에있음.) 여기서 가져옴
		session.invalidate();// 메모리 날리는 대상 (가비지 콜렉터 )에게
	
		return "redirect:/";
	}
	
	// 회원가입 창 이동 - 회원가입 약관 동의창 페이지로 이동
	@GetMapping("/register") 
	public String registerConfirm() {
		log.info("registerConfirm");
	    return "member/registerConfirm";
	}
	   
	// 회원가입 form 창
	@GetMapping("/join")
	public String registerPage() {
	      
		log.info("join");
	      
	    return "member/register";
	}

	// 회원가입 데이터베이스 자료 올리기
	@PostMapping("/addUser") 
	public String adduser(UserVO userVO) {
		log.info("post resister");
	      
	    userService.addUser(userVO);
	            
	    return "member/registerFinish";
	      
	}
	
	// 로그인 접근 거부 페이지 이동
	@GetMapping("/login/accessDenied")
	public String accessDenied() {
		log.info("accessDenied...");
		
		return "login/accessDenied";
	}

	// 유저 마이 페이지
	@GetMapping("/user/userHome")
	public String userHome() {
		log.info("user welcome");
		return "user/userHome";
	}
	
	// 관리자 회원 개인정보 수정
	@GetMapping("/admin/userModify")
	public String modify() {
		log.info("modify personal information");
		return "user/userModify";
	}
	
	// 아이디 중복검사
	@ResponseBody
	@GetMapping("/idCheck")
	public String idCheck(@RequestParam("id") String id) {
		log.info("Check ID");
		Gson gson = new Gson();
		log.info(id);
		
		int str = userService.getUser(id);
		
		boolean validId = str == 0; // 참이면
	    	if (validId) {
	    		
	    		log.info("사용 가능한 아이디 : "+id);
	            return gson.toJson(new ResponseVO<>(200, "success"));
	        }  
	    	
	    	else {
	    		log.info("사용 불가능한 아이디 : "+id);
	    		return gson.toJson(new ResponseVO<>(400, "fail"));
	    	}
	
	}
	
	// 아이디 찾기 페이지 이동
	@GetMapping("/findID")
	public String findID() {
		log.info("access to find id page");
		return "login/findID";
	}
	
	// 비밀번호 찾기 페이지 이동
	@GetMapping("/findPW")
	public String findPW() {
		log.info("access to find pw page");
		return "login/findPW";
	}
	
	// 아이디 찾기, 이메일 대조
	@PostMapping("/doFindID")
	public String findId(HttpServletResponse response, @RequestParam("email") String email, Model md) throws Exception{
		md.addAttribute("id", userService.findID(response, email));
		return "login/findIdResult";
	}
	
	// 임시 비밀번호 이메일로 전송
	@PostMapping("/doFindPW")
	public void findPW(@ModelAttribute UserVO userVO, HttpServletResponse response) throws Exception{
		log.info(userVO.getMember_id());
		userService.findPW(response, userVO);
	}
	
	
}
