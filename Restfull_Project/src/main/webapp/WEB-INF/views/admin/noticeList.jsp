<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
	
</head>
<body>

<%@ include file="/WEB-INF/include/js-header.jsp"%>
	<div class="text-center"><h2>공지사항 및 이벤트 관리</h2></div>

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
								<select name="boardlist_numbers" id="boardlist_numbers">
									<option value="2" selected>공지사항</option>
									<option value="5">이벤트</option>
								</select>
								<div class="writebtn">
									<a href="${pageContext.request.contextPath}/admin/notice/writeView">글 작성</a>
                                </div>
                                <table id="list-table">

								</table>
                            </div>
                        </div>   
                    </div>
                </div>
                <!--관리자페이지 table end-->
                
				

			</div>
		</div>
	</section>

	
<%@ include file="/WEB-INF/include/js-footer.jsp"%>
</body>
<script>
	            $(function(){ 
	               getList();
	            });
	            
	               function getList(){
	                     
	                  var boardlist = $("#boardlist_numbers option:selected").val();
	                    
	                  $.ajax({
	                     url: "${pageContext.request.contextPath}/admin/notice/" + boardlist,
	                        type: "GET",
	                        dataType:"json",
	                        success: function (result) {
	                            console.log("성공");   
	                              setTable(result);
	                        }
	                  
	                   });
	               };//getList end
	         
	               function setTable(result){
	                  var htmls="";
				      $("#list-table").html("");
				         
				      var thead = $("<thead><tr class='first-list'>"
							        +"<td>구분</td>"
							        +"<td>제목</td>"
							        +"<td>작성자</td>"
							        +"<td>작성일</td>"
							        +"<td>조회수</td>"
							        +"</tr></thead>");
				         
				      $("#list-table").append(thead);
	                  
	                  
	                  
	                  if(result.length < 1){
	                     htmls += '<tr class="noticeable2">';
	                     htmls += '<td>'+ "등록된 글이 없습니다."+'</td>';
	                     htmls += '</tr>';
	                     
	                  } else {
	                            $(result).each(function(){                                                          
	                                htmls += '<tr class="noticeable">';
	                                htmls += '<td>'+ this.boardlistName + '</td>';
	                                htmls += '<td><a href="${pageContext.request.contextPath}/admin/notice/contentView?board_numbers=' + this.board_numbers + '">' + this.title + '</a></td>';
	                               	htmls += '<td>'+ this.member_id + '</td>';
	                               	htmls += '<td>'+ this.dates + '</td>';
	                                htmls += '<td>'+ this.hit + '</td>';   
	                                htmls += '</tr>';   //여기까지가 결과물 출력
	                           });   //each end
	            
	                  }
	                  
	                  $("#list-table").append(htmls);
	                  
	               }
	               
	   
	            $('#boardlist_numbers').on('change', function(){
	               getList();
	            });
	          
				</script>
</html>