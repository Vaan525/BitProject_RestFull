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
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <!-- 하트아이콘,,, -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  
  <style>
  
  
		.container contents {
			background-color: white;
		}
		
		.main-postings{
			background-color: white;
			display:inline-block;
			border: 1px solid black;
			width:30px;
			height:350px;
			text-align:center;
			position:absolute;
			padding: 30px  20px  30px  20px;
			margin:10px 10px 10px 10px;
		}
		
  	#photo-view{
  		background-color: #8A93C0;
  		border : 1px;
  		width:100%;
  		height:50%;
  	}
  
  	#myCarousel {
  		background-color: black;
  		width: 100%;
  		height: 500px;
  		text-align:center;
  		justify-content:center;
  	}
	
  	.carousel-item,
  	.carousel-inner,
	.carousel-inner img {
		height: 100%;
		width: auto;
		text-align: center;
	}
	
	.carousel-inner {
		text-align: center;
	}
	
	.likebutton, 
	.btn dropdown-toggle {
		background-color:#8A93C0;
		color:white;
	}
	/*신고 모달창*/
#DecModal .modal-content .modal-header {
    background-color:#8a93c0;
 
}
#DecModal .modal-content .modal-header h4{
    font-weight:800;
    color: white;
    text-align: center;
}
#DecModal .modal-content .modal-header button {
    color: white;
}
#DecModal .modal-body {
    float:left;
    height: 300px;
    width:100%;
}
#DecModal .modal-body .mb-title {
    margin-bottom:10px;
    
}
#DecModal .modal-body .mb-title b {
    font-size: 17px;
}
#DecModal .modal-body .mb-title #title {
    margin-left:10px;  
    
}
#DecModal .modal-body .mb-reason {
    margin: 5px 0;
}
#DecModal .modal-body .mb-reason b {
    font-size: 17px;   
}
#DecModal .modal-body .mb-reason input{ 
    margin-right: 4px;
}
#DecModal .modal-body .mb-reason label {
    margin-right:15px;   
}
#DecModal .modal-body .other-reason #reasontext{
    width:100%;
    height: 150px;
}
#DecModal .modal-footer button{
    font-size:20px;
    font-weight:900;
    text-align:center;
    float:right;
}
	
  </style>
