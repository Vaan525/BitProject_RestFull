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

	<div class="text-center"><h2>문의 및 신고 답변</h2></div>

	<hr>


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
								<input type="hidden" name="board_numbers" value="${contentView.board_numbers}">
								<div class="singo_title">${contentView.title}</div><br/>
								<div class="singo_id">${contentView.member_id}</div><br/>
								<div class="singo_date">${contentView.dates}</div><br/>
								<div class="singo_content">${contentView.contents}</div>
							</div>
							<hr/>
							<div class="comment_table">
							    <!-- 댓글 작성칸 -->
				  				<div id="addMyComment">
				     				<c:if test="${ principal.user.member_id != null }">
										<input type="hidden" name="member_id" value="${principal.user.member_id}"/>
									</c:if>
				         			<span id="myId"><sec:authentication property="principal.user.member_id"/></span> :  
				               		<input type="text" placeholder="댓글을 입력하세요" id="reply" name="reply"/>
				           			<button id="addComment" type="button" value="입력">작성</button> 
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
					<button type="button" onclick="history.go(-1);" class="gobackbtn">돌아가기</button>
            
				</div>
			</div>
		</div>
	</section>
       

	
<%@ include file="/WEB-INF/include/js-footer.jsp"%>     
</body>
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
				                                   htmls.push("등록된 댓글이 없습니다.");
				                                } else {
			                                           $(result).each(function(index,item){
			                                              //사용자와 작성자의 아이디가 같다면 삭제 버튼 생성
			                                              if(this.member_id == member_id){
			                                                 
			                                  				htmls += '<tr>';
			                               					htmls += '<td>'+ item.member_id + '</td>';
			                                                htmls += '<td>'+ item.contents + '</td>';
			                                                htmls += '<td>'+ item.dates + '</td>';
			                                    			htmls += '<td><button type="button" name="delete" value="' + item.comments_numbers+'"> X </button>';
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
			                                                                                                    
			                                          });   //each end
			
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
			                                     commentList();
			                                     $('input[name=reply]').val('');
			                                  },
			                           });
			                        });
			                        commentList(); // 처음 시작했을 때 실행되도록 해당 함수 호출
			                     });
		                  	</script>
</html>