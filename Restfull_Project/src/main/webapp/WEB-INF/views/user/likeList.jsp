<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=fawtmt0h7b"></script>
	<script type="text/javascript" src="resources/js/MarkerClustering.js"></script>

</head>
<body>
<%@ include file="/WEB-INF/include/js-header.jsp"%>
	<h2 class="text-center">좋아요 한 글 목록 페이지 입니다.</h2>
	<hr>
	    <section class="blog-section spad">
	        <div class="container">
	            <div class="row">
	                <div class="col-sm-3 order-1">
	                    <div class="blog-sidebar">
							<div class="blog-catagory menu-background">
						        <h4>마이페이지</h4>
						        <ul>
						            <li><p>[<a href="<c:url value="userModify" />">개인정보 수정</a>]</p></li>
						            <li><p>[<a href="myList?member_id=<sec:authentication property="principal.user.member_id"/>">내 게시글 보기</a>]</p></li>
						            <li style="background-color: #8a93c0;"><p>[<a href="myLikeList?member_id=<sec:authentication property="principal.user.member_id"/>">좋아요 한 글 목록</a>]</p></li>
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
			       		<div class="notice-table">
							<table id="list-table">
								<tr class="first-list">
									<td>대표사진</td>
									<td>게시글 제목</td>
									<td>위치</td>
									<td>게시 날짜</td>
								</tr>
							        <!-- 게시글 목록 -->
								<c:forEach items="${boardlist}" var="vo">
								    <a href="${pageContext.request.contextPath}/contentView?board_numbers=${vo.board_numbers}" class="thumbnail">
											<tr>
										<div  class="caption">
									      		<td> <img src="${vo.thumbnail }"/></td>
								                <td> <a href="${pageContext.request.contextPath}/contentView?board_numbers=${vo.board_numbers}" class="thumbnail">${vo.title}</td>
								                <td> ${vo.location}</td>
								                <td> ${vo.destinationVO.jibunaddress}</td>
										</div>
											</tr>
									</a>
								</c:forEach>
							</table>
						</div>
				    </div>
		        </div>
	        </div>
		</section>
<%@ include file="/WEB-INF/include/js-footer.jsp"%>
</body>
</html>