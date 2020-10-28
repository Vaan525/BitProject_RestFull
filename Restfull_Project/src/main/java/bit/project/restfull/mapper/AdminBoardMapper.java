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

import bit.project.restfull.vo.AdminBoardVO;
import bit.project.restfull.vo.AttachmentVO;
import bit.project.restfull.vo.DestinationVO;
import bit.project.restfull.vo.GoodsVO;
import bit.project.restfull.vo.RequestVO;
import bit.project.restfull.vo.SidoguVO;
import bit.project.restfull.vo.TravelVO;
public interface AdminBoardMapper{
	/*
	 * 다중 게시판을 활용하므로, 쿼리문이 매우 길기때문에 너무 긴 쿼리문은 가독성을 위해 xml파일에 위치 유지
	 * 혹은 <foreach>를 사용하는 동적 쿼리문 생성은 xml에 위치 유지 ( <foreach>를 사용하는 메소드일 경우 메소드 옆에 <foreach>로 표기 ) 
	 */
	
	/* 공지사항 등의 게시글 목록 출력 */
	@ResultMap("BoardContents")
	@Select("select b.*, l.*, a.* from board b, boardlist l, attachment a"
			+ " where b.board_numbers = a.board_numbers" 
			+ " and b.boardlist_numbers = l.boardlist_numbers"  
			+ " and l.boardlist_numbers = #{boardlist_numbers}")
	List<AdminBoardVO> getList(int boardlist_numbers);
	
	/* 메인 게시글 출력(contentView) */
	@Select("select * from board where board_numbers = #{board_numbers}")
	AdminBoardVO getBoardVO(int board_numbers);
	
	@Select("select a.* from board b, attachment a"
			+ " where b.board_numbers = a.board_numbers" 
			+ " and b.board_numbers = #{board_numbers} ")
	List<AttachmentVO> getBoardAttachmentVO(int board_numbers);

	/* 조회수 올리기 */
	@Update("update board set hit = hit + 1 where board_numbers = #{board_numbers}")
	void upHit(int board_numbers);
	
	/* 글작성(첨부파일 테이블+게시판 테이블) */
	@Insert("insert into board (board_numbers, title, contents, hit, dates, member_id, boardlist_numbers)"
			+ " values (BOARD_SEQ.NEXTVAL, #{title}, #{contents}, 0, sysdate, #{member_id},#{boardlist_numbers})")
	void insertBoardVO(AdminBoardVO boardVO);
	
	/* 첨부파일 */
	@SelectKey(statement="select BOARD_SEQ.CURRVAL as board_numbers from dual", keyProperty="board_numbers", before=true, resultType=int.class)
	@Insert("insert into attachment (fileName, board_numbers, fileDirectory, fileSize) values (#{fileName}, #{board_numbers}, #{fileDirectory},#{fileSize})")
	void insertAttachmentVO(Map<String, Object> fileMap);

	/* 글수정(게시판 테이블) */
	@Update("update board set title = #{title}, contents = #{contents} where board_numbers = #{board_numbers}")
	void updateBoardVO(AdminBoardVO boardVO);
	
	/* 글삭제(게시판테이블) */
	@Delete("delete from board where board_numbers = #{board_numbers}")
	void deleteBoardVO(int board_numbers);

	/* 여행지 목록 출력 */
	@ResultMap("DestinationContents")
	@Select("select * from destination d, sidogu s" 
			+ " where d.sigungu_code = s.sigungu_code" 
			+ " order by s.sidocode asc, s.sigunguname asc, d.destination_name asc")
	List<DestinationVO> getDestList();
	
	/* 특정 여행지 보기 */
	@ResultMap("DestinationContents")
	@Select("select * from destination d, sidogu s where d.sigungu_code = s.sigungu_code and d.destination_numbers = #{destination_numbers} ")
	DestinationVO getDestVO(int destination_numbers);
	
	/* 여행지 등록 */
	@SelectKey(statement="select destination_seq.currval as destination_numbers from dual", keyProperty="destination_numbers", before=false, resultType=int.class)
	@Insert("insert into destination (destination_numbers, destination_name, jibunaddress, doroaddress, details, lat, lng, sigungu_code)"
			+ " values (destination_seq.nextval, #{destination_name}, #{jibunaddress}, #{doroaddress}, #{details}, #{lat}, #{lng}, #{sigungu_code})")
	int insertDestVO(DestinationVO destinationVO);
	
