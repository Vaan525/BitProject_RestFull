package bit.project.restfull.page;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	//����¡ ó�� �Ҷ� �ʿ��� ������
	private int startPage;//ȭ�鿡 �������� ������ ���۹�ȣ
	private int endPage; //ȭ�鿡 �������� ����ȣ
	// ��) startPage:1 endPage:10 ====> 1 2 3 4 5 6 7 8 9 10
	// ��) startPage:1 endPage:5 ====> 1 2 3 4 5
	// ��) startPage:11 endPage:20 ====> 11 12 13 14 15 16 17 18 19 20
	
	private boolean prev, next; //������ �������� �̵������� ��ũ ǥ��
	
	// private boolean prev;// '<<'��ư ��¿���
	// private boolean next;// '>>'��ư ��¿���
	
	private int total; //��ü �Խñ� ��
	private Criteria cri;
	
	public PageDTO(Criteria cri, int total) {	
	    this.cri = cri;
	    this.total = total; //��ü ����Ÿ ��
	    
	    this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;
	    // ���������� ������ ���� ���������� ���� ����
	    //cri.getPageNum() = 3;
	    //�ϴ�  ����¡ �ٿ� ������ ����¡�� ����
	    // ���� : ceil(3 / 10.0) * 10 => 1 * 10 = 10����
	    // 1. (3/10.0) = 0.3
	 	// 2. ceil(0.3) = 1
	 	// 3. 1* 10 = 10
	 	// 1 2 3 4 5 6 7 8 9 10
	    
	    // cri.getPageNum() = 13;
	    // �ϴ� ����¡ �ٿ� ������ ����¡�� ���� == 10��
	    // ���� : ceil(13/10.0) * 10 => 2 * 10 = 20����
	    // 11 12 13 14 15 16 17 18 19 20
	    this.startPage = this.endPage - 9;
	    
	    //Total�� ���� endPage�� ����
	    //10���� �����ִ� ��� ��ü ������ ���� 80����� �����ϸ� ����ȣ�� 10�� �ƴ� 8�� ��
	    int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));
	    
	    //total = 512
	    //cri.getAmount()
	    //ceil(512 / 10.0) = 52
	    // 51.2�ǰ���� �ø� => 51������ ������ �� ȭ��� 10���� �Խù��� ���
	    ///������ 52���������� 0.2�� �ش��ϴ� 2���� �Խù��� ���
	    if (realEnd <= this.endPage) {
	      this.endPage = realEnd;
	    }
	    
	    //���۹�ȣ�� 1���� ū��� ����
	    this.prev = this.startPage > 1; 
	    //realEnd�� ����ȣ(endPage)���� ū ��쿡�� ����
	    this.next = this.endPage < realEnd;
		 
	}
	
	public String makeQuery(int page) {
		UriComponents uriComponentsBuilder = UriComponentsBuilder.newInstance().queryParam("pageNum", page) // pageNum = 3
				.queryParam("amount", cri.getAmount()) // pageNum=3&amount=10
				.build(); // ?pageNum=3&amount=10
		return uriComponentsBuilder.toUriString(); // ?pageNum=3&amount=10 ���� 
	}
	
	  

}	