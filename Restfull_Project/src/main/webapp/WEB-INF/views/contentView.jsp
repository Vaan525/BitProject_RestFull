<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>RestFuLL | 여행일기</title>
  	<meta name="viewport" content="width=device-width, initial-scale=1">

</head>
<body>
<%@ include file="/WEB-INF/include/js-header.jsp"%>   

	   
	            
<!-- 메인 컨텐츠  -->
<section class="write-section spad">
	<div class="container">
		<div class="row">
			<div class="col-lg-7 order-lg-1">
				<input type="hidden" name="board_numbers" value="${contentView.board_numbers}">
				<div class="leftbox">
					<div class="photo-view">
					
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

						
						<div class="wrapper">
							<div class="likeanddrop">
								 <!--------------------------
		                        		좋아요 버튼 start
		                         ----------------------------->
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
							 <!--------------------------
		                        	좋아요 버튼  end
		                     ----------------------------->
		                     
		                     
		                    <!--------------------------
		                        	드롭다운 버튼  start
		                     ----------------------------->
							
								<div class="dropdown">
							 		<button type="button" class="btn dropdown" role="button"  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							  		  ...
							 		</button>
								    <div class="dropdown-menu">
								    	<!-- 자신이 쓴 글일 때만 수정/삭제 버튼 노출 -->
									    <c:if test="${principal.user.member_id eq contentView.member_id}">
									      <a class="dropdown-item" href="user/modify?board_numbers=${contentView.board_numbers}">수정</a>
									      <a class="dropdown-item" href="user/delete?board_numbers=${contentView.board_numbers}">삭제</a>
									    </c:if>
								      <a class="dropdown-item" href="#DecModal" data-toggle="modal">신고</a>
								    </div>
							
								</div>
						    
								<!-- 신고 Modal -->
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
								         
								
								      </div>
								      
								      <!-- Modal footer -->
								      <div class="modal-footer">
								        <input type="button" id="finish" class="btn btn-default" data-dismiss="modal" value="신고">
								      </div>
								      
								      
								    </div>
								  </div>
								</div>	  
						  	</div>
						</div>
                       
                        <div class="write-view">
                            <div class="board-contents">
                                <div class="view-hit">조회수 - ${contentView.hit} 회</div>
                                <div class="view-dates">${contentView.dates} </div>
                                <br/>
                                <div class="view-loc">${contentView.location}</div> <br>
                                <div class="view-id">${contentView.member_id}</div>
                                <div class="view-title">${contentView.title}</div>
                                <div class="view-contents">${contentView.contents}</div>
                            </div>
                        </div>
					</div>
				</div>
           
				
				<!--왼쪽부분end-->
				<div class="col-lg-4 order-lg-2">
                    <div class="rightbox">
                        <div class="replycomment"> <!--댓글 부분-->
                            <!-- 댓글 작성칸 -->
                            <div id="addMyComment">
                                <span id="myId">${principal.user.member_id}</span>
                                <div class="comment-reg">
                                    <input type="text" placeholder="댓글을 입력하세요" id="reply" name="reply"/>
                                    <input id="addComment" type="button" value="✔"/>
                                </div>
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
            </div>
            <!--오른쪽 댓글 부분 end-->
        </div>
    </section>
    
    <hr/>        
    <!-------------------
   		아래쪽 관련게시글 출력
    --------------------->
        
    <div class="underbox spad">
        <div class="container">
            <div class="row">
                <!-- 게시물 list -->
                <div class="col-lg-12">
                    <div class="listboard">
                        <h4>✨관련게시글✨</h4>
                    </div>
                </div>
            </div>
                    
            <div class="row">
               <c:forEach items="${others}" var="vo">
                    <div class="col-lg-3 col-sm-6">
                       <div class="product-item">
                            <div class="pi-pic">
                                <a href="contentView?board_numbers=${vo.board_numbers}" class="thumbnail">
                                    <img src="${vo.thumbnail }"/>
                                </a>           
                            </div>

                            <div class="pi-text">
                                <div class="caption-title">${vo.title}</div>
                                
                                <div class="caption-loc">${vo.location}</div>
                                
                                <div class="caption-destination">${vo.destinationVO.jibunaddress}</div>
                            </div>
                        </div>
                    </div>
                </c:forEach> 
            </div>
        </div>
    </div> 

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
							       $('<div class="carousel-item" style="width:100%; text-align:center; margin:0px auto;"><img src="'+filelist[i].filedirectory+'" style="height:100%; line-height:auto; "></div>').appendTo('.carousel-inner');
							       $('<li data-target="#myCarousel" data-slide-to="'+i+'"></li>').appendTo('.carousel-indicators')
							    }
						    	
							    $('.carousel-item').first().addClass('active');
							    $('.carousel-indicators>li').first().addClass('active');
							     //$('#myCarousel').carousel();
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
													url: "${pageContext.request.contextPath}/user/board/likeCheck",
									                type: "GET",
									                dataType:"json",
									                data: {
									                    "board_numbers": board_numbers,
									                    "member_id": member_id
									                },
									                success: function (result) {
									                	//좋아요 체크를 했을 때, 좋아요 된 상태(1)일 경우 하트의 상태를 바꿈(빈하트 -> 꽉찬 하트)
									                	if(JSON.parse(result == 1)){
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
														url: "${pageContext.request.contextPath}/user/board/likeUpdate",
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
										                type: "GET",
										                data: {
										                    "board_numbers": board_numbers
										                },
										                dataType:"json",
										                success: function (count) {
										                	console.log(JSON.parse(count));
										                	$(".like_count").text(JSON.parse(count));
										                },
													})
											    };
											likeCheck();
											likeCount(); // 처음 시작했을 때 실행되도록 해당 함수 호출
											});
											</script>
											
									<!--기타 클릭시 텍스트 입력 가능 script-->
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
												url: "${pageContext.request.contextPath}/user/report",
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
                                            if(result.length < 1){
                                                htmls += "등록된 댓글이 없습니다.";
                                            } else {
                                                    $(result).each(function(index,item){
                                                        //사용자와 작성자의 아이디가 같다면 삭제 버튼 생성
                                                        if(this.member_id == member_id){
                                                            htmls += '<tr class="comment">';
                                                            htmls += '<td>'+ item.member_id + '</td>'+' ';
                                                            htmls += '<td>'+ item.contents + '</td>';
                                                            htmls += '<td><button type="button" name="delete" value="' + item.comments_numbers+'"> x </button>';
                                                            htmls += '<tr>'
                                                            htmls += '<td>'+ item.dates + '</td>';
                                                            htmls += '</tr>';
                                                            htmls += '</tr>';                                                            
                                                        } else {
                                                            //아니라면 그냥 출력
                                                            htmls += '<tr>';
                                                            htmls += '<td>'+ item.member_id + '</td>'+'<br/>';
                                                            htmls += '<td>'+ item.contents + '</td>';
                                                            htmls += '<tr>'+ item.dates + '</tr>';
                                                            htmls += '<td>'+ item.comments_numbers + '<input type="hidden" value="'+ item.board_numbers + '"></td>';	
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
                                                url: "${pageContext.request.contextPath}/user/delComments",
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
                                            url: "${pageContext.request.contextPath}/user/addComments",
                                            type: "POST",
                                            data: {
                                                "board_numbers": board_numbers,
                                                "member_id": member_id,
                                                "contents":contents
                                            },
                                            success: function () {
                                            	$('input[name="reply"]').val(''); //작성했으니 초기화시킴
                                                commentList();
                                            },
                                        });
                                    });
                                    commentList(); // 처음 시작했을 때 실행되도록 해당 함수 호출
                                });
                            </script>
</html>