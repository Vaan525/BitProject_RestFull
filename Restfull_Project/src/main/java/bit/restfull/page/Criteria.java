package bit.restfull.page;

import lombok.*;
import lombok.extern.log4j.Log4j;

@Getter
@Setter
@Log4j
public class Criteria {

	
	private int pageNum;
	// ������ ��ȣ
	private int amount;
	// �� �������� ������ ����
	
	public Criteria() {
		this(1, 10);
		// �������� 10��
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	
	
}