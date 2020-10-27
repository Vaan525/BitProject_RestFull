<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
                <div class="col-lg-9 order-1 order-lg-2">
                    <div class="row">
                        <div class="col-lg-12 col-sm-12">
                            <div class="notice-table">
								<div class="writebtn">
									<a href="${pageContext.request.contextPath}/admin/dest/writeView">여행지 등록</a>
                                </div>
                                <table id="list-table">
									<tr class="first-list">
										<td>지역코드</td>
										<td>여행지명</td>
										<td>지번 주소</td>
										<td>도로명 주소</td>
									</tr>
									<c:forEach items="${destlist}" var="vo">
										<tr class="noticeable">
											<td>${vo.sidoguVO.sidoName}</td>
											<td><a href="${pageContext.request.contextPath}/admin/dest/contentView?destination_numbers=${vo.destination_numbers}">${vo.destination_name}</a></td>
											<td>${vo.jibunaddress}</td>
											<td>${vo.doroaddress}</td>
										</tr>
									</c:forEach>	
								</table>
								<!-- <button onclick="history.go(-1);">돌아가기</button> -->
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