<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		location.href="userList?nowPage=${paging.nowPage}&cntPerPage="+sel;
	}
</script>
</head>
<body>
<%@ include file="/WEB-INF/include/js-header.jsp"%>
	<div class="text-center"><h2>유저 관리</h2></div>

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
                            	<select id="cntPerPage" name="sel" onchange="selChange()">
									<option value="5"
										<c:if test="${paging.cntPerPage == 5}">selected</c:if>>5줄 보기</option>
									<option value="10"
										<c:if test="${paging.cntPerPage == 10}">selected</c:if>>10줄 보기</option>
									<option value="15"
										<c:if test="${paging.cntPerPage == 15}">selected</c:if>>15줄 보기</option>
									<option value="20"
										<c:if test="${paging.cntPerPage == 20}">selected</c:if>>20줄 보기</option>
								</select>
								<table id="list-table">
									<tr class="first-list">
										<td>회원 아이디</td>
										<td>회원 이름</td>
										<td>생년월일</td>
									</tr>
									<c:forEach items="${restful_user}" var="restful_user">
									<tr class="noticeable">
										<td><a href="userContentView?member_id=${restful_user.member_id}">${restful_user.member_id}</a></td>
										<td>${restful_user.name}</td>
										<td>${restful_user.birth}</td>
									</tr>
									</c:forEach>
								</table>
								<!-- <button onclick="history.go(-1);">돌아가기</button> -->
                            </div>
                        </div>
                        
                    </div>
					<div class="page-center">
						<c:if test="${paging.startPage != 1 }">
							<a href="userList?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&lt;</a>
						</c:if>
						<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
							<c:choose>
								<c:when test="${p == paging.nowPage }">
									<b>${p }</b>
								</c:when>
								<c:when test="${p != paging.nowPage }">
									<a href="userList?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a>
								</c:when>
							</c:choose>
						</c:forEach>
						<c:if test="${paging.endPage != paging.lastPage}">
							<a href="userList?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&gt;</a>
						</c:if>
						<div class="page-total">
				        총 게시글 수 : ${paging.total }
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