</head>
<body>
	            
			<!-- 메인 컨텐츠  -->
			<div class="container">
				<input type="hidden" name="board_numbers" value="${contentView.board_numbers}">
				<div id="leftbox" style="float:left; width:50%;">
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
						
						
						<div class="dropdown">
							<div>
								<div>
									<sec:authorize access="isAnonymous()">
	            						<button type="button" name="loginNeed">
										<i id="like-button" class="fa fa-heart-o"></i>
										</button>
										<span class="like_count"></span>	
										
									</sec:authorize>
									
									<sec:authorize access="isAuthenticated()">
									<sec:authentication var="principal" property="principal"/>
										<c:if test="${ principal.user.member_id != null }">
											<input type="hidden" name="member_id" value="${principal.user.member_id}"/>
										</c:if>
										<button type="button" id="like_update">
										<i id="like-button" class="fa fa-heart-o"></i>
										</button>
											 <span class="like_count"></span>
										
									</sec:authorize>
								</div>
							</div>
							
							<div class="dropdown">
						    <button type="button" class="btn dropdown-toggle" data-toggle="dropdown">
						     
						    </button>
						    <div class="dropdown-menu">
						      <a class="dropdown-item" id="modify" href="modify?board_numbers=${contentView.board_numbers}">수정</a>
						      <a class="dropdown-item" id="delete">삭제</a>
						      <a class="dropdown-item" id="report" href="#DecModal" data-toggle="modal" >신고</a>
						    </div>
						    
							<!-- Modal -->
							<div id="DecModal" class="modal fade" role="dialog">  <!-- fade는 투명 효과 -->
							  <div class="modal-dialog">
							
							    <!-- Modal content-->
							    <div class="modal-content">
							      <div class="modal-header">
							       <h4>신고작성창</h4>
							        <button type="button" class="close" data-dismiss="modal">x</button>
							        </div>
							        
							      <div class="modal-body">
							         <div class="mb-title">
							          <input type="hidden" name="boardlist_numbers" id="boardlist_numbers" value="3"/>
							          <input type="hidden" name="member_id" id="member_id" value="${principal.user.member_id}">
							          <input type="hidden" name="report_numbers" id="report_numbers"value="${contentView.board_numbers}">
							            <b>신고 대상글 :</b><input type="text" name="title" id="title" value="${contentView.title}" readonly>
							         </div>
							           <hr/>
							         <div class="mb-reason">
							            <b>신고 사유</b>
							               <br/>    
							                <input type="radio" name="report_reason" value="11" checked ><label for="r1">음란성</label>
							                <input type="radio" name="report_reason" value="12" ><label for="r2">홍보 및 허위</label>
							                <input type="radio" name="report_reason" value="13" ><label for="r3">기타</label>    
							               <div class="other-reason">
							                  <textarea name="report_reason" id="reasontext" placeholder="기타사유를 입력해주세요."  maxlength="500">
							                  </textarea>
							               </div>
							            
							          </div>  
							         <!--기타 클릭시 텍스트 입력 가능 script-->
							         
							
							      </div>
							      <!-- Modal footer -->
							      <div class="modal-footer">
							        <button type="button" id="finish" class="btn btn-default" data-dismiss="modal">신고</button>
							      </div>
							      
							      
							    </div>
							
							  </div>
							</div>

							  
							  
							  
						  </div>
					</div>
					
					<div class="board-contents">
						<h2><p>${contentView.title}</p></h2>
						<p>${contentView.member_id}</p>
						<p>${contentView.dates}</p>
						<p>${contentView.hit}</p>
						<p>${contentView.contents}</p>
					</div>
				</div>
					<!-- 중간 구분선 -->		
			 		<div style="width:5%; height:100%; border-left:3px solid purple;position: absolute;left: 50%;margin-left: -3px;">
					</div>

				<!-- 댓글 출력 -->
				<div id="rightbox"style="float:right">				
					<div>
						<!-- 댓글 작성칸 -->
						<div id="addMyComment">
							<span id="myId">${principal.user.member_id}</span> :  
							<input type="text" placeholder="댓글을 입력하세요" id="reply" name="reply"/>
							<button id="addComment" type="button" value="입력">댓글작성</button> 
						</div>
						
						<!-- 댓글 list -->
						<div id="commentlist">
							<!-- 사용자 프로필 사진 or 사용자 아이디 -->
							<div>
							
							</div>
							
							<!-- 댓글 -->
							<div id="reply">
								<section class="replyForm">
									<table id="list-table">
									
									</table>
								</section>
							</div>
						</div>
						
					</div>
				</div>
				
			</div>
			
 			<!-- 아래쪽에 다른 게시글들을 출력함 -->
			<div class="container contents">
				<div class="row">
				<!-- 게시물 list -->
					<div style="width:50%; height:500px; float:left">
						<h2>리스트 뽑기</h2>
							<c:forEach items="${others}" var="vo">
								<div class="col-xs-6 col-md-3 main-postings">
								    <a href="contentView?board_numbers=${vo.board_numbers}" class="thumbnail">
								      <img src="${vo.thumbnail }"/>
								      <div class="caption">
							                <h3>${vo.title}</h3>
							                <p>${vo.location}</p>
							                <p>${vo.destinationVO.jibunaddress}</p>
							          </div>
								    </a>
								</div>
							</c:forEach>
					</div>
				</div>
			</div>
	
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
	<script>
						$(document).on("click", "button[name='loginNeed']",function(){
							
							console.log("loginNeed");
							
						});
	</script>
