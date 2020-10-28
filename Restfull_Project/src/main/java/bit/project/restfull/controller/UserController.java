package bit.project.restfull.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import bit.project.restfull.service.AdminBoardService;
import bit.project.restfull.service.BoardService;
import bit.project.restfull.service.UserService;
import bit.project.restfull.vo.BoardVO;
import bit.project.restfull.vo.CustomUser;
import bit.project.restfull.vo.PagingVO;
import bit.project.restfull.vo.RequestVO;
import bit.project.restfull.vo.ResponseVO;
import bit.project.restfull.vo.TravelVO;
import bit.project.restfull.vo.UserVO;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@NoArgsConstructor
@AllArgsConstructor
@RequestMapping("/user")
//회원가입한 사용자 -> 마이페이지
public class UserController {
	
    private UserService userService;
    private BoardService boardService;
    private BCryptPasswordEncoder passEncoder;
	private AdminBoardService adBoardService;
	
	//1. 마이페이지 - 회원 탈퇴 페이지
	@GetMapping("/userDeleteView") 
	public String userDeleteView() {
		log.info("welcome userDeleteView!");
		return "user/userDeleteView";
	}
	
	//2. 회원 탈퇴 기능 수행
	@ResponseBody
	@PostMapping("/userDelete") 
	public String userDelete(@RequestBody UserVO userVO, Authentication authentication, HttpServletRequest request) throws Exception{
		Gson gson = new Gson();
		CustomUser loginInfo = (CustomUser) authentication.getPrincipal();
		boolean isValidPassword = passEncoder.matches(userVO.getPw(), loginInfo.getUser().getPw());
		
		log.info("isValidPassword:  "+isValidPassword);
    	log.info("passEncoder:  "+passEncoder); 
    	log.info(" userVo.getPw():  "+userVO.getPw());	
    	log.info("loginInfo.getUser().getPw():  "+loginInfo.getUser().getPw()); 
    	log.info(isValidPassword+"= passEncoder= . matches("+userVO.getPw()+","+ loginInfo.getUser().getPw()+")");
    	
    	if (isValidPassword) {
            log.info(" : isValidPassword :  "+isValidPassword);
            userVO.setMember_id(loginInfo.getUser().getMember_id());
            userVO.setPw(loginInfo.getUser().getPw());
            
            log.info("loginInfo.getUser()  :  "+loginInfo.getUser()); 
            log.info("loginInfo.getUser().getId()  :  "+loginInfo.getUser().getMember_id()); 
            log.info("userVo  : "+userVO.getPw()); 
            userService.userDelete(userVO);
            
            request.getSession().invalidate();  
            log.info("request.getSession().invalidate()");
            return gson.toJson(new ResponseVO<>(200, "success"));
        }

        log.info("notValidPassword");
        return gson.toJson(new ResponseVO<>(400, "fail"));
		
	}
	
	//3. 회원 정보 수정 페이지
	@GetMapping("/userModify") 
	public String user_modify() {
		log.info("modify personal information");
		return "user/userModify";
	}
	

	//3-2. 회원 정보 수정 기능 수행
	@PostMapping("/update")
	public String userModify(UserVO userVO, HttpSession session) {
		log.info("to Modify user information");
		
		log.info(userVO.getMember_id());  
		log.info(userVO.getEmail()); 
		log.info(userVO.getPw());
		log.info(userVO.getPhone()); 
		log.info(userVO.getGrade_name());
		
		userService.modifyUser(userVO);
		session.invalidate();
		
		return "redirect:/";
		
	}
	
	//4. 마이페이지 - 내 게시글 list
	@GetMapping("/myList") 
	public String boardListView(PagingVO pagingVO, BoardVO boardVO, Model model
			,@RequestParam(value="member_id", required=false)String member_id 
			, @RequestParam(value="nowPage", required=false)String nowPage
			, @RequestParam(value="cntPerPage", required=false)String cntPerPage) {
		
		int total = boardService.countBoard(member_id);
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "5";
		}
		pagingVO = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		
		log.info("user member_id : "+member_id); // name
		
		model.addAttribute("paging", pagingVO);
		model.addAttribute("member_id", member_id);
		model.addAttribute("userBoard", boardService.boardList(member_id, pagingVO));
		
