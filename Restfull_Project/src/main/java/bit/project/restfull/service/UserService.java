package bit.project.restfull.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import bit.project.restfull.vo.PagingVO;
import bit.project.restfull.vo.UserVO;

public interface UserService {
	
	public void addUser(UserVO userVO); 
	
	public void modifyUser(UserVO userVO);
		
	public void userDelete(UserVO userVO);
	
	public String getEncodePassword(String pw);
	
	public int getUser(String member_id);
	
	public void adminModifyUser(UserVO userVO);
	
	public int countMember();
	
	public List<UserVO> userList(PagingVO pagingVO);

	public UserVO getUserVO(String member_id);
	
	public String findID(HttpServletResponse response, String email) throws Exception;
	
	public void sendMail(UserVO userVO, String dic);
	
	public int idChk(String member_id);

	public void findPW(HttpServletResponse response, UserVO userVO) throws Exception;

	public UserVO getUserByIdandAutho(String id, String login_type);
	
	
}
