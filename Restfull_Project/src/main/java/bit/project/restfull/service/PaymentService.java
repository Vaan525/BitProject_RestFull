package bit.project.restfull.service;

import java.util.List;
import java.util.Map;

import org.apache.http.NameValuePair;

public interface PaymentService{

	/*
	 * 인증 API 
	 * POST /users/getToken 
	 * 
	 * 결제관련 기본 API 
	 * GET /payments/{imp_uid} : 결제 확인
	 * GET /payments/status/{payment_status} 
	 * POST /payments/cancel 
	 * POST /subscribe/payments/onetime 
	 * POST /subscribe/payments/again 
	 * POST /subscribe/payments/schedule 
	 * POST /subscribe/payments/unschedule
	 * 
	 */
	
	/* 아임포트 깃허브에 공개되어 있는 url & api 목록 */
	public static final String IMPORT_TOKEN_URL = "https://api.iamport.kr/users/getToken"; 
	public static final String IMPORT_PAYCHECK_URL = "https://api.iamport.kr/payments/";
	public static final String IMPORT_PAYMENTINFO_URL = "https://api.iamport.kr/payments/find/"; 
	public static final String IMPORT_CANCEL_URL = "https://api.iamport.kr/payments/cancel"; 
	public static final String IMPORT_PREPARE_URL = "https://api.iamport.kr/payments/prepare"; 
	public static final String KEY = "imp_apikey"; 
	public static final String SECRET = "ekKoeW8RyKuT0zgaZsUtXXTLQ4AhPFW3ZGseDA6bkA5lamv9OqDMnxyeB9wqOsuO9W3Mx9YSJ4dTqJ3f";
	
	public String getImportToken();
	public List<NameValuePair> convertParameter(Map<String,String> paramMap);
	public int cancelPayment(String token, String mid);
	public String getAmount(String token, String mId);
	public int comparePaymentData(String token, String imp_uid);
	
}

