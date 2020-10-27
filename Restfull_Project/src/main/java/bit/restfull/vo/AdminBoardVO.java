package bit.restfull.vo;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class AdminBoardVO {
	private int board_numbers;
	private String title;	
	private String contents;
	private String hit;
	private String dates;
	private String member_id;
	private int boardlist_numbers;
	private String boardlistName;
	private AttachmentVO attachmentVO;	
	private String thumbnail;
	
}