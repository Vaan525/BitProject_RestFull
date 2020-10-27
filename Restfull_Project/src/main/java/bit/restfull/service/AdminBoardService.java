package bit.restfull.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import bit.restfull.vo.AdminBoardVO;
import bit.restfull.vo.AttachmentVO;
import bit.restfull.vo.DestinationVO;
import bit.restfull.vo.GoodsVO;
import bit.restfull.vo.RequestVO;
import bit.restfull.vo.SidoguVO;

public interface AdminBoardService {

	List<AdminBoardVO> getList(int boardlist_numbers);
	
	//관리자글
	AdminBoardVO getBoardVO(int board_numbers);
	List<AttachmentVO> getBoardAttachmentVO(int board_numbers);
	
	//관리자글 CRUD
	void writeBoardVO(MultipartFile[] uploadfiles, AdminBoardVO boardVO);
	void modifyBoardVO(AdminBoardVO boardVO);
	void deleteBoardVO(int board_numbers);

	//여행지 CRUD
	List<DestinationVO> getDestList();
	DestinationVO getDestVO(int destination_numbers);
	void writeDestVO(DestinationVO destinationVO);
	void modifyDestVO(DestinationVO destinationVO);
	void deleteDestVO(int destination_numbers);

	List<SidoguVO> getOptionList(int sicoCode);
	
	//상품 CRUD
	List<GoodsVO> getGoodsList(int destination_numbers);
	GoodsVO getGoodsVO(int goods_numbers);
	void writeGoodsVO(GoodsVO goodsVO);
	void modifyGoodsVO(GoodsVO goodsVO);
	void deleteGoodsVO(int goods_numbers);

	//여행지 Read - 여행코스짜기에서 사용함
	List<DestinationVO> getDestList(int sigungu_code);
	//관련 상품목록 Read
	List<GoodsVO> getRGoods(int[] destination_numbers);

	//필터게시판뽑기
	List<AdminBoardVO> getFilterList(int boardlist_numbers);
	
	//구매할 상품목록 Read
	List<GoodsVO> myGoods(String[] goodsList);

	//주문정보를 insert하고 가져옴
	List<RequestVO> insertRequest(List<Map<String, Object>> paramData);
	List<RequestVO> getRequests(String merchant_uid);

	//주문정보 update
	void updateRequest(String imp_uid, String merchant_uid);

	//합계금액 가져오기
	int sumPrice(List<Map<String, Object>> paramData);
	//여행코스 등록(int 반환형은 등록 성공 여부를 의미)
	void insertTravelCourse(String member_id, String[] destinations);

	//모든 주문 상품 출력(관리자 기준)
	List<RequestVO> getRequestList();

	//사용자 글작성 ...
	void writeDestVO(Map<String, Object> paramData);
}