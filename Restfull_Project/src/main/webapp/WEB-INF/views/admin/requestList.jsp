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
	
	<div class="text-center"><h2>여행지 및 상품 관리</h2></div>

 <!-- Blog Section Begin -->
    <section class="blog-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-6 col-sm-8 order-2 order-lg-1">
                    <div class="blog-sidebar">
                        <div class="blog-catagory">
                            <h4>관리자페이지</h4>
                            <ul>
                                <li><a href="<c:url value="/admin/userList" />">유저 관리</a></li>
                                <li><a href="<c:url value="/admin/notice" />">공지사항 및 이벤트 관리</a></li>
                                <li><a href="<c:url value="/admin/qnas" />">문의 및 신고 답변</a></li>
                                <li><a href="<c:url value="/admin/dest" />">여행지 및 상품 관리</a></li>
                            	<li><a href="<c:url value="/admin/requestList" />">상품 주문내역 관리</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <!--관리자페이지 table start-->
                <div class="col-lg-9 order-2">
                    <div class="row">
                        <div class="col-lg-12 col-sm-12">
                            <div class="notice-table">
								
                                <table>
									<tr>
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
										<td><a href="${pageContext.request.contextPath}/user/goodsView?goods_numbers=${vo.goods_numbers}">${vo.productName}</a></td>
										<td>${vo.price}</td>
										<td>${vo.dates}</td>
										<td>
											<c:set var="cancelyn" value="${vo.cancel}" />
											<c:choose>
											    <c:when test="${cancelyn == 0}">
													취소미신청
												</c:when>
											    <c:when test="${cancelyn == 1}">
											    	취소처리중
											    </c:when>
											</c:choose>
										</td>
									</tr>
							</c:forEach>
						</table>
							<button type="button" onclick="history.go(-1);" class="gobackbtn">돌아가기</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!--관리자페이지 table end-->
			</div>
		</div>
	</section>
	
	
	
	
	<%@ include file="/WEB-INF/include/js-footer.jsp"%>
</body>
</html>