<script>
											$(function(){
												var board_numbers = $('input[name=board_numbers]').val();
												var member_id = $('input[name=member_id]').val();
												console.log("board_numbers : " + board_numbers);
												console.log("member_id : " + member_id);
												function likeCheck(){ 
													$.ajax({
													url: "${pageContext.request.contextPath}/board/likeCheck",
									                type: "POST",
									                dataType:"json",
									                data: {
									                    "board_numbers": board_numbers,
									                    "member_id": member_id
									                },
									                success: function (result) {
									                	//좋아요 체크를 했을 때, 좋아요 된 상태(1)일 경우 하트의 상태를 바꿈(빈하트 -> 꽉찬 하트)
									                	if(result == 1){
										                	$("#like-button").attr('class','fa fa-heart');
									                	}else{
									                		$("#like-button").attr('class','fa fa-heart-o');
									                	}
									                }
												});
												};
												
												// 추천버튼 클릭시(추천 추가 또는 추천 제거)
												$("#like_update").click(function(){
													$.ajax({
														url: "${pageContext.request.contextPath}/board/likeUpdate",
										                type: "POST",
										                data: {
										                    "board_numbers": board_numbers,
										                    "member_id": member_id
										                },
										                success: function () {
										                	likeCheck();
										                	likeCount();
										                },
													});
												});
												
												// 게시글 추천수
											    function likeCount() {
													$.ajax({
														url: "${pageContext.request.contextPath}/board/likeCount",
										                type: "POST",
										                data: {
										                    "board_numbers": board_numbers
										                },
										                dataType:"json",
										                success: function (count) {
										                	console.log(count);
										                	$(".like_count").text(count);
										                },
													})
											    };
											likeCheck();
											likeCount(); // 처음 시작했을 때 실행되도록 해당 함수 호출
											});
											</script>
											
											<script>
						    	$("#delete").on("click", function(){
						    		var member_id = '<c:out value="${contentView.member_id}"/>';
						    		var board_numbers = $('input[name=board_numbers]').val()
						    		console.log("삭제합니다 : " + board_numbers);
						    		
						    		var yn = confirm("게시글을 삭제하시겠습니까?");
						    		if(yn){
						    			
						    				$.ajax({
						    					url : "/restfull/admin/boardDeleteAdmin",
						    					async: true,
						    					type : "GET",
						    					data : {
						    						"board_numbers" : board_numbers
						    					},
						    					success: function() {
						    							alert("게시글이 삭제되었습니다.");
						    							location.href = "/restfull/admin/user_contentView?member_id="+member_id;
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
						    
						    <script>
							          $(document).ready(function(){
							
							  			function reasonchecked(){
											
							                console.log("check된 버튼 : " + $("input[name=report_reason]:checked").val());
							                if($("input[name=report_reason]:checked").val() == "13"){
							                    $("textarea[name=report_reason]").attr("disabled",false);
							                    // radio 버튼의 value 값이 13(기타)이라면 활성화
							
							                }else{
							                    // radio 버튼의 value 값이 그 외라면 비활성화
							                	$("textarea[name=report_reason]").attr("disabled",true);
							                }
										}
							        	  
							            // 라디오버튼 클릭시 이벤트 발생
							            $("input:radio[name=report_reason]").click(function(){
							            	$("textarea[name=report_reason]").val('');
							            	reasonchecked();
							            });
							            
							            reasonchecked();
							        });
							          </script>
							          
							          <script>
							      $("#finish").click(function(e){
							         e.preventDefault();
							
							         var boardlist = $("#boardlist_numbers").val();
							         var memberid = $("#member_id").val();
							         var reportnum = $("#report_numbers").val();
							         var reasonNum = $("input[name=report_reason]:checked").val();
							         var reasonText = $("#reasontext").val();
							         
							         console.log(boardlist);
							         console.log(memberid);
							         console.log(reportnum);
							         console.log(reasonNum);
							         console.log(reasonText);
							              //신고글의 제목으로 신고대상글 번호를 넘김
							              //신고글의 구분(음란성/홍보/기타)를 필터번호로 넘김
							         $.ajax({
											url: "${pageContext.request.contextPath}/report",
							                type: "POST",
							                data: {
							                    "title":reportnum,
							                	"contents" : reasonText,
							                    "member_id": memberid,
							                    "boardlist_numbers": boardlist,
							                    "filter_numbers" : reasonNum,	
							                },
							                success: function () {
							                	alert("신고가 완료되었습니다.");
							                },
										}); 
							      	});
							      
							      
							      </script>
							      <script>
							$(function(){
								var board_numbers = ${contentView.board_numbers};
								var member_id = $('#myId').text();
								
								console.log("댓글쓰기 board_numbers - " + board_numbers);
								console.log("member_id : " + member_id);
								
								//댓글 목록 출력(문서 로딩되자마자 실행)
								function commentList(){ 
									
									$.ajax({
									url: "${pageContext.request.contextPath}/getComments/" + board_numbers,
					                type: "POST",
					                dataType:"json",
					                success: function (result) {
					                	//html삽입 : 표시될 데이터 - 아이디,댓글내용,작성일,삭제버튼,[히든]댓글번호
					                	var htmls="";
					                	$("#list-table").html("");	
					        			$("<tr>" , {
					        				html : "<td>" + "아이디" + "</td>"+  // 컬럼명들
					        						"<td>" + "댓글내용" + "</td>"+
					        						"<td>" + "작성일" + "</td>"+
					        						"<td>" + "삭제버튼+댓글번호[히든]" + "</td>"			
					        			}).appendTo("#list-table") // 이것을 테이블에붙임
					        			if(result.length < 1){
					        				htmls.push("등록된 댓글이 없습니다.");
					        			} else {
					                            $(result).each(function(index,item){
					                            	//사용자와 작성자의 아이디가 같다면 삭제 버튼 생성
					                            	if(this.member_id == member_id){
					                            		
						                            	htmls += '<tr>';
						        	                    htmls += '<td>'+ item.member_id + '</td>';
						        		                htmls += '<td>'+ item.contents + '</td>';
						        		                htmls += '<td>'+ item.dates + '</td>';
						        	                    htmls += '<td><button type="button" name="delete" value="' + item.comments_numbers+'">삭제</button>';
						        	                   	htmls += '<button type="button" name="comment-modify" value="'+item.comments_numbers+'">수정</button></td>';
						        	                   	htmls += '</tr>';
						        	                    
					                            	} else {
					                            		//아니라면 그냥 출력
						                            	htmls += '<tr>';
						        	                    htmls += '<td>'+ item.member_id + '</td>';
						        		                htmls += '<td>'+ item.contents + '</td>';
						        		                htmls += '<td>'+ item.dates + '</td>';
						        	                    htmls += '<td>'+ item.comments_numbers + '<input type="hidden" value="'+ item.board_numbers + '"> 게시글번호숨김 </td>';	
						        	                    htmls += '</tr>';
					                            	}
					        	                    			                    		                   
					                        	});	//each end
					        			}
					        			$("#list-table").append(htmls);
					                	}
									});
								};
								
								$(document).on("click", "button[name='delete']",function(){
									
									console.log("delete 버튼 클릭");
									var comments_numbers = $(this).val();
									
									console.log("삭제 대상 : " + comments_numbers);
										$.ajax({
											url: "${pageContext.request.contextPath}/delComments",
							                type: "POST",
							                data: {
							                    "comments_numbers": comments_numbers
							                },
							                success: function () {
							                	commentList();
							                	console.log("성공");
							                },
										})
								});
								
								//댓글 작성 버튼 클릭 시
								$("#addComment").click(function(){
									var contents = $('#reply').val();
									console.log("댓글쓰기 board_numbers - " + board_numbers);
									console.log("member_id : " + member_id);
									
									console.log("contents : " + contents);
									
									$.ajax({
										url: "${pageContext.request.contextPath}/addComments",
						                type: "POST",
						                data: {
						                    "board_numbers": board_numbers,
						                    "member_id": member_id,
						                    "contents":contents
						                },
						                success: function () {
						                	commentList();
						                },
									});
								});
								
								
			                	commentList(); // 처음 시작했을 때 실행되도록 해당 함수 호출
							});
						</script>
</html>