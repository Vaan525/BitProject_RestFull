package bit.project.restfull.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import bit.project.restfull.vo.CommentVO;


@Mapper
public interface CommentMapper {
	
	/* 댓글 달기 */
	@Insert("insert into comments (comments_numbers, board_numbers, contents, dates, member_id) values (comments_seq.nextval, #{board_numbers}, #{contents}, sysdate, #{member_id})") 
	public void insertComment(CommentVO commentVO);

	/* 댓글 목록 가져오기 */
	@Select("select * from comments where board_numbers = #{board_numbers} order by comments_numbers desc")
	public List<CommentVO> commentList(@Param("board_numbers")int board_numbers);
	
	/* 댓글 삭제 */
	@Delete("delete from comments where comments_numbers = #{comments_numbers}")
	public void delComment(int comments_numbers);
	
}
