package bit.restfull.vo;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class GoodsVO {
	private int goods_numbers; //GOODS_NUMBERS
	private int destination_numbers;
	private String destination_name;
	private String name; //NAME
	private int price; //PRICE
	private int amount; //AMOUNT
	private String status; //STATUS
	private String sellstart; //SELLSTART
	private String sellend; //SELLEND
	private String seller; //SELLER
}
