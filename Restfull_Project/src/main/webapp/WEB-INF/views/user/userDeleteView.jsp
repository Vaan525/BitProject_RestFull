<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<html>
	<head>
		<title>회원탈퇴</title>
		
	</head>
	<body>
	<%@ include file="/WEB-INF/include/js-header.jsp"%>
	
    <script>
    $(function(){
		// 취소
		$("#cancel").on("click", function(){
			location.href = "${pageContext.request.contextPath}/user/userModify";
		});

		$("#delete").on("click", function() {
			if($("#pw").val()==""){
				alert("비밀번호를 입력해주세요.");
				$("#pw").focus();
				return false;
			}
			
			$.ajax({
				url : "${pageContext.request.contextPath}/user/userDelete",
				async: true,
				type : "POST",
				dataType : "json",
				contentType: "application/json",
				data : JSON.stringify({pw: $('#pw').val()}),
				success: function(data) {
					console.log(data);
					const isSuccess = data.statusCode === 200;
					if(isSuccess){
						alert("회원 탈퇴 성공");

						location.href = "${pageContext.request.contextPath}/";

					}else{
						alert("비밀번호를 다시 입력해 주세요");
					}
				},
				error: function(err) {
					alert("알수 없는 에러 발생");
				}
			})

		})
	});
	</script>
	
		<div class="text-center"><h2>회원탈퇴</h2></div>
		<hr>
		    <section class="blog-section spad">
		        <div class="container">
		            <div class="row">
		                <div class="col-lg-3 col-md-6 col-sm-8 order-2 order-lg-1">
		                    <div class="blog-sidebar">
								<div class="blog-catagory menu-background">
							        <h4>마이페이지</h4>
							        <ul>
							            <li><p>[<a href="<c:url value="userModify" />">개인정보 수정</a>]</p></li>
							            <li><p>[<a href="myList?member_id=<sec:authentication property="principal.user.member_id"/>">내 게시글 보기</a>]</p></li>
							            <li><p>[<a href="myLikeList?member_id=<sec:authentication property="principal.user.member_id"/>">좋아요 한 글 목록</a>]</p></li>
							            <li><p>[<a href="myCourseList?member_id=<sec:authentication property="principal.user.member_id"/>">내 여행코스 보기</a>]</p></li>
							            <li><p>[<a href="paymentList?member_id=<sec:authentication property="principal.user.member_id"/>">내 결제내역 보기</a>]</p></li>
							            <li><p>[<a href="reportList?member_id=<sec:authentication property="principal.user.member_id"/>">내 신고내역 보기</a>]</p></li>
							            <li><p>[<a href="qnaList?member_id=<sec:authentication property="principal.user.member_id"/>">내 문의내역 보기</a>]</p></li>
							            <li style="background-color: #8a93c0;"><p>[<a href="<c:url value="userDeleteView" />">회원탈퇴</a>]</p></li>
							        </ul>
						        </div>
					        </div>
				        </div>
				        
				        <div class="col-lg-9 order-1">
				        	<div class="row">
                        		<div class="col-lg-12 col-sm-12">
									<div class="outUser">
										<div class="group-input">
											<sec:authentication var="principal" property="principal"/>
											<div class="USERID">
												<label for="userId">아이디</label>
												<input type="text" name="member_id" value="<sec:authentication property="principal.user.member_id"/>" readonly/>
											</div>
										</div>
										
										<div class="group-input">
											<div class="USERPW">
												<label class="control-label" for="userPass">비밀번호</label>
												<input class="l" type="password" id="pw" name="pw" placeholder="비밀번호를 입력해주세요"/>
											</div>
										</div>
										
										<div class="group-input">
											<div class="USERNAME">
												<label class="control-label" for="userName">이름</label>
												<input class="" type="text" id="name" value="<sec:authentication property="principal.user.name"/>" readonly="readonly"/>
											</div>
										</div>
										
										
										<button class="out-btn" type="button" id="delete">회원탈퇴</button>
										<button class="out-btn" type="button" id="cancel">취소</button>	
									</div>
								</div>
							</div>
					    </div>
	                </div>
	            </div>
			</section>
		<%@ include file="/WEB-INF/include/js-footer.jsp"%>
	</body>
</html>