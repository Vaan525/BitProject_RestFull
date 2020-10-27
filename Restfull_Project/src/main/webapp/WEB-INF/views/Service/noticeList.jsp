<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>RestFuLL | 공지사항</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

	
</head>
<body>
<%@ include file="/WEB-INF/include/js-header.jsp"%>

		<c:set var="boardListName" value="${boardListName}" />
			<c:choose>
				<c:when test="${boardListName eq 'event'}">
					<div class="text-center"><h2>이벤트</h2></div>
				</c:when>
				<c:when test="${boardListName eq 'notice'}">
				   	<div class="text-center"><h2>공지사항</h2></div>
				</c:when>
			</c:choose>
   <hr>

 <!-- Blog Section Begin -->
    <section class="blog-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-6 col-sm-8 order-2 order-lg-1">
                    <div class="blog-sidebar">
                        <div class="blog-catagory">
                            <h4>고객센터</h4>
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/notice/<c:out value='2'/>">공지사항</a></li>
                                <li><a href="${pageContext.request.contextPath}/notice/<c:out value='5'/>">이벤트</a></li>
                                <li><a href="${pageContext.request.contextPath}/FAQ">자주하는질문</a></li>
                                <li><a href="${pageContext.request.contextPath}/personal">약관 및 정책</a></li>

                            </ul>
                        </div>
                       
                      
                    </div>
                </div>
                
                
                <!--공지사항 table start-->
                <div class="col-lg-9 order-1 order-lg-2">
                    <div class="row">
                        <div class="col-lg-12 col-sm-12">
                            <div class="notice-table">
                                <table id="list-table">
									<tr class="first-list">
										<td>구분</td>
										<td>제목</td>
										<td>작성일</td>
										<td>조회수</td>
									</tr>
									<c:forEach items="${noticelist}" var="vo">
									<tr class="noticetable">
										<td>${vo.boardlistName}</td>
										<td><a href="${pageContext.request.contextPath}/notice/contentView?board_numbers=${vo.board_numbers}">${vo.title}</a></td>
										<td>${vo.dates}</td>
										<td>${vo.hit}</td>
									</tr>
									</c:forEach>
								</table>
                            </div>
                        </div>
                        
                    </div>
                </div>
                <!--공지사항 table end-->
            </div>
        </div>
    </section>






<!-- 	<h3><button onclick="history.go(-1);">돌아가기</button></h3> -->
	
<%@ include file="/WEB-INF/include/js-footer.jsp"%>
</body>
</html>
