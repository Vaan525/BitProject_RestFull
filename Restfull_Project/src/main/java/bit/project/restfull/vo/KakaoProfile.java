package bit.project.restfull.vo;


import lombok.Data;

@Data
public class KakaoProfile {
	
	public Integer id;
	public String connected_at;
	public Properties properties;
	public KakaoAccount kakao_account;
	
	@Data
	public class Properties {

		public String nickname;
		public String gender;
		public String birthday;
		public String profile_image;
		public String thumbnail_image;
		public String email;

	}
	
	@Data
	public class KakaoAccount {
		public Boolean profile_needs_agreement;
		public Profile profile;
		
		public Boolean has_email;
		public Boolean email_needs_agreement;
		public Boolean is_email_valid;
		public Boolean is_email_verified;
		public String email;
		
		public Boolean has_gender;
		public Boolean gender_needs_agreement;
		public Boolean is_gender_valid;
		public Boolean is_gender_verified;
		public String gender;
		
		public Boolean has_birthday;
		public Boolean birthday_needs_agreement;
		public Boolean is_birthday_valid;
		public Boolean is_birthday_verified;
		public String birthday;
		
		@Data
		public class Profile {

			public String nickname;
			public String gender;
			public String birthday;
			public String thumbnail_image_url;
			public String profile_image_url;

		}

	}

}