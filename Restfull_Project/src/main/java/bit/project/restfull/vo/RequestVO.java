package bit.project.restfull.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class RequestVO {
	private String request_numbers;//	REQUEST_NUMBERS	NUMBER(10,0)
	private Timestamp dates;		//	DATES	DATE
	private String imp_uid;		//	IMP_UID	VARCHAR2(100 BYTE)
	private String member_id;		//	MEMBER_ID	VARCHAR2(100 BYTE)
	private int goods_numbers;		//	GOODS_NUMBERS	NUMBER(10,0)
	private String destination_numbers;		//	DESTINATION_NAME	VARCHAR2(255 BYTE)
	private int cancel;		//	CANCELYN	NUMBER
	private int price;
	private String merchant_uid; // MERCHANT_UID;
	private String productName;
	private int amount;
	private String destination_name;
}
