package bit.project.restfull.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import bit.project.restfull.mapper.BoardMapper;
import bit.project.restfull.mapper.CommentMapper;
import bit.project.restfull.vo.AttachmentVO;
import bit.project.restfull.vo.BoardVO;
import bit.project.restfull.vo.CommentVO;
import bit.project.restfull.vo.LikesVO;
import bit.project.restfull.vo.PagingVO;
import bit.project.restfull.vo.RequestVO;
import bit.project.restfull.vo.TravelVO;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.geometry.Positions;

@Log4j
@Service
@NoArgsConstructor
@AllArgsConstructor
public class BoardServiceImpl implements BoardService{ 
	
	@Autowired
	private BoardMapper boardMapper;	
	
	@Autowired
	private CommentMapper commentMapper;
	
	@Override
	public List<BoardVO> getList(PagingVO pagingVO, int boardlist_numbers, String searchWord) {
		log.info("boardServicImpl-getList(게시글 목록 호출): " + searchWord);
		int start = pagingVO.getStart();
		int end = pagingVO.getEnd();
		log.info(start);
		log.info(end);
		return boardMapper.getList(boardlist_numbers, searchWord, start, end);
	}

	@Override
	public BoardVO getBoardVO(int board_numbers) {
		log.info("boardServicImpl-getBoardVO(게시글 호출): " + board_numbers);
		boardMapper.upHit(board_numbers);
		return boardMapper.getBoardVO(board_numbers);
	}
	
	@Override
	public List<AttachmentVO> getBoardAttachmentVO(int board_numbers) {
		log.info("boardServicImpl-getBoardVO(게시글 호출): " + board_numbers);
		return boardMapper.getBoardAttachmentVO(board_numbers);
	}

	@Override
	public int writeBoardVO(MultipartFile[] uploadfiles, BoardVO boardVO) throws IllegalStateException, IOException {
		//0.파일경로
		//학원 컴 경로 C:\Users\bit\Desktop\
		// String root_path = "C:/Users/hoora/Desktop"; 
		String root_path = "C:/Users/bit/Desktop";
		String attach_path = "/resources/upload/";

		//1.글작성
		boardMapper.insertBoardVO(boardVO);
		int bNum = boardVO.getBoard_numbers();
		log.info("insertBoardVO() completed. 글번호는 " + bNum);
		
		 
		//2. 파일 업로드
		Map<String,Object>fileMap = new HashMap<String,Object>();
        
        for(int i = 0; i<uploadfiles.length; i++) {
            try {
            	//프로젝트 폴더 내에 저장. 사진 파일명 중복 방지를 위한 이름 재생성
            	UUID uuid = UUID.randomUUID();	//랜덤 문자열 생성
        		String fileName = uuid + "_" + uploadfiles[i].getOriginalFilename();
        		
                //첫번째 요소에 대해서만 썸네일을 생성함
        		if(i == 0) {
        		
	        		File target = new File(root_path+attach_path, fileName);
	       		  	FileCopyUtils.copy(uploadfiles[i].getBytes(), target);
	       		  	
	       		  	String thumbFileName = "THUMB_" + fileName;
	       		    File image = new File(root_path+attach_path,fileName);
	
	       		    String thumbDir = File.separator + "thumbnails" + File.separator + thumbFileName;
	       		    File thumbnail = new File(root_path + attach_path + thumbDir);
	
	       		    log.info("thumbDir = " + thumbDir);
	       		    
	       		    if (image.exists()) {
		       		    thumbnail.getParentFile().mkdirs();
		       		    
		       		    Thumbnails.of(image).crop(Positions.CENTER).size(200, 200).keepAspectRatio(true).toFile(thumbnail);
	       		    }
	       		    
	       		    int fileSize = (int) uploadfiles[i].getSize();	
	                String fileDirectory = attach_path + fileName;
	                
	       		    fileMap.put("fileDirectory", fileDirectory);
	                fileMap.put("fileName", fileName);
	                fileMap.put("fileSize", fileSize);
	                System.out.println("fileMap :"+fileMap);
	                uploadfiles[i].transferTo(image);
	                
	                boardMapper.insertAttachmentVO(fileMap);
	       		    boardMapper.updateBoardThumbImg(bNum, attach_path + thumbDir);
	                
        		} else {
        			//첫번째 요소가 아니라면 그냥 저장
	        		int fileSize = (int) uploadfiles[i].getSize();	
	                String fileDirectory = attach_path + fileName;
	                log.info("저장된 이름 :"+ fileName);
	                
	                File saveFile = new File(root_path+attach_path,fileName); // 실제로 저장할 폴더 이름 + 저장할 파일 이름으로 저장할 파일 객체를 생성함
	                //저장 경로를 DB에 등록
	                fileMap.put("fileDirectory", fileDirectory);
	                fileMap.put("fileName", fileName);
	                fileMap.put("fileSize", fileSize);
	                System.out.println("fileMap :"+fileMap);
	                uploadfiles[i].transferTo(saveFile);
	                boardMapper.insertAttachmentVO(fileMap);
	            }
            } catch(Exception e){
                log.error("Error while uploading", e);
            }
            
	    }
        return bNum;
	}
	
