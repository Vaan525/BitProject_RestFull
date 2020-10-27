<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>사용자 홈</title>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script>
	    $(function() {
	    	$("#cancel").on("click", function(){
	
				location.href = "/board/home";
	
			});
			if($("#modifyForm").submit(function() {
				alert("수정하시겠습니까?");
				if($("#pw").val() !== $("#pw2").val()){
					alert("비밀번호가 다릅니다.");
					$("#pw").val("").focus();
					$("#pw2").val("");
					return false;
				}else if ($("#pw").val().length < 8) {
					alert("비밀번호는 8자 이상으로 설정해야 합니다.");
					$("#pw").val("").focus();
					return false;
				}else if($.trim($("#pw").val()) !== $("#pw").val()) {
					alert("공백은 입력이 불가능합니다.");
					return false;
				}
				else if($("#member_id").val()==""){
					alert("아이디를 입력해주세요.");
					$("#member_id").focus();
					return false;
				}
				else if($("#pw").val()==""){
					alert("비밀번호를 입력해주세요.");
					$("#pw").focus();
					return false;
				}
				else if($("#name").val()==""){
					alert("성명을 입력해주세요.");
					$("#name").focus();
					return false;
				}
				else if($("#birth").val()==""){
					alert("생년월일을 입력해주세요.");
					$("#name").focus();
					return false;
				}
				else if($("#gender").val()==""){
					alert("성별을 입력해주세요.");
					$("#name").focus();
					return false;
				}
				else if($("#phone").val()==""){
					alert("연락처을 입력해주세요.");
					$("#name").focus();
					return false;
				}
				else if($("#email").val()==""){
					alert("이메일을 입력해주세요.");
					$("#name").focus();
					return false;
				}
				
				
			}));
			
		});
	    </script>
	    <script>
	    function onlyNumber(){
	
	        if((event.keyCode<48)||(event.keyCode>57))
	
	           event.returnValue=false;
	
		}
	
	    </script>
</head>

<body>
	<%@ include file="/WEB-INF/include/js-header.jsp"%>
	<h2 class="text-center">개인정보 수정 페이지 입니다.</h2>
	<hr>
	    <section class="blog-section spad">
	        <div class="container">
	            <div class="row">
	                
	                <div class="col-sm-3 order-1">
	                    <div class="blog-sidebar">
							<div class="blog-catagory menu-background">
						        <h4>마이페이지</h4>
						        <ul>
						            <li style="background-color: #8a93c0;"><p>[<a href="<c:url value="userModify" />">개인정보 수정</a>]</p></li>
						            <li><p>[<a href="myList?member_id=<sec:authentication property="principal.user.member_id"/>">내 게시글 보기</a>]</p></li>
						            <li><p>[<a href="myLikeList?member_id=<sec:authentication property="principal.user.member_id"/>">좋아요 한 글 목록</a>]</p></li>
						            <li><p>[<a href="myCourseList?member_id=<sec:authentication property="principal.user.member_id"/>">내 여행코스 보기</a>]</p></li>
						            <li><p>[<a href="paymentList?member_id=<sec:authentication property="principal.user.member_id"/>">내 결제내역 보기</a>]</p></li>
						            <li><p>[<a href="reportList?member_id=<sec:authentication property="principal.user.member_id"/>">내 신고내역 보기</a>]</p></li>
						            <li><p>[<a href="qnaList?member_id=<sec:authentication property="principal.user.member_id"/>">내 문의내역 보기</a>]</p></li>
						            <li><p>[<a href="<c:url value="userDeleteView" />">회원탈퇴</a>]</p></li>
						        </ul>
					        </div>
				        </div>
			        </div>
			       
			        <div class="col-sm-9 order-2">
						
						 <fieldset>
							<form:form id="modifyForm" action="update" method="POST">
								<div class="notice-table">
								 <table id="list-table">
									  <tr>
										   <td class=" user-modify-line">아이디</td>
										   <td><input class="input" type="text"  id="member_id" name="member_id"  value="<sec:authentication property="principal.user.member_id"/>" readOnly/></td>
									  </tr>
									
									  <tr>
										   <td class="user-modify-line">패스워드</td>
										   <td>
										   	 	<input class="input" type="password"  id="pw" name="pw" placeholder="패스워드 입력(8자 이상)"/><br />
										   </td>
									  </tr>
									
									  <tr>
									   	   <td class="user-modify-line">패스워드 확인</td>
										   <td>
										    	<input class="input" type="password"  id="pw2" name="password_chk" placeholder="패스워드 확인(8자 이상)" /><br />
										   </td>
									  </tr>
									
									  <tr>
										   <td class="user-modify-line">이름</td>
										   <td><input class="input" type="text"  id="name" placeholder="이름" value="<sec:authentication property="principal.user.name"/>" readOnly/><br /></td>
									  </tr>
									  
									  <tr>
										   <td class="user-modify-line">휴대폰</td>
										   <td><input class="input" type="text" id="phone" name="phone" placeholder="PHONE" value="<sec:authentication property="principal.user.phone"/>" required onkeypress="onlyNumber()"/></td>
									  </tr>
									  
									  <tr>
										   <td class="user-modify-line">이메일</td>
										   <td><input class="input" type="email" id="email" placeholder="EMAIL" name="email" value="<sec:authentication property="principal.user.email"/>"/><br/>
										   </td>
									  </tr>
									  <tr>
										   <td colspan="2">
											    <button type="submit" class="button3 user-modify-btn " >수정완료</button>
											    <a href="userHome" id="home"><button type="button" class="button3 user-modify-btn">돌아가기</button></a>
											   
										   </td>
									  </tr>
									  
								 </table>
								</div>
							 </form:form>
						 </fieldset>
					 </div>
			    </div>
	        </div>
		</section>
	<%@ include file="/WEB-INF/include/js-footer.jsp"%>
</body>
</html>