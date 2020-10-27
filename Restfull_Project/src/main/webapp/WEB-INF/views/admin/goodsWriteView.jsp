<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>RestFuLL | 상품 등록</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        
      <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=fawtmt0h7b&submodules=geocoder"></script>
</head>
<body>
<%@ include file="/WEB-INF/include/js-header.jsp"%>
	<div class="text-center"><h2>상품 등록</h2></div>

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
                        <div class="col-lg-12 col-sm-12">
                        	<div class="notice_write">
					         <form method="post" action="${pageContext.request.contextPath}/admin/dest/goods/write" class="goodsform">
					         	<div class="goods_register">
						            <div class="name">여행지명 - ${destVO.destination_name}</div>
						            <input type="hidden" name="destination_numbers" id="destination_numbers" value="${destVO.destination_numbers}"/>
						            <input type="hidden" name="destination_name" id="destination_name" value="${destVO.destination_name}"/>
						            <hr/>
						            <label>상품명 </label>
						            <input type="text" name="name"/>
						            <br/>
						            <label>판매업자 </label>
						            <input type="text" name="seller"/>
						            <br/>
						            <label>가격 </label>
						            <input type="text" name="price"/>
						            <br/>
						            <label>재고수량 </label>
						            <input type="text" name="amount"/>
						            <br/>
						            <label>판매상태</label>
						            <select name="status" id="status">
						                <option value="1">판매중</option>
						                <option value="0">판매중단</option>
						            </select>
						            <br>
						            <label>판매 시작일</label>
						            <input type="date" id="sellstart" name="sellstart"/>
						            <br/>
						            <label>판매 종료일</label>
						            <input type="date" id="sellend" name="sellend"/>
						            <br/>
					            </div>
					            <button type="submit">등록</button>
					         </form>
					         
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