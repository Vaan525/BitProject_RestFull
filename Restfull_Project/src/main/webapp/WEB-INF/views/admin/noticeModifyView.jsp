<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>RestFull indexPage</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
		<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=fawtmt0h7b&submodules=geocoder"></script>
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
								<form action="modify" method="post" enctype="multipart/form-data" >
									<!-- hidden -->
									<input type="hidden" name="member_id" value="${modifyView.member_id}"/>
									<input type="hidden" name="boardlist_numbers" value="<c:out value='1'/>">
									<input type="hidden" name="board_numbers" value="${modifyView.board_numbers}"/>
									<!-- write Data -->
									사진 데이터는 수정이 불가능합니다.
						 			<div id="photo-view">
										<div id="myCarousel" class="carousel slide" data-ride="carousel">
										     <ul class="carousel-indicators"> </ul>
										     
										     <div class="carousel-inner"> </div>
										     
										     <a class="carousel-control-prev" href="#myCarousel" data-slide="prev">
										       <span class="carousel-control-prev-icon"></span>
										     </a>
										     <a class="carousel-control-next" href="#myCarousel" data-slide="next">
										       <span class="carousel-control-next-icon"></span>
										     </a>
										</div>
										
									</div>
									
									<hr/>
									<!-- 제목,내용 -->		
									<div class="group-input">
										<div class="writetitle">
			 								<label for="title">제목 </label>
											<input type="text" name="title" class="write_tilte" value="${modifyView.title}" maxlength="20" required>
										</div>
									</div>
									
									<div class="group-input">
										<label for="contents">내용 </label>
										<div class="writecontentx">
											<textarea rows="10" cols="50" name="contents" class="write_content" placeholder="최대 500자 까지 작성 가능합니다." maxlength="500" required>${modifyView.contents}</textarea>
										</div>
									</div>
									
									<button type="submit" id="submit" >수정</button>
														
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
	
</form>
</body>
	<script>
							$(function(){  
								var filelist = new Array();
									
								<c:forEach items="${filelist}" var="file">
									var json = new Object();
									json.filedirectory = "${file.filedirectory}";
									filelist.push(json);
								</c:forEach>
									
							console.log("filelist : " + filelist);
									
							    for(var i=0 ; i< filelist.length ; i++) {
									  $('<div class="carousel-item"><img src="'+filelist[i].filedirectory+'" style="height:600px; "></div>').appendTo('.carousel-inner');
								    $('<li data-target="#myCarousel" data-slide-to="'+i+'"></li>').appendTo('.carousel-indicators')
								 }
								 $('.carousel-item').first().addClass('active');
								 $('.carousel-indicators>li').first().addClass('active');
								 $('#myCarousel').carousel();
						});
										
	</script>
</html>