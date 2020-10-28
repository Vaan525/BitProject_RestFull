package bit.project.restfull.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import bit.project.restfull.vo.AttachmentVO;
import bit.project.restfull.vo.BoardVO;
import bit.project.restfull.vo.LikesVO;
import bit.project.restfull.vo.PagingVO;
import bit.project.restfull.vo.RequestVO;
import bit.project.restfull.vo.TravelVO;

@Mapper
public interface BoardMapper{
	
	/* 일반게시글 목록 출력 (관리자와 불러오는 테이블 수가 다르므로 따로 정의) */
	@ResultMap("BoardContents")
	@Select("Select * from (SELECT ROWNUM RN, A.* FROM"
			+ "(select b.*,d.lat,d.lng, d.destination_name"
			+ " from board b, destination d"
			+ " where b.destination_numbers = d.destination_numbers"
			+ "	and b.boardlist_numbers = #{boardlist_numbers}"
			+ "	and b.location like '%'||#{searchWord}||'%' ) A )"
			+" WHERE RN BETWEEN #{start} AND #{end}")
	List<BoardVO> getList(@Param("boardlist_numbers")int boardlist_numbers, @Param("searchWord") String searchWord, @Param("start")int start,  @Param("end")int end);
	
	/* 메인 게시글 출력(contentView) */
	@Select("select * from board where board_numbers = #{board_numbers}")
	BoardVO getBoardVO(int board_numbers);
	
	/* 메인 게시글의 첨부파일 출력 */
	@Select("select a.* from board b, attachment a"
			+ " where b.board_numbers = a.board_numbers"
			+ "	and b.board_numbers = #{board_numbers} ")
	List<AttachmentVO> getBoardAttachmentVO(int board_numbers);

	/* 조회수 */
	@Update("update board set hit = hit + 1 where board_numbers = #{board_numbers}")
	void upHit(int board_numbers);
	
	/* 글작성(첨부파일 테이블+게시판 테이블) */
	@SelectKey(statement="select BOARD_SEQ.CURRVAL as board_numbers from dual", keyProperty="board_numbers", before=false, resultType=int.class)
	@Insert("insert into board (board_numbers, title, contents, hit, dates, member_id,boardlist_numbers,filter_numbers, location)"
			+ " values (BOARD_SEQ.NEXTVAL, #{title}, #{contents}, 0, sysdate, #{member_id},#{boardlist_numbers}, #{filter_numbers},#{location,jdbcType=VARCHAR})")
	int insertBoardVO(BoardVO boardVO);
	
	/* 첨부파일 */
	@SelectKey(statement="select BOARD_SEQ.CURRVAL as board_numbers from dual", keyProperty="board_numbers", before=true, resultType=int.class)
	@Insert("insert into attachment (fileName, board_numbers, fileDirectory, fileSize) values (#{fileName}, #{board_numbers}, #{fileDirectory},#{fileSize})")
	void insertAttachmentVO(Map<String, Object> fileMap);

	/* 썸네일 이미지 업데이트 */
	@Update("update board set thumbnail=#{thumbnail} where board_numbers = #{board_numbers}")
	void updateBoardThumbImg(@Param("board_numbers") int board_numbers, @Param("thumbnail")String thumbnail);

	/* 글수정(게시판 테이블) */
	@Update("update board set title = #{title}, contents = #{contents}, location = #{destination_numbers} where board_numbers = #{board_numbers}")
	void updateBoardVO(BoardVO boardVO);
	
	/* 글삭제(게시판테이블) */
	@Delete("delete from board where board_numbers = #{board_numbers}")
	void deleteBoardVO(int board_numbers);
	
	/* 좋아요 상태 체크 */
	@Select("select count(*) from likes where board_numbers= #{board_numbers} and member_id = #{member_id}")
	int likeCheck(LikesVO likesVO);
	
	/* 좋아요 추가 */
	@Insert("insert into likes values(#{board_numbers}, #{member_id})")
	void likeInsert(LikesVO likesVO);
	
	/* 좋아요 취소 */
	@Delete("delete from likes where board_numbers= #{board_numbers} and member_id = #{member_id}")
	void likeDelete(LikesVO likesVO);
	
	/* 좋아요 수 체크 */
	@Select("select count(*) from likes where board_numbers= #{board_numbers}")
	int likeCount(int board_numbers);

	/* 관련 게시글 목록 불러오기 */
	@Select("select * from board where boardlist_numbers = 1" 
			+ " and destination_numbers like '%'||#{destination_numbers}||'%'" 
			+ " and not board_numbers in #{board_numbers}")
	List<BoardVO> getOthers(@Param("board_numbers") int board_numbers, @Param("destination_numbers") String destination_numbers);

	@Select("select count(*) from board where member_id = #{member_id}")
	public int countBoard(String member_id);
	
	@Select("select count(*) from board where member_id = #{member_id} and boardlist_numbers='1' ")
	public int countAdBoard(String member_id);
	
	@Select("Select * from (SELECT ROWNUM RN, A.* FROM "
			+ "(select * from board b where boardlist_numbers = '1' and member_id = #{member_id} order by board_numbers) A ) "
			+ "WHERE RN BETWEEN #{start} AND #{end}")
	public List<BoardVO> boardList(@Param("member_id")String member_id, @Param("start")int start,  @Param("end")int end);

	/* 유저 문의내역 확인 */
	@Select("select * from board where member_id = #{member_id} and boardlist_numbers = '4' order by board_numbers")
	public List<BoardVO> qnaList(String member_id);

	/* 유저 신고내역 확인 */
	@Select("select * from board where member_id = #{member_id} and boardlist_numbers = '3' order by board_numbers")
	public List<BoardVO> askList(String member_id);

	/* 유저 > 결제내역 확인(by여진) */
	@Select("select r.*, g.name as productName from request r, goods g where r.goods_numbers = g.goods_numbers and r.member_id = #{member_id} order by dates desc, merchant_uid desc")
	List<RequestVO> paymentList(String member_id);

	/* 유저 > 내가 좋아요 누른 글들을 확인(by여진) */
	@Select("select b.* from likes l, board b where l.board_numbers = b.board_numbers and l.member_id = #{member_id}")
	List<BoardVO> getLikeList(String member_id);

	/* 여행코스 목록 가져오기(by여진) */
	@Select("select distinct tcAlias, dates, serialNum from travel where member_id = #{member_id} group by tcAlias, dates, serialNum")
	List<TravelVO> getMyCourseList(String member_id);

	/* 특정 여행코스 가져오기 */
	@Select("select * from travel where member_id = #{member_id} and serialNum = #{serialNum} order by travel_numbers")
	List<TravelVO> getMyCourse(@Param("member_id")String member_id, @Param("serialNum")String serialNum);
	
	@Select("select count(*) from comments where board_numbers = #{board_numbers}")
	public int countComment(int board_numbers);
	
	// 메인 게시글 리스트 숫자세기
	@Select("select count(*) from board b, destination d" 
			+ " where b.destination_numbers = d.destination_numbers" 
			+ " and b.boardlist_numbers = #{boardlist_numbers}"
			+ " and (d.destination_name like '%'||#{searchWord}||'%' or d.jibunaddress like '%'||#{searchWord}||'%')")
	public int countMainBoard(@Param("boardlist_numbers")int boardlist_numbers, @Param("searchWord") String searchWord);
		
}