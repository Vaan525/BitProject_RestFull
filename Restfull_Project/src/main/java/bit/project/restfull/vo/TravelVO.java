package bit.project.restfull.vo;

import java.sql.Timestamp;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class TravelVO {
	private int travel_numbers;	//TRAVEL_NUMBERS	NUMBER(10,0)
	private String member_id;	//MEMBER_ID	VARCHAR2(100 BYTE)
	private String tcContents;	//TCCONTENTS	VARCHAR2(1000 BYTE)
	private String tcAlias;		//TCALIAS	VARCHAR2(100 BYTE)
	private Timestamp dates;	//DATES	DATE
	private String serialNum;	//SERIALNUM	VARCHAR2(20 BYTE)
}