	/* 여행지 수정 */
	@Update("update destination set jibunaddress = #{jibunaddress}, doroaddress = #{doroaddress}, details = #{details}, lat = #{lat}, lng = #{lng}, sigungu_code = #{sigungu_code} where destination_numbers = #{destination_numbers}")
	void updateDestVO(DestinationVO destinationVO);
	
	/* 여행지 삭제 */
	@Delete("delete from destination where destination_numbers = #{destination_numbers}")
	void deleteDestVO(int destination_numbers);
		
	/* 지역 번호 목록 출력 */
	@Select("select * from sidogu where sidocode = #{sidoCode} order by sidocode asc")
	List<SidoguVO> sigunguList(int sidocode);
	
	/* 상품 목록 출력 */
	@Select("select * from goods where destination_numbers = #{destination_numbers}")
	List<GoodsVO> getGoodsList(int destination_numbers);
	
	/* 상품 보기 */
	@Select("select * from goods where goods_numbers = #{goods_numbers}")
	GoodsVO getGoodsVO(int goods_numbers);
	
	/* 상품 등록 */
	@Insert("insert into goods (goods_numbers,destination_numbers,destination_name,name,price,amount,status,sellstart,sellend,seller)"
			+ "values (goods_seq.nextval,#{destination_numbers}, #{destination_name}, #{name}, #{price},#{amount},#{status},#{sellstart},#{sellend},#{seller})")
	void insertGoodsVO(GoodsVO goodsVO);
	
	/* 상품 수정 */
	@Update("update goods set destination_numbers=#{destination_numbers},name=#{name},price=#{price},amount=#{amount},status=#{status},sellstart=#{sellstart},sellend=#{sellend},seller=#{seller}"
			+ "where goods_numbers = #{goods_numbers}")
	void updateGoodsVO(GoodsVO goodsVO);
	
	/* 상품 삭제 */
	@Delete("delete from goods where goods_numbers = #{goods_numbers}")
	void deleteGoodsVO(int goods_numbers);

	
	/* 여행지 목록출력(시군구 코드를 받아 해당 시군구 코드에 맞는 여행지만 출력함. 위의 getDestList는 모든 여행지를 출력함.) */
	@Select("select * from destination where sigungu_code = #{sigungu_code}")
	List<DestinationVO> getDests(int sigungu_code);
	
	/* 썸네일 이미지 업데이트 */
	@Update("update board set thumbnail=#{thumbnail} where board_numbers = #{board_numbers}")
	void updateBoardThumbImg(@Param("board_numbers") int board_numbers, @Param("thumbnail")String thumbnail);
	
	/* 관련 상품출력  <foreach>*/
	List<GoodsVO> getRGoods(int[] destination_numbers);

	/* 필터있는 게시판 리스트 뽑기 <쿼리문 길어서 xml에 위치 유지> */
	List<AdminBoardVO> getFilterList(int boardlist_numbers);
	
	/* 특정 상품정보출력 <foreach>*/
	List<GoodsVO> myGoods(String[] goodsList);

	/* 주문 정보 등록 <foreach>*/
	void insertRequest(List<RequestVO> requestList);

	/* 주문 정보 등록 후에 호출 - 주문 정보의 위변조 등을 비교하기 위해 주문 정보를 가져옴 */
	@Select("select  r.*, g.price as price, g.name as productName from  request r, goods g" 
			+ " where r.goods_numbers = g.goods_numbers"
			+ " and r.merchant_uid = #{merchant_uid}")
	List<RequestVO> getRequests(String request_numbers);

	/* 상품 결제 후 주문 정보를 결제된 상태로 업데이트 */
	@Update("update request set imp_uid = #{imp_uid} where merchant_uid = #{merchant_uid}")
	void updateRequests(@Param("imp_uid")String imp_uid,@Param("merchant_uid")String merchant_uid);

	/* 여행코스 등록 <foreach>*/
	void insertTravelCourse(List<TravelVO> myCourse);

	/* 관리자 권한 : 모든 주문 내역 출력 */
	@Select("select r.*, g.name as productName from request r, goods g"
			+ " where r.goods_numbers = g.goods_numbers" 
			+ " order by dates desc, merchant_uid desc")
	List<RequestVO> getRequestListForAdmin();

	/* 여행지번호 update */
	@Update("update board set destination_numbers = #{mydNum} where board_numbers = #{board_numbers}")
	void updateBoardVO_DestNum(@Param("mydNum")int mydNum,@Param("board_numbers")int board_numbers);

}