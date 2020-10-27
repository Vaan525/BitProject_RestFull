<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/WEB-INF/include/js-header.jsp"%>
	<h2 class="text-center">내 결제내역 페이지 입니다.</h2>
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
						            <li><p>[<a href="myLikeList?member_id=<sec:authentication property="principal.user.member_id"/>">좋아요 한 글 목록</a>]</p></li>
						            <li><p>[<a href="myCourseList?member_id=<sec:authentication property="principal.user.member_id"/>">내 여행코스 보기</a>]</p></li>
						            <li style="background-color: #8a93c0;"><p>[<a href="paymentList?member_id=<sec:authentication property="principal.user.member_id"/>">내 결제내역 보기</a>]</p></li>
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
									<td>결제 번호</td>
									<td>주문 번호</td>
									<td>주문자 id</td>
									<td>여행지명</td>
									<td>상품명</td>
									<td>상품가격</td>
									<td>결제 날짜</td>
									<td>취소 여부</td>
								</tr>
							<c:forEach items="${list}" var="vo">
							<tr>
								<td>${vo.imp_uid}</td>
								<td>${vo.request_numbers}</td>
								<td>${vo.member_id}</td>
								<td>${vo.destination_name}</td>
								<td><a href="goodsView?goods_numbers=${vo.goods_numbers}">${vo.productName}</a></td>
								<td>${vo.price}</td>
								<td>${vo.dates}</td>
								<td>
									<c:set var="cancelyn" value="${vo.cancel}" />
									<c:choose>
									    <c:when test="${cancelyn == 0}">
											취소미신청
										</c:when>
									    <c:when test="${cancelyn == 1}">
									    	처리중
									    </c:when>
									    <c:otherwise>
									    	취소완료
									    </c:otherwise>
									</c:choose>
								</td>
							</tr>
							</c:forEach>
						</table>
						
				    </div>
		        </div>
	        </div>
		</section>
<%@ include file="/WEB-INF/include/js-footer.jsp"%>
	
</body>
</html>
