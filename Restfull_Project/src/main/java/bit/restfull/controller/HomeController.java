package bit.restfull.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import bit.restfull.service.AdminBoardService;
import bit.restfull.service.BoardService;
import bit.restfull.vo.AdminBoardVO;
import bit.restfull.vo.BoardVO;
import bit.restfull.vo.CommentVO;
import bit.restfull.vo.PagingVO;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@NoArgsConstructor
@AllArgsConstructor
//회원가입 하지 않아도 사용가능한 사용자 기능들
public class HomeController {
	
	private BoardService boardService;
	private AdminBoardService adBoardService;
	
	//인덱스 페이지
	@GetMapping("/")
	public String index() {
		log.info("index");
		return "rs-mainpage";
	}
	
	//검색 결과 페이징
		@GetMapping("/search")
		public String search(PagingVO pagingVO, @RequestParam(value="boardlist_numbers") int boardlist_numbers, @RequestParam(value="searchWord") String searchWord, Model model
				, @RequestParam(value="nowPage", required=false)String nowPage
				, @RequestParam(value="cntPerPage", required=false)String cntPerPage) {
			log.info("boardlist_numbers : " + boardlist_numbers);
			log.info("searchWord : " + searchWord);
			
			int total = boardService.countMainBoard(boardlist_numbers, searchWord);
			if (nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "6";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if (cntPerPage == null) { 
				cntPerPage = "6";
			}
			
			log.info(total);
			pagingVO = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			
			//검색어에 해당하는 게시글들을 불러옴
			List<BoardVO> boardlist = boardService.getList(pagingVO, boardlist_numbers, searchWord);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("boardlist_numbers", boardlist_numbers);
			model.addAttribute("paging", pagingVO);
			
			model.addAttribute("boardlist", boardlist);
			
			log.info(searchWord + " 에 대한 검색결과 return 수 : " + total);
			return "searchResult";
		}
		
		// 검색 단어 필터
		@ResponseBody
		@GetMapping("/search/{searchWord}")
		public List<BoardVO> ajaxSearch(PagingVO pagingVO, @PathVariable(value="boardlist_numbers") int boardlist_numbers, @PathVariable(value="searchWord") String searchWord) throws UnsupportedEncodingException {
			log.info("searchWord : " + searchWord);
			//검색어를 url에 포함시켰으니 ASCII로 한글이 인코딩되서 넘어오므로, 검색어를 다시 디코딩해줌
			searchWord = URLDecoder.decode(searchWord, "UTF-8");
			
			//검색어에 해당하는 게시글들을 불러옴
			List<BoardVO> boardlist = boardService.getList(pagingVO, boardlist_numbers, searchWord);
			log.info(searchWord + " 에 대한 검색결과 return 수 : " + boardlist.size());
			return boardlist;
		}
	
	//contentView
	@GetMapping("/contentView")
	public String contentView(String board_numbers, Model model) {
		log.info("contentView");
		int board_no = Integer.parseInt(board_numbers);
		log.info("게시글 view 호출; 게시글 번호 = " + board_no);
		BoardVO vo = boardService.getBoardVO(board_no);
		String location = vo.getLocation();
		//해당 여행지에 대한 다른 관련 게시글들을 뽑기 위해 location정보를 넘겨야함
		model.addAttribute("contentView",vo);
		model.addAttribute("filelist", boardService.getBoardAttachmentVO(board_no));
		model.addAttribute("others", boardService.getOtherBoardVO(board_no, location));
		
		return "contentView";
	}
	
	
	//좋아요 수 검색
	@ResponseBody
	@GetMapping("/board/likeCount")
	public int likeCount(int board_numbers) {
		int like_count = boardService.likeCount(board_numbers);
		return like_count;
	}


	//댓글 기능
	//댓글 목록
	@ResponseBody
	@PostMapping("/getComments/{board_numbers}")
	public List<CommentVO> getComments(@PathVariable int board_numbers){
		List<CommentVO> commentlist = boardService.commentList(board_numbers);
		return commentlist;
	}
	
	// 공지사항, 이벤트 게시판
	@GetMapping("/notice/{boardlist_numbers}")
	public String ajaxNoticeList(@PathVariable(value="boardlist_numbers") int boardlist_numbers, Model model) {
		log.info("boardlist_numbers : " + boardlist_numbers);
		//boardlist_numbers에 해당하는 게시글들을 불러옴
		List<AdminBoardVO> noticelist = adBoardService.getList(boardlist_numbers);
		
		String boardListName = null;
			
		if(noticelist.size()!=0) {
			boardListName = noticelist.get(0).getBoardlistName();
		}else {
			
			log.info("게시글 목록이 없음");
			if(boardlist_numbers == 2) {
				boardListName = "notice";
			}else if (boardlist_numbers == 5) {
				boardListName = "event";
			}
		}
		
		log.info("boardListName = " + boardListName);
		model.addAttribute("boardListName", boardListName);
		model.addAttribute("noticelist", noticelist);
		
		return "Service/noticeList";
	}
	
	// 공지사항, 이벤트 상세보기
	@GetMapping("/notice/contentView")
	public String notice_view(String board_numbers, Model model) {
		log.info("contentView");
		int board_no = Integer.parseInt(board_numbers);
		log.info("게시글 view 호출; 게시글 번호 = " + board_no);
		model.addAttribute("contentView",adBoardService.getBoardVO(board_no));
		model.addAttribute("filelist", adBoardService.getBoardAttachmentVO(board_no));
		return "Service/noticeContentView";
	}  
	
	//자주하는질문
	@GetMapping("/FAQ")
	public String FAQ() {
		log.info("FAQ");
		return "Service/FAQ";
	}
	
	//약관
	@GetMapping("/personal")
	public String personal() {
		log.info("personal");
		return "Service/personalPolicy";
	}
}
