package bit.project.restfull.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
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
import bit.project.restfull.vo.AdminBoardVO;
import bit.project.restfull.vo.BoardVO;
import bit.project.restfull.vo.DestinationVO;
import bit.project.restfull.vo.GoodsVO;
import bit.project.restfull.vo.PagingVO;
import bit.project.restfull.vo.RequestVO;
import bit.project.restfull.vo.ResponseVO;
import bit.project.restfull.vo.SidoguVO;
import bit.project.restfull.vo.UserVO;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j;

/**
 * Handles requests for the application home page.
 */
@Log4j
@Controller
@NoArgsConstructor
@AllArgsConstructor
@RequestMapping("/admin")
//관리자 페이지 기능들
public class AdminBoardController {

	
	private BoardService boardService;
	private UserService userService;
	private AdminBoardService adBoardService;

   /* 회원 관리 */
   //1. 회원 리스트 페이징
   @GetMapping("/userList")
	public String userlist(PagingVO pagingVO, Model model
			, @RequestParam(value="nowPage", required=false)String nowPage
			, @RequestParam(value="cntPerPage", required=false)String cntPerPage) {
		
		int total = userService.countMember();
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "5";
		}
		pagingVO = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		model.addAttribute("paging", pagingVO);
		model.addAttribute("restful_user", userService.userList(pagingVO));
		return "admin/userList";
	}
   
    //2. 특정 회원 정보 디테일 확인
    
	@GetMapping("/userContentView")
	public String userContentView(PagingVO pagingVO, UserVO userVO, BoardVO boardVO, Model model
			, @RequestParam(value="nowPage", required=false)String nowPage
			, @RequestParam(value="cntPerPage", required=false)String cntPerPage) {
		
		log.info("유저정보 확인");
		String member_id = userVO.getMember_id();
		log.info("확인할 user id" + member_id); // name
		userVO = userService.getUserVO(member_id);
		
		int total = boardService.countAdBoard(member_id);
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "5";
		}
		pagingVO = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		
		model.addAttribute("userDetail", userVO);
		model.addAttribute("paging", pagingVO);
		model.addAttribute("member_id", member_id);
		model.addAttribute("admin_board", boardService.boardList(member_id, pagingVO));
		return "admin/userData";
	}
	
	//3. 회원 계정 삭제
	@ResponseBody
	@PostMapping("/userDeleteAdmin") 
	public String userDeleteAdmin(@RequestBody UserVO userVO, Authentication authentication, HttpServletRequest request) throws Exception{
		Gson gson = new Gson();
			
		userService.userDelete(userVO);
	           
	    	request.getSession().invalidate();  
	        return gson.toJson(new ResponseVO<>(200, "success"));
	}

	//4. 관리자 권한으로 회원 정보 변경
	@PostMapping("/adminUpdate") 
	public String adminUpdate(UserVO userVO, HttpSession session) {
		log.info("to Modify user information");
		
		log.info(userVO.getMember_id());  
		log.info(userVO.getEmail()); 
		log.info(userVO.getPw());
		log.info(userVO.getPhone()); 
		log.info(userVO.getGrade_name());
		
		userService.adminModifyUser(userVO);
		session.invalidate();
		
		return "admin/userList";
		
	}
   
	//5. 관리자 권한으로 회원 게시글 조회
	@GetMapping("/boardView") 
	public String boardView(String board_numbers, Model model) throws Exception{
		log.info("contentview");
	    int board_no = Integer.parseInt(board_numbers);
	    log.info("게시글 view 호출; 게시글 번호 = " + board_no);

	    model.addAttribute("contentView",adBoardService.getBoardVO(board_no));
	    model.addAttribute("filelist", adBoardService.getBoardAttachmentVO(board_no));
		return "admin/userBoard";
	}
	
	//6. 관리자 권한으로 회원 게시글 삭제
	@ResponseBody
	@GetMapping("/boardDeleteAdmin") 
	public void boardDeleteAdmin(String board_numbers, HttpSession session) throws Exception{
		log.info("adController delete : " + Integer.parseInt(board_numbers));
		//기존에 있던 delete와 똑같아서 파라미터 수정
		boardService.deleteBoardVO(Integer.parseInt(board_numbers));
		session.invalidate(); 
	}
	
   /* 공지사항 및 이벤트 관리  (기본 url : /notice) */
   //1. 공지사항 및 이벤트 리스트
   @GetMapping("/notice")
   public String noticeList() {
	   return "admin/noticeList";
   }
   
   //2. 게시판 번호로 공지사항(2) 혹은 이벤트(5) 리스트 뽑기
   @ResponseBody
   @GetMapping("/notice/{boardlist_numbers}")
   public List<AdminBoardVO> ajaxNoticeList(@PathVariable(value="boardlist_numbers") int boardlist_numbers, Model model) {
      log.info("boardlist_numbers : " + boardlist_numbers);
      //boardlist_numbers에 해당하는 게시글들을 불러옴
      List<AdminBoardVO> noticelist = adBoardService.getList(boardlist_numbers);
      model.addAttribute("noticelist", noticelist);
      return noticelist;
   }
   
   //3. 공지사항 및 이벤트 글 조회
   @GetMapping("/notice/contentView")
   public String contentView(String board_numbers, Model model) {
      log.info("contentView");
      int board_no = Integer.parseInt(board_numbers);
      log.info("게시글 view 호출; 게시글 번호 = " + board_no);
      model.addAttribute("contentView",adBoardService.getBoardVO(board_no));
      model.addAttribute("filelist", adBoardService.getBoardAttachmentVO(board_no));
      return "admin/noticeContentView";
   }
   
   //4. 공지사항 및 이벤트 글 작성 페이지 출력
   @GetMapping("/notice/writeView")
   public String writeView() {
      log.info("writeView ");
      
      return "admin/noticeWriteView";
   }
   
   //4-2. 공지사항 및 이벤트 글 작성
   @PostMapping("/notice/write")
   public String write(HttpServletRequest request, @RequestParam(value="file") MultipartFile[] uploadfiles, AdminBoardVO boardVO) {
      log.info("write");
      adBoardService.writeBoardVO(uploadfiles, boardVO);
      log.info("service.uploadFile(uploadFiles);");
      return "redirect:/admin/notice";
   }

   //5. 공지사항 및 이벤트 글 수정 페이지 호출(사진 수정이 불가능하므로 따로 생성함)
   @GetMapping("/notice/modify")
   public String modify(int board_numbers, Model model) {
      model.addAttribute("modifyView", adBoardService.getBoardVO(board_numbers));
      model.addAttribute("filelist", adBoardService.getBoardAttachmentVO(board_numbers));
      
      return "admin/noticeModifyView";
   }
   
   //5-2. 공지사항 및 이벤트 글 수정 기능 수행
   @PostMapping("/notice/modify")
   public String modify(AdminBoardVO boardVO) {
      log.info("modify()");
      adBoardService.modifyBoardVO(boardVO);
      log.info("글번호 - " + boardVO.getBoard_numbers());
      return "redirect:/admin/notice/contentView?board_numbers="+ boardVO.getBoard_numbers();
   }
   
   //6. 공지사항 및 이벤트 글 삭제
   @GetMapping("/notice/delete")
   public void delete(AdminBoardVO boardVO, Model model) {
      adBoardService.deleteBoardVO(boardVO.getBoard_numbers());
      log.info("삭제 성공");
   }
   
   
   /* 여행지 및 상품 관리 (기본 url = /dest) */
   //1. 여행지 및 상품 리스트
   @GetMapping("/dest")
   public String destList(Model model) {
	  log.info("여행지 목록 출력");
      List<DestinationVO> destlist = adBoardService.getDestList(); //select * from destination
      model.addAttribute("destlist", destlist);
      return "admin/destList";
   }
   
   //2. 여행지 조회
   @GetMapping("/dest/contentView")
   public String destcontentView(int destination_numbers, Model model) {
      log.info("contentView");
      model.addAttribute("contentView",adBoardService.getDestVO(destination_numbers));
      model.addAttribute("goodsList",adBoardService.getGoodsList(destination_numbers));
      return "admin/destContentView";
   }
   
   //3. 여행지 등록 페이지 출력
   @GetMapping("/dest/writeView")
   public String destwriteView() {
      log.info("dest_writeView");
      
      return "admin/destWriteView";
   }
   
   
   //3-2. 여행지 등록
   @PostMapping("/dest/write")
   public String destWrite(@ModelAttribute DestinationVO destinationVO) {
      log.info("write");
      adBoardService.writeDestVO(destinationVO);
      log.info("writeDestVO;");
      return "redirect:/admin/dest/";
   }
   
   //3-3. 여행지 등록 시 지역코드 가져오기
   @ResponseBody
   @GetMapping("/dest/getSigunguCode/{sidoCode}")
   public List<SidoguVO> getSigunguCode(@PathVariable(value="sidoCode") int sidoCode) {
      log.info("sidoCode : " + sidoCode);
      //sidoNum에 해당하는 지역코드들을 불러옴
      List<SidoguVO> optionList = adBoardService.getOptionList(sidoCode);
      return optionList;
   }
   
   //4. 여행지 수정 기능 modifyView 페이지 호출
   @GetMapping("/dest/modify")
   public String destModify(int destination_numbers, Model model) {
      model.addAttribute("modifyView", adBoardService.getDestVO(destination_numbers));
      return "admin/destModifyView";
   }
   
   //4-2. 여행지 수정 기능 수행
   @PostMapping("/dest/modify")
   public String destModify(DestinationVO destinationVO) throws UnsupportedEncodingException {
      log.info("modify()");
      int destNum = destinationVO.getDestination_numbers();
      log.info("여행지번호 : " + destNum);
      adBoardService.modifyDestVO(destinationVO);
      return "redirect:/admin/dest/contentView?destination_numbers="+ destNum;
   }
   
   //5. 여행지 삭제
   @GetMapping("/dest/delete")
   public String destDelete(DestinationVO destinationVO, Model model) {
	  int destNum = destinationVO.getDestination_numbers();
      adBoardService.deleteDestVO(destNum);
      log.info("삭제 성공");
      return "redirect:/admin/dest/";
   }
   
   /* 상품 관리 (기본 url = /dest/goods) */
   //1. 상품 조회
   @GetMapping("/dest/goods/contentView")
   public String goodscontentView(String goods_numbers, Model model) {
      log.info("contentView");
      int goodsNum = Integer.parseInt(goods_numbers);
      model.addAttribute("contentView",adBoardService.getGoodsVO(goodsNum));
      return "admin/goodsContentView";
   }

   //2. 상품 등록 페이지
   @GetMapping("/dest/{destination_numbers}/goods/writeView")
   public String goodswriteView(@PathVariable(name="destination_numbers") int destination_numbers, Model model) {
      log.info("dest_writeView");
      log.info(destination_numbers);
      model.addAttribute("destVO",adBoardService.getDestVO(destination_numbers));
      return "admin/goodsWriteView";
   }
   
   //3. 상품 등록
   @PostMapping("/dest/goods/write")
   public String goodsWrite(GoodsVO goodsVO){
      log.info("goods insert : " + goodsVO.getName());
      log.info("getDestination_name = " + goodsVO.getDestination_name());
      adBoardService.writeGoodsVO(goodsVO);
      //상품 등록 후 등록한 상품의 view로 이동
      int goodsNum = goodsVO.getDestination_numbers();
      return "redirect:/admin/dest/contentView?destination_numbers="+ goodsNum;
   }             
   
   //4. 수정 기능 modifyView 페이지 호출
   @GetMapping("/dest/goods/modify")
   public String goodsModify(int goods_numbers, Model model) {
      model.addAttribute("modifyView", adBoardService.getGoodsVO(goods_numbers));
      return "admin/goodsModifyView";
   }
   
   //4-2. 수정 기능 수행
   @PostMapping("/dest/goods/modify")
   public String goodsModify(GoodsVO goodsVO) {
      log.info("modify()");
      log.info("여행지 - " + goodsVO.getDestination_name());
      log.info("상품번호 - " + goodsVO.getGoods_numbers());
      log.info("상품번호 - " + goodsVO.getName());
      adBoardService.modifyGoodsVO(goodsVO);
      return "redirect:/admin/dest/goods/contentView?goods_numbers="+ goodsVO.getGoods_numbers();
   }         
   
   //5. 상품 삭제
   @GetMapping("/dest/{destination_name}/goods/delete")
   public String goodsDelete(@PathVariable(name="destination_name") String destination_name, int goods_numbers, Model model) throws UnsupportedEncodingException {
      adBoardService.deleteGoodsVO(goods_numbers);
      log.info("삭제 성공");
      //상품 삭제 후 처리 필요함(수정예정)
      return "redirect:/admin/dest/contentView?destination_numbers="+ goods_numbers;
   }
   
   /* 문의글 관리 (url:admin/qnas) */
   //1. 회원의 문의 및 신고 리스트
   @GetMapping("/qnas")
   public String qnas() {
      log.info("qnas");
      return "admin/qnaList";
   }
   
   
   //2. 게시판 번호를 가지고 문의글 or 신고글 리스트 분류해서 출력
   @ResponseBody
   @GetMapping("/qnas/{boardlist_numbers}")
   public List<AdminBoardVO> ajaxQnAsList(@PathVariable(value="boardlist_numbers") int boardlist_numbers, Model model) {
      log.info("boardlist_numbers : " + boardlist_numbers);
      //boardlist_numbers에 해당하는 게시글들을 불러옴
      List<AdminBoardVO> list = adBoardService.getFilterList(boardlist_numbers);
      model.addAttribute("list", list);
      return list;
   }
   
   
   //3. 문의글/신고글 조회 - admin용 contentView
   /* admin은 댓글 형식으로 답변글을 작성할 수 있음.
    * 댓글기능은 BoardController에 작성함.
    * addComments 등
    */
   @GetMapping("/qnas/contentView")
   public String adminqna_view(String board_numbers, Model model) {
      log.info("contentView");
      int board_no = Integer.parseInt(board_numbers);
      log.info("게시글 view 호출; 게시글 번호 = " + board_no);
      model.addAttribute("contentView",adBoardService.getBoardVO(board_no));
      model.addAttribute("filelist", adBoardService.getBoardAttachmentVO(board_no));
      return "admin/qnaContentView";
   }

   /* 상품 주문내역 관리 */
   //주문받은 모든 상품 리스트
   @GetMapping("/requestList") 
   public String requestList(Model model) {
	   List<RequestVO> list = adBoardService.getRequestList();
	   model.addAttribute("list", list);
	   return "admin/requestList";
	}
	
}