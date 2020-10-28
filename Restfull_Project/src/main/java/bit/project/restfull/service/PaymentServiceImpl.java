package bit.project.restfull.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@NoArgsConstructor
public class PaymentServiceImpl implements PaymentService {

	// 아임포트 인증(토큰)을 받아주는 함수 
	public String getImportToken() { 
		log.info("토큰값 받아오기 시작");
		String result = ""; 
		HttpClient client = HttpClientBuilder.create().build(); 
		HttpPost post = new HttpPost(IMPORT_TOKEN_URL);
		Map<String,String> m =new HashMap<String,String>(); 
		m.put("imp_key", KEY);
		m.put("imp_secret", SECRET); 
		log.info(m.get("imp_key"));
		log.info(m.get("imp_secret"));
		
		try {
			post.setEntity(new UrlEncodedFormEntity(convertParameter(m))); 
			HttpResponse res = client.execute(post); 
			ObjectMapper mapper = new ObjectMapper(); 
			
			String body = EntityUtils.toString(res.getEntity()); 
			
			JsonNode rootNode = mapper.readTree(body); 
			JsonNode resNode = rootNode.get("response"); 
			
			result = resNode.get("access_token").asText(); 
			
			log.info("access_token is " + result);
			
		} catch (Exception e) { 
			e.printStackTrace(); 
		} 
		return result; 
	} 
	
	// Map을 사용해서 Http요청 파라미터를 만들어 주는 함수 
	public List<NameValuePair> convertParameter(Map<String,String> paramMap){ 
		List<NameValuePair> paramList = new ArrayList<NameValuePair>(); 
		Set<Entry<String,String>> entries = paramMap.entrySet(); 
		
		for(Entry<String,String> entry : entries) { 
			paramList.add(new BasicNameValuePair(entry.getKey(), entry.getValue())); 
			
		} 
		return paramList; 
		    
	} 
	
	// 결제취소 
	public int cancelPayment(String token, String mid) { 
		HttpClient client = HttpClientBuilder.create().build(); 
		HttpPost post = new HttpPost(IMPORT_CANCEL_URL); 
		Map<String, String> map = new HashMap<String, String>(); 
		post.setHeader("Authorization", token); 
		map.put("merchant_uid", mid); String asd = ""; 
		
		try {
			post.setEntity(new UrlEncodedFormEntity(convertParameter(map))); 
			HttpResponse res = client.execute(post); 
			ObjectMapper mapper = new ObjectMapper(); 
			String enty = EntityUtils.toString(res.getEntity()); 
			JsonNode rootNode = mapper.readTree(enty); 
			asd = rootNode.get("response").asText(); 
			
		} catch (Exception e) { 
			e.printStackTrace(); 
			
		} 
		
		if (asd.equals("null")) { 
			System.err.println("환불실패"); 
			return -1; 
			
		} else { 
			System.err.println("환불성공"); 
			
			return 1; 
			
		} 
		
	} 
	
	// 가맹점 기준 - 가맹점의 merchant_id로 아임포트 결제정보를 조회해서 결제금액을 뽑아주는 함수
	public String getAmount(String token, String mId) { 
		String amount = ""; 
		HttpClient client = HttpClientBuilder.create().build(); 
		HttpGet get = new HttpGet(IMPORT_PAYMENTINFO_URL + mId + "/paid"); 
		get.setHeader("Authorization", token); 
		try { 
			HttpResponse res = client.execute(get);
			ObjectMapper mapper = new ObjectMapper(); 
			String body = EntityUtils.toString(res.getEntity()); 
			JsonNode rootNode = mapper.readTree(body); 
			JsonNode resNode = rootNode.get("response"); 
			amount = resNode.get("amount").asText(); 
			
		} catch (Exception e) { 
			e.printStackTrace(); 
			
		} 
		
		return amount; 
		
	} 

	//결제 정보 확인하기. 결제상태가 확인되면 db에 결제내역 테이블 조회를 위한 데이터를 등록할 수 있도록 결과를 반환함
	//return 값이 -1일경우 일치하는 결제 정보 없음 / 1일경우 일치하는 결제 정보 있음
	public int comparePaymentData(String token, String imp_uid) {
		HttpClient client = HttpClientBuilder.create().build(); 
		HttpPost post = new HttpPost(IMPORT_PAYCHECK_URL + imp_uid); 
		Map<String, String> map = new HashMap<String, String>(); 
		post.setHeader("Authorization", token); 
		map.put("imp_uid", imp_uid); 
		String asd = ""; 
		
		try {
			post.setEntity(new UrlEncodedFormEntity(convertParameter(map))); 
			HttpResponse res = client.execute(post); 
			ObjectMapper mapper = new ObjectMapper(); 
			String enty = EntityUtils.toString(res.getEntity()); 
			JsonNode rootNode = mapper.readTree(enty); 
			asd = rootNode.get("response").asText(); 
			
		} catch (Exception e) { 
			e.printStackTrace(); 
			
		} 
		
		if (asd.equals("null")) { 
			log.info("결제 정보 확인되지 않음");
			return -1; 
		} else { 
			log.info("결제정보 확인됨"); 
			return 1; 
		} 
	}
	
}

