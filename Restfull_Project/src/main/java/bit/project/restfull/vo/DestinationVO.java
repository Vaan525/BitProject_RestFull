package bit.project.restfull.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class DestinationVO {
	private int destination_numbers;
	private String jibunaddress;
	private String doroaddress;
	private String details;
	private String lat;	
	private String lng;
	private int sigungu_code;
	private String destination_name;
	private SidoguVO sidoguVO;
}
