<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
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
					<div class="notice_view">
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
					</div>
				
					<div class="wrapper">
						<div class="dropdown">
						 	<button type="button" class="btn dropdown" role="button"  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					  		▼					 	</button>
							<div class="dropdown-menu">
						    <!-- 자신이 쓴 글일 때만 수정/삭제 버튼 노출 -->
							   <a class="dropdown-item" id="modify" href="modify?board_numbers=${contentView.board_numbers}">수정</a>
							   <a class="dropdown-item" id="delete">삭제</a>
							 </div>
						</div>
					</div>
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
			<button type="button" onclick="history.go(-1);" class="gobackbtn">돌아가기</button>
		</div>
	</div>
</section>
					
<%@ include file="/WEB-INF/include/js-footer.jsp"%>
	
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
							//$('#myCarousel').carousel();
						});
														
					</script>
					
					<script>
					$("#delete").on("click", function(){
						var board_numbers = $('input[name=board_numbers]').val()
						var boardlist_numbers = $('input[name=boardlist_numbers]').val();
						var yn = confirm("게시글을 삭제하시겠습니까?");
						if(yn){
				    			
							$.ajax({
								url : "/restfull/admin/notice/delete",
				 				async: true,
				    			type : "GET",
				    			data : {
				    				"board_numbers" : board_numbers
				    			},
				    			success: function() {
				    				alert("게시글이 삭제되었습니다.");
				    				location.href = "/restfull/admin/notice";
				    			},
				    			error: function() {
				    				alert("알수 없는 에러 발생");
				 				}
				  			})
						}else{
							alert("게시글 삭제가 취소되었습니다.");
						}
					});
				</script>
</html>