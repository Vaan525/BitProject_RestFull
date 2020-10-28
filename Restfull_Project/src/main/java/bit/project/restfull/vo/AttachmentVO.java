package bit.project.restfull.vo;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class AttachmentVO {
	private int board_numbers;
	private String filename;
	private String filedirectory;
	private int filesize;
}
