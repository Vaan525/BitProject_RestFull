<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <title>RestFuLL | 관리자</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
<body>
<%@ include file="/WEB-INF/include/js-header.jsp"%>
	<div class="text-center"><h2>상품주문내역 관리</h2></div>

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

				  
                <!--관리자페이지 여행지등록table start-->
                <div class="col-lg-9 order-1 order-lg-2">
                    <div class="row">
                        <div class="admin col-lg-12 col-sm-12">
                        	<div class="notice_write">
					         	<div class="dest_info">
					         		<div class="link">
										<a href="modify?goods_numbers=${contentView.goods_numbers}">수정</a>
										<a href="${pageContext.request.contextPath}/admin/dest/${contentView.destination_numbers}/goods/delete?goods_numbers=${contentView.goods_numbers}">삭제</a>
									</div>
						            <h4>상품 정보</h4>
						            <input type="hidden" name="goods_numbers" value="${contentView.goods_numbers}">
						            <div class="board-contents">
						            	<div class="goods">판매업자 : ${contentView.seller}</div>
						            	<div class="goods">상품명 : ${contentView.name}</div>
						            	<div class="goods">상품 가격 : ${contentView.price}</div>
						            	<div class="goods">상품 재고수량: ${contentView.amount}</div>
						            	<div class="goods">상품 판매 상태 : ${contentView.status}</div>
						            	<div class="goods">상품 판매 시작일 : ${contentView.sellstart}</div>
						            	<div class="goods">상품 판매 종료일 : ${contentView.sellend}</div>
						            
						            </div>
					            </div>
					         
         					<button type="button" onclick="history.go(-1);" class="gobackbtn">돌아가기</button>
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