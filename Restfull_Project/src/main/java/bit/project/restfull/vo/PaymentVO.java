package bit.project.restfull.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class PaymentVO {

	private int goods_numbers;
	private String name;
	private int price;
	private int amount;
	private String status;
	private String sellstart;
	private String sellend;
	
	private String destination_name;
	
	public PaymentVO() {
		this(1, "name", 0, 0, "status", "sellstart", "sellend", "destination_name");
	}
	
	
}
