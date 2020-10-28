package bit.project.restfull.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import bit.project.restfull.service.AdminBoardService;
import bit.project.restfull.service.PaymentService;
import bit.project.restfull.vo.RequestVO;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@NoArgsConstructor
@AllArgsConstructor
//아임포트 - 결제 기능 정의
public class PayController {

	private AdminBoardService adBoardService;
	private PaymentService paymentService;

	/*
	 * 아임포트 REST API 결제완료된 정보, 결제취소, 상태별 결제목록 조회 등의 기능을 하는 REST API를 제공합니다.
	 * 비인증결제,정기 자동결제 등 부가기능을 위한 REST API를 제공합니다.
	 *	== 즉, 결제완료된 이후에 결제 정보를 가져오고 저장하기 위해서는 아임포트 서버의 데이터를 가져오는 rest api를 사용해야 한다는 뜻
	 * 따라서 저장을 위한 데이터 생성 이전에 아임포트 토큰 생성 후 데이터를 가져오는 메소드를 호출 --> 가져온 데이터로 db에 저장
	 */
	 
	@ResponseBody
	@PostMapping("payments/sumPrice")
	public int sumPrice(@RequestBody List<Map<String,Object>> paramData) {
		log.info("합계금액구하기");
		return adBoardService.sumPrice(paramData);
	}

	@ResponseBody
	@PostMapping("/payments/complete")
	public int paymentComplete(HttpServletRequest req) throws UnsupportedEncodingException {
		log.info("결제 성공 증거");
		String token = paymentService.getImportToken();
		log.info("get token = " + token);
		
		String imp_uid = req.getParameter("imp_uid");
		log.info("imp_uid = " + imp_uid);
		
		//아임포트 서버에서 결제 상태 확인(결제정보 비교)
		int result = paymentService.comparePaymentData(token, imp_uid);
		log.info("result : " + result);
		
		//결제가 확인되면 결제 금액 위변조에 대해 검증함
		String merchant_uid = req.getParameter("merchant_uid");
		int getView_TotalPrice = Integer.parseInt(req.getParameter("totalPrice"));
		log.info("view에서 얻어온 totalPrice는 : " + getView_TotalPrice);
		List<RequestVO> getServ_TotalPrice = adBoardService.getRequests(merchant_uid);
		
		int totalPrice = 0;
		log.info(getServ_TotalPrice.size());
		for(int i=0;i<getServ_TotalPrice.size();i++) {
			totalPrice += getServ_TotalPrice.get(i).getPrice();
			log.info("totalPrice는 " + totalPrice);
		}
		
		//금액이 위변조 되었는지에 대한 결과를 리턴
		if(totalPrice == getView_TotalPrice) {
			log.info("결제 금액 조작 미감지됨. 결제정보 업데이트 ");
			
			return 1;
		} else {
			log.info("조작된 결제금액 감지");
			return -1;
		}
	}
	
	@ResponseBody
	@PostMapping("/payments/confirmation")
	public void paymentConfirmation(HttpServletRequest req) {
		//결제가 완료되면 발급받는 imp_uid를 기존 주문 정보에 업데이트한다.
		String imp_uid = req.getParameter("imp_uid");
		String merchant_uid = req.getParameter("merchant_uid");
		
		adBoardService.updateRequest(imp_uid,merchant_uid);
	}
	
	@GetMapping("/payments/comfirm")
	public String resultComfirm(HttpServletRequest req) {
		log.info("결제이후페이지");
		
		return "user/paymentComplete";	
	}
}

