package bit.restfull.service;

import java.io.File;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import bit.restfull.mapper.AdminBoardMapper;
import bit.restfull.vo.AdminBoardVO;
import bit.restfull.vo.AttachmentVO;
import bit.restfull.vo.DestinationVO;
import bit.restfull.vo.GoodsVO;
import bit.restfull.vo.RequestVO;
import bit.restfull.vo.SidoguVO;
import bit.restfull.vo.TravelVO;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.geometry.Positions;

@Log4j
@Service
@NoArgsConstructor
@AllArgsConstructor
public class AdminBoardServiceImpl implements AdminBoardService {

	@Autowired
	private AdminBoardMapper adBoardMapper;	
	
	@Override
	public List<AdminBoardVO> getList(int boardlist_numbers) {
		return adBoardMapper.getList(boardlist_numbers);
	}

	@Override
	public AdminBoardVO getBoardVO(int board_numbers) {
		log.info("boardServicImpl-getBoardVO(게시글 호출): " + board_numbers);
		adBoardMapper.upHit(board_numbers);
		return adBoardMapper.getBoardVO(board_numbers);
	}
	
	@Override
	public List<AttachmentVO> getBoardAttachmentVO(int board_numbers) {
		log.info("boardServicImpl-getBoardVO(게시글 호출): " + board_numbers);
		return adBoardMapper.getBoardAttachmentVO(board_numbers);
	}