		return "user/boardList";
	}
	
	//5. 내 게시글 조회
	@GetMapping("/contentView") 
	public String contentView_detail(UserVO userVO, BoardVO boardVO, Model model) {
		log.info("board_view");
		int board_numbers = boardVO.getBoard_numbers();
		log.info(board_numbers); // name
		boardVO = boardService.getBoardVO(board_numbers);
		log.info(boardVO);
		
		model.addAttribute("contentView", boardVO);
		return "contentView";
	}

	//6. 내 게시글 - 유저 본인 게시글 삭제
	@PostMapping("/boardDeleteUser") 
	public String boardDeleteuser(BoardVO boardVO, HttpSession session) throws Exception{
		
		boardService.deleteBoardVO(boardVO.getBoard_numbers());
		
		session.invalidate(); 
		return "user/userHome";
	}
	
	//7. 내 문의글 리스트
	@GetMapping("/qnaList") 
	public String qnaListView(BoardVO boardVO, UserVO userVO, Model model) {
		
		log.info("user board list");
		String member_id = userVO.getMember_id();
		log.info("user member_id : "+member_id); // name
		userVO = userService.getUserVO(member_id);
		log.info(userVO);
		
		model.addAttribute("userQna", boardService.qnaList(member_id));
		
		return "user/qnaList";
	}
	
	//8. 내 문의글 조회
	@GetMapping("/contentView_qna") 
	public String contentView_qna(UserVO userVO,BoardVO boardVO, Model model) {
		log.info("board_view");
		int board_numbers = boardVO.getBoard_numbers();
		log.info(board_numbers); // name
		boardVO = boardService.getBoardVO(board_numbers);
		log.info(boardVO);
		
		model.addAttribute("contentView", boardVO);
		return "user/contentView_qna";
	}
	
	//9. 문의글 작성 페이지로 이동
	@GetMapping("/ask") 
	public String userQnAwriteView() {
		return "user/writeView_qna";
	}
	
	//10. 문의글 작성
	@PostMapping("/ask_write") 
	public String userQnaWrite(UserVO userVO, @RequestParam(value="file") MultipartFile[] uploadfiles, BoardVO boardVO) throws IllegalStateException, IOException {
		String member_id = userVO.getMember_id();
		log.info("user member_id : "+member_id); // name
		boardService.writeBoardVO(uploadfiles, boardVO);
		log.info("문의글 작성");
		return "redirect:qnaList?member_id=" + member_id;
	}
	

	//11.신고리스트
	@GetMapping("/reportList") 
	public String reportListView(UserVO userVO, BoardVO boardVO, Model model) {
		log.info("user board list");
		String member_id = userVO.getMember_id();
		log.info("user member_id : "+member_id); // name
		userVO = userService.getUserVO(member_id);
		log.info(userVO);
		model.addAttribute("userReports", boardService.askList(member_id));
		return "user/reportList";
	}
	
	//12. 신고내역 - 신고글 자세히 보기
	@GetMapping("/contentView_rep") 
	public String contentView_ask(UserVO userVO,BoardVO boardVO, Model model) {
		log.info("board_view");
		int board_numbers = boardVO.getBoard_numbers();
		log.info(board_numbers); // name
		
		boardVO = boardService.getBoardVO(board_numbers);
		log.info(boardVO);
		
		model.addAttribute("contentView", boardVO);
		return "user/contentView_ask";
	}
	
	
	//13. 결제내역 list
	@GetMapping("/paymentList") 
	public String paymentList(UserVO userVO,Model model) {
		String member_id = userVO.getMember_id();
		log.info("user member_id : "+member_id); // name
		
		List<RequestVO> list = boardService.getPaymentList(member_id);
		
		model.addAttribute("list", list);
		return "user/paymentList";
	}
	
	//14. 결제내역 list --> 상품 view(사용자는 수정이 불가능-관리자만 수정기능 보유)
	@GetMapping("/goodsView") 
	public String user_goodsView(String goods_numbers, Model model) {
	      log.info("contentView");
	      int goodsNum = Integer.parseInt(goods_numbers);
	      model.addAttribute("contentView",adBoardService.getGoodsVO(goodsNum));
		return "user/goodsContentView";
	}
	
	//15. 내 좋아요 글 list
	@GetMapping("/myLikeList") 
	public String myLikeList(UserVO userVO,Model model) {
		String member_id = userVO.getMember_id();
		log.info("user member_id : "+member_id); // name
		
		List<BoardVO> list = boardService.getLikeList(member_id);
		
		model.addAttribute("boardlist", list);
		return "user/likeList";
	}
	//15. 내 여행코스 목록 보기
	@GetMapping("/myCourseList") 
	public String myCourseList(HttpServletRequest req, Model model) {
		String member_id = req.getParameter("member_id");
		log.info("user member_id : "+member_id); // name
		
		List<TravelVO> list = boardService.getMyCourseList(member_id);
		
		model.addAttribute("list", list);
		
		return "user/myCourseList";
	}
	
	//16. 내 여행코스 보기
	@GetMapping("/course_view") 
	public String course_view(HttpServletRequest req, Model model) {
		String member_id = req.getParameter("member_id");
		String serialNum = req.getParameter("serialNum");
		log.info("user member_id : "+member_id); // name
		log.info("serialNum : "+serialNum); // name
		
		List<TravelVO> list = boardService.getMyCourse(member_id, serialNum);
		
		String alias = list.get(0).getTcAlias();
		String dates = list.get(0).getDates().toString();
		
		model.addAttribute("alias", alias);
		model.addAttribute("dates", dates);
		model.addAttribute("list", list);
		
		return "user/contentViewCrs";
	}
	
}
