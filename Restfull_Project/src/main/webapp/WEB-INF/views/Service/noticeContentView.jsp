<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>RestFuLL | 공지사항</title>
 	<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>

<%@ include file="/WEB-INF/include/js-header.jsp"%>

<section class="blog-details spad">
	<div class="container">
		<div class="row">
			<div class="col-lg-8 offset-lg-2">
				<input type="hidden" name="board_numbers" value="${contentView.board_numbers}">
				<input type="hidden" name="boardlist_numbers" value="${contentView.boardlist_numbers}">
				<div id="photo-view">
						<!-- 사진들 -->
						<div id="myCarousel" class="carousel slide" data-ride="carousel">
						     <!-- Indicators -->
						     <ul class="carousel-indicators"> </ul>
						     
						     <!-- Wrapper for slides -->
						     <div class="carousel-inner"> </div>
						     
						     <!-- Controls -->
						     <a class="carousel-control-prev" href="#myCarousel" data-slide="prev">
						       <span class="carousel-control-prev-icon"></span>
						     </a>
						     <a class="carousel-control-next" href="#myCarousel" data-slide="next">
						       <span class="carousel-control-next-icon"></span>
						     </a>
						</div>
						
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


				</div>
					
				<div class="write-view">
					<div class="board-contents">
						<div class="view-hit">조회수 - ${contentView.hit} 회</div>
							<div class="view-dates">${contentView.dates} </div>
							<br/>
							<div class="view-id">${contentView.member_id}</div>
							<div class="view-title">${contentView.title}</div>
 							<div class="view-contents">${contentView.contents}</div>
					</div>
				</div>
					
			</div>
		</div>
	</div>
</section>
							
	<%@ include file="/WEB-INF/include/js-footer.jsp"%>
	
</body>
</html>