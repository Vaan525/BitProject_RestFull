package bit.project.restfull.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import bit.project.restfull.service.AdminBoardService;
import bit.project.restfull.service.BoardService;
import bit.project.restfull.vo.BoardVO;
import bit.project.restfull.vo.CommentVO;
import bit.project.restfull.vo.DestinationVO;
import bit.project.restfull.vo.LikesVO;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@NoArgsConstructor
@AllArgsConstructor
@RequestMapping("/user")
//회원가입 및 로그인이 필요한 사용자 기능들
public class BoardController {

	private BoardService boardService;
	private AdminBoardService adBoardService;
	
	//writeView
	@GetMapping("/writeView")
	public String writeView() {
		log.info("writeView ");
		
		return "user/writeView";
	}
	
	// 메인 게시글 작성
	@ResponseBody
	@PostMapping("/writeMainPosting")
	public String writeMainPosting(@RequestParam(value="file") MultipartFile[] uploadfiles, BoardVO boardVO) throws IllegalStateException, IOException {
		log.info("writeMainPosting");
		int board_numbers = boardService.writeBoardVO(uploadfiles, boardVO);
		log.info("service.uploadFile(uploadFiles);" + board_numbers );
		String bNum = Integer.toString(board_numbers);
		return bNum;
	}
	
	// 메인 게시글 목적지 
	@ResponseBody
	@PostMapping("/writeMainPosting_dest")
	public void dest_Write(@RequestBody Map<String,Object> paramData) {
		log.info("paramData");
		int board_numbers = (int) paramData.get("board_numbers");
		log.info("board_numbers = " + board_numbers);
		adBoardService.writeDestVO(paramData);
	}
	
	// 작성 함수
	@PostMapping("/write")
	public String write(@RequestParam(value="file") MultipartFile[] uploadfiles, BoardVO boardVO) throws IllegalStateException, IOException {
		log.info("write");
		int board_numbers = boardService.writeBoardVO(uploadfiles, boardVO);
		log.info("service.uploadFile(uploadFiles);");
		return "redirect:/contentView?board_numbers="+board_numbers;
	}
	
	//좋아요 기능
	@ResponseBody
	@GetMapping("/board/likeCheck")
	public int likeCheck(LikesVO likesVO) {
		log.info("likeCheck");
		int result = boardService.likeCheck(likesVO);
		return result;
	}
	
	//좋아요 수 업데이트
	@ResponseBody
	@PostMapping("/board/likeUpdate")
	public void likeUpdate(LikesVO likesVO) {
		log.info("likeUpdate");
		log.info("조아여 글 번호 : " + likesVO.getBoard_numbers());
		log.info("조아여 아이디 : " + likesVO.getMember_id());
		boardService.likeUpdate(likesVO);
	}
	

	//수정 기능 modifyView 페이지 호출
	@GetMapping("/modify")
	public String modify(int board_numbers, Model model) {
		model.addAttribute("modifyView", boardService.getBoardVO(board_numbers));
		model.addAttribute("filelist", boardService.getBoardAttachmentVO(board_numbers));
		
		return "modifyView";
	}
	
	//수정 기능 수행
	@PostMapping("/modify")
	public String modify(BoardVO boardVO) {
		log.info("modify()");
		boardService.modifyBoardVO(boardVO);
		log.info("글번호  - " + boardVO.getBoard_numbers());
		return "redirect:/contentView?board_numbers="+ boardVO.getBoard_numbers();
	}
	
	//delete?bId=${contentView.bId}
	@GetMapping("/delete")
	public String delete(BoardVO boardVO, Model model) {
		
		boardService.deleteBoardVO(boardVO.getBoard_numbers());
		log.info("삭제 성공");
		return "redirect:/";
	}
	

	//댓글 기능
	//댓글 작성
	@ResponseBody
	@PostMapping("/addComments")
	public void writeComment(CommentVO commentVO){
		boardService.writeComment(commentVO);
	}
		
	//댓글 삭제
	@ResponseBody
	@PostMapping("/delComments")
	public void delComment(int comments_numbers){
		boardService.delComment(comments_numbers);
	}
		
	//신고기능
	@ResponseBody
	@PostMapping("/report")
	public void report(BoardVO boardVO) {
		log.info(boardVO.getBoardlist_numbers());
		log.info(boardVO.getTitle());
		log.info(boardVO.getContents());
		log.info(boardVO.getFilter_numbers());
		log.info(boardVO.getMember_id());
			
		boardService.writeBoardVO(boardVO);
		log.info("신고 성공");
			
	}	 
	

}