	@Override
	public void modifyBoardVO(BoardVO boardVO) {
		boardMapper.updateBoardVO(boardVO);
	}

	@Override
	public void deleteBoardVO(int board_numbers) {
		boardMapper.deleteBoardVO(board_numbers);
	}


	//좋아요 기능 (1) 좋아요 상태 업데이트
	@Override
	public void likeUpdate(LikesVO likesVO){
		log.info("서비스단 조아요 기능 " );
		//좋아요 상태 체크 함수 호출
		int result = likeCheck(likesVO);
		
		if(result == 0){ // 좋아요를 누르지 않으면 0
			boardMapper.likeInsert(likesVO);
		}else{ 
			boardMapper.likeDelete(likesVO);
		}
	}
	
	//좋아요 기능 (2) 갯수 세기
	@Override
	public int likeCount(int board_numbers) {
		return boardMapper.likeCount(board_numbers);
	}

	//좋아요 기능 (3) 좋아요 상태 체크
	@Override
	public int likeCheck(LikesVO likesVO) {
		int result = boardMapper.likeCheck(likesVO);
		return result;
	}

	//댓글 기능
	@Override
	public void writeComment(CommentVO commentVO) {
		String cts = commentVO.getContents();
		log.info(cts);
		commentMapper.insertComment(commentVO);
	}

	@Override
	public List<CommentVO> commentList(int board_numbers) {
		return commentMapper.commentList(board_numbers);
	}

	@Override
	public void delComment(int comments_numbers) {
		commentMapper.delComment(comments_numbers);
	}

	@Override
	public List<BoardVO> getOtherBoardVO(int board_numbers, String location) {
		return boardMapper.getOthers(board_numbers, location);
	}

	//신고기능
	@Override
	public void writeBoardVO(BoardVO boardVO) {
		boardVO.setLocation("");
		boardMapper.insertBoardVO(boardVO);
	}

	//유저 > 자기가쓴 게시글 확인
	@Override
	public List<BoardVO> boardList(String member_id, PagingVO pagingVO){
		log.info(member_id);
		int start = pagingVO.getStart();
		int end = pagingVO.getEnd();
		log.info(start);
		log.info(end);
		
		return boardMapper.boardList(member_id, start, end);
	}

	@Override
	public List<BoardVO> qnaList(String member_id){
		return boardMapper.qnaList(member_id);
	}
	@Override
	public List<BoardVO> askList(String member_id){
		return boardMapper.askList(member_id);
	}

	@Override
	public List<RequestVO> getPaymentList(String member_id) {
		return boardMapper.paymentList(member_id);
	}

	@Override
	public List<BoardVO> getLikeList(String member_id) {
		return boardMapper.getLikeList(member_id);
	}

	@Override
	public int countBoard(String member_id) {
		return boardMapper.countBoard(member_id);
	}

	@Override
	public List<TravelVO> getMyCourseList(String member_id) {
		return boardMapper.getMyCourseList(member_id);
	}

	@Override
	public List<TravelVO> getMyCourse(String member_id, String serialNum) {
		return boardMapper.getMyCourse(member_id, serialNum);
	}

	@Override
	public int countMainBoard(int boardlist_numbers, String searchWord) {
		return boardMapper.countMainBoard(boardlist_numbers,searchWord);
	}

	@Override
	public int countAdBoard(String member_id) {
		return boardMapper.countAdBoard(member_id);
	}

}
