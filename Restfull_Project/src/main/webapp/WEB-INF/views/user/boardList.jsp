<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		location.href="myList?member_id=${member_id}&nowPage=${paging.nowPage}&cntPerPage="+sel;
	}
</script>
</head>
<body>
	<%@ include file="/WEB-INF/include/js-header.jsp"%>
	<sec:authentication var="principal" property="principal"/>
	<h2 class="text-center">내 게시글 보기 페이지 입니다.</h2>
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
						            <li style="background-color: #8a93c0;"><p>[<a href="myList?member_id=<sec:authentication property="principal.user.member_id"/>">내 게시글 보기</a>]</p></li>
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
				         	<!-- <div id="outter"> -->
								<div style="float: right;">
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
								</div>
								<%-- 
								<div class="paging-font-size">
						                 	 총 게시글 수 : ${paging.total } / 총 페이지 수 : ${paging.lastPage } / 현재 페이지 : ${paging.nowPage } / 페이지당 게시글수 : ${paging.cntPerPage }
						        </div>
						         --%>
								<!-- width="500" cellpadding="0" cellspacing="0" border="1" -->
								<div class="notice-table">
									<table id="list-table">
										<tr class="first-list">
											<td>글 번호</td>
											<td>게시글 제목</td>
											<td>게시 날짜</td>
										</tr>
										<c:forEach items="${userBoard}" var="userBoard">
										<tr class="noticetable">
											<td>${userBoard.board_numbers}</td>
											<td><a href="contentView?board_numbers=${userBoard.board_numbers}">${userBoard.title}</a></td>
											<td>${userBoard.dates}</td>
										</tr>
										</c:forEach>
									</table>
								</div>
								<div class="paging-center">
									<c:if test="${paging.startPage != 1}">
										<a href="myList?member_id=${member_id}&nowPage=${paging.startPage - 1}&cntPerPage=${paging.cntPerPage}">&lt;</a>
									</c:if>
									<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
										<c:choose>
											<c:when test="${p == paging.nowPage}">
												<b>${p}</b>
											</c:when>
											<c:when test="${p != paging.nowPage }">
												<a href="myList?member_id=${member_id}&nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
											</c:when>
										</c:choose>
									</c:forEach>
								</div>                            
								<c:if test="${paging.endPage != paging.lastPage}">
									<a href="myList?member_id=${member_id}&nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}">&gt;</a>
								</c:if>
								
								
							
			        </div>
		        </div>
			</div>
		</section>
		<%@ include file="/WEB-INF/include/js-footer.jsp"%>
</body>
</html>
