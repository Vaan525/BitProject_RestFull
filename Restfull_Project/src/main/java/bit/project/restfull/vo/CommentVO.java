package bit.project.restfull.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CommentVO {
	private int comments_numbers;
	private int board_numbers;
	private String contents;
	private String dates;
	private String member_id;
}
