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
		
		<!-- 제이쿼리  -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        
        <!-- 부트 스트랩  -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=fawtmt0h7b&submodules=geocoder"></script>
		<%-- <script type="text/javascript" src="<%=request.getContextPath()%>/resources/ckeditor/ckeditor.js"></script>
		 --%>
		 <style>
		</style>
</head>
<body>

<form action="modify" method="post" enctype="multipart/form-data">
	<!-- hidden -->
	<sec:authentication var="principal" property="principal" />
	<input type="hidden" name="member_id" value="${modifyView.member_id}"/>
	<input type="hidden" name="boardlist_numbers" value="<c:out value='1'/>">
	<input type="hidden" name="filter_numbers" value="<c:out value='1'/>">
	<input type="hidden" name="board_numbers" value="${modifyView.board_numbers}"/>
	<!-- write Data -->
	사진 데이터 및 위치정보는 수정이 불가능합니다.
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
	제목 : <input type="text" name="title" value="${modifyView.title}">
	<hr/>
	내용 : <textarea rows="10" cols="50" name="contents" placeholder="최대 500자 까지 작성 가능합니다." maxlength="500">
	${modifyView.contents}
	</textarea>
	<hr/>
	위치 : <input type="text" name="location" value="${modifyView.location}" readOnly>
	<hr/>
	<input type="submit" id="submit" value="완료" style="position:absolute;"/>
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
							       $('<div class="carousel-item"><img src="'+filelist[i].filedirectory+'" width=\"460\" height=\"345\""></div>').appendTo('.carousel-inner');
							       $('<li data-target="#myCarousel" data-slide-to="'+i+'"></li>').appendTo('.carousel-indicators')
							     	}
							     $('.carousel-item').first().addClass('active');
							     $('.carousel-indicators>li').first().addClass('active');
							     $('#myCarousel').carousel();
							});
							
						</script>
</html>