	@Override
	public void writeBoardVO(MultipartFile[] uploadfiles, AdminBoardVO boardVO) {
        //1.글작성
		adBoardMapper.insertBoardVO(boardVO);
		int bNum = boardVO.getBoard_numbers();
		log.info("insertBoardVO() completed");
		
		//2. 파일 업로드
		String root_path = "C:/Users/bit/Desktop";
		String attach_path = "/resources/upload/";

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
 	                
 	                adBoardMapper.insertAttachmentVO(fileMap);
 	       		    adBoardMapper.updateBoardThumbImg(bNum, attach_path + thumbDir);
 	                
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
 	                adBoardMapper.insertAttachmentVO(fileMap);
 	            }
            }
            catch(Exception e){
                log.error("Error while uploading", e);
            }
	    }

	}

	@Override
	public void modifyBoardVO(AdminBoardVO boardVO) {
		adBoardMapper.updateBoardVO(boardVO);
	}

	@Override
	public void deleteBoardVO(int board_numbers) {
		adBoardMapper.deleteBoardVO(board_numbers);
	}

	
	// 여행지 등록을 위한 드롭다운 옵션 세팅
	@Override
	public List<SidoguVO> getOptionList(int sidoCode) {
		return adBoardMapper.sigunguList(sidoCode);
	}
	
	// 여행지 등록
	@Override
	public List<DestinationVO> getDestList() {
		log.info("adBoardMapper.getDestList();");
		return adBoardMapper.getDestList();
	}

	@Override
	public DestinationVO getDestVO(int destination_numbers) {
		log.info("adBoardMapper.getDestVO");
		return adBoardMapper.getDestVO(destination_numbers);
	}

	@Override
	public void writeDestVO(DestinationVO destinationVO) {
		int dNum = adBoardMapper.insertDestVO(destinationVO);
		Map<String, Object> resultMap = new HashMap<String, Object>();
	    resultMap.put("dNum", destinationVO.getDestination_numbers());
		log.info("반환받은 번호 : " + resultMap.get("dNum"));
		//adBoardMapper.updateBoardVO_DestNum(mydNum);
		//return (int) resultMap.get("dNum");
	}

	

	@Override
	public void writeDestVO(Map<String, Object> paramData) {
		int board_numbers = (int) paramData.get("board_numbers");
		String destination_name = (String) paramData.get("destination_name");
		String jibunaddress = (String) paramData.get("jibunaddress");
		String doroaddress = (String) paramData.get("doroaddress");
		String details = (String) paramData.get("details");
		String lat = (String) paramData.get("lat");
		String lng = (String) paramData.get("lng");
		
		DestinationVO vo = new DestinationVO();
		vo.setDestination_name(destination_name);
		vo.setJibunaddress(jibunaddress);
		vo.setDoroaddress(doroaddress);
		vo.setDetails(details);
		vo.setLat(lat);
		vo.setLng(lng);
		
		int dNum = adBoardMapper.insertDestVO(vo);
		Map<String, Object> resultMap = new HashMap<String, Object>();
	    resultMap.put("dNum", vo.getDestination_numbers());
	    
	    int mydNum =  vo.getDestination_numbers();
		log.info("반환받은 번호 : " + resultMap.get("dNum"));
		adBoardMapper.updateBoardVO_DestNum(mydNum, board_numbers);
	}
	
	@Override
	public void modifyDestVO(DestinationVO destinationVO) {
		adBoardMapper.updateDestVO(destinationVO);
	}

	@Override
	public void deleteDestVO(int destination_numbers) {
		adBoardMapper.deleteDestVO(destination_numbers);
	}
	
	//여행지 관련 상품 목록
	@Override
	public List<GoodsVO> getGoodsList(int destination_numbers) {
		return adBoardMapper.getGoodsList(destination_numbers);
	}
	
	//상품 CRUD
	@Override
	public GoodsVO getGoodsVO(int goods_numbers) {
		return adBoardMapper.getGoodsVO(goods_numbers);
	}

	@Override
	public void writeGoodsVO(GoodsVO goodsVO) {
		adBoardMapper.insertGoodsVO(goodsVO);
	}

	@Override
	public void modifyGoodsVO(GoodsVO goodsVO) {
		adBoardMapper.updateGoodsVO(goodsVO);
	}

	@Override
	public void deleteGoodsVO(int goods_numbers) {
		adBoardMapper.deleteGoodsVO(goods_numbers);
	}

	@Override
	public List<DestinationVO> getDestList(int sigungu_code) {
		return adBoardMapper.getDests(sigungu_code);
	}
	
	public List<GoodsVO> getRGoods(int[] destination_numbers) {
		log.info("getRGoods()");
		return adBoardMapper.getRGoods(destination_numbers);
	}

	@Override
	public List<AdminBoardVO> getFilterList(int boardlist_numbers) {
		return adBoardMapper.getFilterList(boardlist_numbers);
	}

	@Override
	public List<GoodsVO> myGoods(String[] goodsList) {
		return adBoardMapper.myGoods(goodsList);
	}

	@Override
	public List<RequestVO> insertRequest(List<Map<String, Object>> paramData) {
		List<RequestVO> requestList = new ArrayList<RequestVO>();
		int length = paramData.size();
		long merchant_num = System.currentTimeMillis();
		String merchant_uid = "restfull_" + merchant_num;
		//주문 row 생성
		//주문예약번호, 주문일시,	결제번호,	회원_ID,	상품번호, 	여행지이름, 취소여부
		for(int i=0; i<length; i++) {
			//사용자가 티켓 매수를 2개 이상 선택했을 경우 중복 row를 생성해야함
			int count = Integer.parseInt((String)paramData.get(i).get("count"));
			if(count > 1) {
				for(int j = 0; j < count; j++) {
					RequestVO vo = new RequestVO();
					UUID uuid = UUID.randomUUID();	//랜덤 문자열 생성
					vo.setRequest_numbers("req_" + uuid);	//주문 예약번호
					vo.setMerchant_uid(merchant_uid);		//주문번호
					vo.setImp_uid(null);
					vo.setMember_id((String)paramData.get(i).get("member_id"));	//주문자 아이디
					vo.setGoods_numbers(Integer.parseInt((String)paramData.get(i).get("goods_numbers")));
					vo.setDestination_numbers((String)paramData.get(i).get("destination_numbers"));
					vo.setCancel(0);
					requestList.add(vo);
				}
			} else {
				RequestVO vo = new RequestVO();
				UUID uuid = UUID.randomUUID();	//랜덤 문자열 생성
				vo.setRequest_numbers("req_" + uuid);	//주문 예약번호
				vo.setMerchant_uid(merchant_uid);		//주문번호
				vo.setImp_uid(null);
				vo.setMember_id((String)paramData.get(i).get("member_id"));	//주문자 아이디
				vo.setGoods_numbers(Integer.parseInt((String)paramData.get(i).get("goods_numbers")));
				vo.setDestination_numbers((String)paramData.get(i).get("destination_numbers"));
				vo.setCancel(0);
				requestList.add(vo);
			}
		}
		
		adBoardMapper.insertRequest(requestList);		
		return getRequests(merchant_uid);
	}
	
	@Override
	public List<RequestVO> getRequests(String merchant_uid){
		return adBoardMapper.getRequests(merchant_uid);
	}

	@Override
	public void updateRequest(String imp_uid, String merchant_uid) {
		adBoardMapper.updateRequests(imp_uid,merchant_uid);
	}

	@Override
	public int sumPrice(List<Map<String, Object>> paramData) {
		int prices = 0;
		
		for(int i=0;i<paramData.size();i++) {
			log.info("상품 번호 목록 ? " + paramData.get(i).get("goods_numbers"));
			int goods_numbers= Integer.parseInt((String) paramData.get(i).get("goods_numbers"));
			int count = Integer.parseInt((String) paramData.get(i).get("count"));
			GoodsVO vo = getGoodsVO(goods_numbers);
			int price = vo.getPrice() * count;
			log.info(goods_numbers + " * " + count + " = " + price);
			prices += price;
		}
		log.info("총 합계 금액 : " + prices);
		return prices;
	}

	@Override
	public void insertTravelCourse(String member_id, String[] destinations) {
		List<TravelVO> myCourse = new ArrayList<TravelVO>();

		long millis = System.currentTimeMillis();
		String serialnum = "travel_course_" + millis;
		
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy년MM월dd일");
		String tcAlias = format1.format(millis) + "의 여행코스";
		

		for(int i = 0; i<destinations.length; i++) {
			TravelVO vo = new TravelVO(); 
			vo.setMember_id(member_id);
			vo.setTcContents(destinations[i]);
			vo.setTcAlias(tcAlias);
			vo.setSerialNum(serialnum);
			myCourse.add(vo);
		}
		
		adBoardMapper.insertTravelCourse(myCourse);
	}

	//모든 사용자의 주문내역(관리자 기능)
	@Override
	public List<RequestVO> getRequestList() {
		return adBoardMapper.getRequestListForAdmin();
	}

}