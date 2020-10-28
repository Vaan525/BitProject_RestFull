package bit.project.restfull.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import bit.project.restfull.mapper.LoginMapper;
import bit.project.restfull.mapper.SnsMapper;
import bit.project.restfull.vo.UserVO;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@NoArgsConstructor
@AllArgsConstructor
public class KakaoService {
	
	@Autowired
	private LoginMapper loginMapper;
	
	@Autowired
	private BCryptPasswordEncoder passEncoder; 
	
	@Autowired
	private SnsMapper snsMapper;
	
	public String getAccessToken(String authorize_code) {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";

		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=8c8d010971d8629ec3188f9ed097f73b"); // ������ �߱޹��� key
			sb.append("&redirect_uri=http://localhost:8282/restfull/kakaologin"); // ������ ������ ���� ���
			sb.append("&code=" + authorize_code);
			bw.write(sb.toString());
			bw.flush();

			int responseCode = conn.getResponseCode();
			log.info("responseCode : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			log.info("response body : " + result);

			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			access_Token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
			log.info("access_token : " + access_Token);
			log.info("refresh_token : " + refresh_Token);

			br.close();
			bw.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return access_Token;
	}

	
	/* īī�� ���� ������ ���� */ 
	  public HashMap<String, String> getUserInfo (String access_Token) {

          // 
          HashMap<String, String> userInfo = new HashMap<>();
          String reqURL = "https://kapi.kakao.com/v2/user/me";
          try {
              URL url = new URL(reqURL);
              HttpURLConnection conn = (HttpURLConnection) url.openConnection();
              conn.setRequestMethod("POST");

              //    ��û�� �ʿ��� Header�� ���Ե� ����
              conn.setRequestProperty("Authorization", "Bearer " + access_Token);

              
              int responseCode = conn.getResponseCode();
              log.info("responseCode : " + responseCode);

              BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));

              String line = "";
              String result = "";

              while ((line = br.readLine()) != null) {
                  result += line;
              }
              
              log.info("response body : " + result);
              
              String decoded=new String(result);
              
              log.info(decoded);
              JsonParser parser = new JsonParser();
              JsonElement element = parser.parse(result);

              
              
              JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();

              String sns_id =  element.getAsJsonObject().get("id").getAsString();
              String sns_nickname = properties.getAsJsonObject().get("nickname").getAsString();
             

              userInfo.put("sns_nickname", sns_nickname);
              userInfo.put("sns_id", sns_id);
              
              

          } catch (IOException e) {
              // TODO Auto-generated catch block
              e.printStackTrace();
          }

          return userInfo;
      }
	  
	  
	  public void addSNS(HashMap<String, String> userInfo) {
		  UserVO userVO = new UserVO();
		  
		  log.info(userInfo.get("sns_id")+"@k");
		  log.info(userInfo.get("sns_id"));
		  log.info(userInfo.get("sns_nickname"));

		  
		  //insertID부분
		  userVO.setMember_id(userInfo.get("sns_id")+"@k");
		  
		  String pw = "null"; 
		  String encode = passEncoder.encode(pw);
		  userVO.setPw(encode);
		  
		  userVO.setName(userInfo.get("sns_nickname"));
		  userVO.setGrade_name("뚜벅이");
		  userVO.setAuthority_name("ROLE_USER");
		  
		  
		  log.info(userVO.getPw());
		  log.info(userVO.getAuthority_name());
		  log.info(userVO.getAuthorities());
		  
		  String member_id = userVO.getMember_id();
		   
		  if(loginMapper.idChk(member_id)== 0) {
		  	  snsMapper.insertID(userVO);
			  log.info("카카오 값 넣기 성공");
		  }else {
			  log.info("member_id :" + member_id + "이미 있음.");
		  }

		  
	  }
	  
	  public void kakaoLogout(String access_Token) {
		    String reqURL = "https://kapi.kakao.com/v1/user/logout";
		    try {
		        URL url = new URL(reqURL);
		        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		        conn.setRequestMethod("POST");
		        conn.setRequestProperty("Authorization", "Bearer " + access_Token);
		        
		        int responseCode = conn.getResponseCode();
		        log.info("responseCode : " + responseCode);
		        
		        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		        
		        String result = "";
		        String line = "";
		        
		        while ((line = br.readLine()) != null) {
		            result += line;
		        }
		        log.info(result);
		    } catch (IOException e) {
		        // TODO Auto-generated catch block
		        e.printStackTrace();
		    }
		}


}