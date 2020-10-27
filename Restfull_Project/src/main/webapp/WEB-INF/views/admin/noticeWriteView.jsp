<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>RestFuLL | 공지사항 글작성</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
		<%-- <script type="text/javascript" src="<%=request.getContextPath()%>/resources/ckeditor/ckeditor.js"></script>
		 --%>
</head>
<body>

<%@ include file="/WEB-INF/include/js-header.jsp"%>
	<h2 class="text-center">관리자 페이지입니다.</h2>

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
                        	<div class="notice_write">
								<form action="<%=request.getContextPath() %>/admin/notice/write" method="post" enctype="multipart/form-data">
									<!-- hidden -->
									<sec:authentication var="principal" property="principal" />
									<input type="hidden" name="member_id" value="${principal.user.member_id}"/>
									
									<select name="boardlist_numbers" id="boardlist_numbers">
										<option value="2">공지사항</option>
										<option value="5">이벤트</option>
									</select>	
									
									<!-- write Data -->
									<div class="group-input">
			                     		<!-- 첨부 버튼 -->
										<div class="writepic">
											<div id="attach">
												
												<input id="uploadInputBox" type="file" name="file" accept="image/*" />
			                          		</div>
			                          	</div>
			                        </div>
									
									<!-- 제목,내용 -->		
									<div class="group-input">
										<div class="writetitle">
			 								<label for="title">제목 </label>
											<input type="text" name="title" class="write_tilte" maxlength="20" required>
										</div>
									</div>
							
									<div class="group-input">
										<label for="contents">내용 </label>
										<div class="writecontentx">
											<textarea rows="10" cols="50" name="contents" class="write_content" placeholder="최대 500자 까지 작성 가능합니다." maxlength="500" required></textarea>
										</div>
									</div>
									
									<button type="submit" id="submit">완료</button>
									
								</form>
                        	</div>
                        	<button type="button" onclick="history.go(-1);" class="gobackbtn">돌아가기</button>
                        </div>
                    </div>
                </div>
            </div>
		</div>
	</section>

<!-- 	<button type="button" onclick="history.go(-1);" class="gobackbtn">돌아가기</button> -->
	
<%@ include file="/WEB-INF/include/js-footer.jsp"%>
                
                


</body>
</html>