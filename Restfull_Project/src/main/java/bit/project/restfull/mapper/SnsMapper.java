package bit.project.restfull.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import bit.project.restfull.vo.UserVO;

@Mapper
public interface SnsMapper {
	
	@Insert("insert into MEMBER(member_id, pw, name, grade_name, authority_name, login_type) values(#{member_id}, #{pw}, #{name}, #{grade_name}, #{authority_name}, #{login_type})")
	public void insertID(UserVO userVO);
	
}