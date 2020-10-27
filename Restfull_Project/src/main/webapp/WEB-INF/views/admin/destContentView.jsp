<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <title>Insert title here</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<%@ include file="/WEB-INF/include/js-header.jsp"%>
	<div class="text-center"><h2>여행지 상세정보</h2></div>

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
                <div class="col-lg-9 order-1 order-lg-2">
                    <div class="row">
                        <div class="admin col-lg-12 col-sm-12">
                        	<div class="dest_info">
                        		<div class="link">
									<a href="modify?destination_numbers=${contentView.destination_numbers}">수정</a>
									<a href="delete?destination_numbers=${contentView.destination_numbers}">삭제</a>
								</div>
								
                        		<h4>여행지정보</h4>
                        		<div class="board-contents">
                        			<div class="name">여행지명 : ${contentView.destination_name}</div><br/>
									<input type="hidden" name="destination_numbers" value="${contentView.destination_numbers}" />
									<div class="local">지역 구분 : ${contentView.sidoguVO.sidoName}</div><br/>
									<div class="local">지번 주소 : ${contentView.jibunaddress}</div><br/>
									<div class="local">도로명 주소 : ${contentView.doroaddress}</div><br/>
									<div class="local">GPS-X : ${contentView.lat}</div><br/>
									<div class="local">GPS-Y : ${contentView.lng}</div><br/>
								</div>
                        	</div>
                        	
                        	<hr/>
	                        
	                        <div class="related_goods">
	                            <h4>관련상품</h4>
								<a href="${contentView.destination_numbers}/goods/writeView">상품등록</a>
	                            <div class="notice-table">
	                                <table id="list-table">
										<tr class="first-list">
					                        <td>상품명</td>
					                        <td>판매업자</td>
					                        <td>가격</td>
					                        <td>재고수량</td>
					                        <td>판매상태</td>
					                        <td>판매 시작일</td>
					                        <td>판매 종료일</td>
										</tr>
										<c:forEach items="${goodsList}" var="vo">
											<tr class="noticeable">
						                        <td><a href="${pageContext.request.contextPath}/admin/goods/contentView?goods_numbers=${vo.goods_numbers}">${vo.name}</a></td>
						                        <td>${vo.seller}</td>
						                        <td>${vo.price}</td>
						                        <td>${vo.amount}</td>
						                        <td>
						                        	<c:if test="${vo.status == 1}">판매중</c:if>
						                        	<c:if test="${vo.status == 0}">판매중단</c:if>
						                        </td>
						                        <td>${vo.sellstart}</td>
						                        <td>${vo.sellend}</td>
											</tr>
										</c:forEach>	
									</table>
									<button type="button" onclick="history.go(-1);" class="gobackbtn">돌아가기</button>
	                            </div>
	                         </div>
                            
                        </div>
                        
                    </div>
                </div>
                <!--관리자페이지 table end-->

			</div>
		</div>
	</section>
	
	
<!-- 	<h3><button onclick="history.go(-1);">돌아가기</button></h3> -->
	
<%@ include file="/WEB-INF/include/js-footer.jsp"%>
   
</body>
</html>