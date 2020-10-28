package bit.project.restfull.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import bit.project.restfull.vo.PagingVO;
import bit.project.restfull.vo.UserVO;

@Mapper
public interface LoginMapper {
	
	@Insert("insert into member(member_id, pw, name, birth, gender, phone, email, enabled, grade_name, authority_name, login_type) values(#{member_id}, #{pw}, #{name}, #{birth ,jdbcType=DATE}, #{gender}, #{phone}, #{email,jdbcType=VARCHAR}, #{enabled}, #{grade_name}, #{authority_name}, #{login_type})")
	public void insertUser(UserVO userVO);

	@Select("select * from member where member_id = #{member_id}")
	public UserVO readUser(String member_id);
	
	@Delete("delete from member where member_id = #{member_id}")
	public void delMember(String member_id);
	
	/* 아이디 중복 체크 */
	@Select("select count(*) from member where member_id = #{member_id}")
	public int idChk(String member_id);
	
	/* 관리자 권한 개인정보 수정 */
	@Update("update member set gender = #{gender}, email = #{email}, phone = #{phone}, grade_name = #{grade_name}, authority_name = #{authority_name} where member_id = #{member_id}")
	public void adminModifyUser(UserVO userVO);
	
	/* 유저 권한 개인정보 수정 */ 
	@Update("update member set pw = #{pw}, email = #{email}, phone = #{phone} where member_id = #{member_id}")
	public void modifyUser(UserVO userVO);
	
	@Select("select * from member where member_id = #{member_id}")
	public UserVO getUserVO(String member_id);
	
	@Select("select count(*) from member")
	public int countMember();

	@Select("SELECT * FROM (SELECT ROWNUM RN, A.* FROM "
			+ "(SELECT * FROM member ORDER BY member_id DESC) A )"
			+ "WHERE RN BETWEEN #{start} AND #{end}")
	public List<UserVO> userList(PagingVO pagingVO);
	
	/* 아이디 찾기 */
	@Select("select member_id from member where email = #{email}")
	public String findID(String email);
		
	/* 비밀번호 찾기 */
	@Update("update member set pw = #{pw} where member_id = #{member_id}")
	public void findPW(UserVO userVO);
	
	/* kakao social login */
	@Select("select * from member where id = #{id}")
	public UserVO KreadUser(String id);
	
	@Select("select * from member where login_Type = #{login_Type}")
	public UserVO KreadUserLoginType(String login_Type);
	
	@Select("select * from member where member_id = #{member_id} and login_type = #{login_type}")
	public UserVO KreadUserByIdandAutho(@Param("member_id")String member_id,@Param("login_type")String login_type);
}
