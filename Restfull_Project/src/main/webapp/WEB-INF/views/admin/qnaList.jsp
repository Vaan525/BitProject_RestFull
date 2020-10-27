<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
   
</head>
<body>
<%@ include file="/WEB-INF/include/js-header.jsp"%>
	<div class="text-center"><h2>문의 및 신고 답변</h2></div>

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
							      <option value="3" selected>신고글</option>
							      <option value="4">문의사항</option>
							   </select> 
                                <table id="list-table">
								</table>
								<!-- <button onclick="history.go(-1);">돌아가기</button> -->
                            </div>
                        </div>
                        
                    </div>
                </div>
                <!--관리자페이지 table end-->
   
   
   
			   
   
   			</div>
		</div>
	</section>
   
   

<!-- 	<h3><button onclick="history.go(-1);">돌아가기</button></h3> -->
	
<%@ include file="/WEB-INF/include/js-footer.jsp"%>
</body>
<script>
			   $(function(){ 
				   getList();
			   });
			      function getList(){
			            
			         var boardlist = $("#boardlist_numbers option:selected").val();
			           
			         $.ajax({
			            url: "${pageContext.request.contextPath}/admin/qnas/" + boardlist,
			               type: "GET",
			               dataType:"json",
			               success: function (result) {
			                   console.log("성공");   
			                     setTable(result);
			               }
			         
			          });
			      };
			
			      function setTable(result){
			    	  
			         var htmls="";
			         $("#list-table").html("");
			         
			         var thead = $("<thead><tr class='first-list'>"
						        	+"<td>구분</td>"
						        	+"<td>신고대상글</td>"
						        	+"<td>신고자</td>"
						         	+"<td>신고날짜</td>"
						         	+"</tr></thead>");
			         
			         $("#list-table").append(thead);
			         
			         if(result.length < 1){
							htmls += '<tr class="noticeable2">';
							htmls += '<td>'+ "등록된 글이 없습니다."+'</td>';
							htmls += '</tr>';
							
			         } else {
			                   $(result).each(function(){                                                          
									htmls += '<tr class="noticeable">';
									htmls += '<td>'+ this.boardName + '</td>';
									htmls += '<td><a href="${pageContext.request.contextPath}/admin/qnas/contentView?board_numbers=' + this.board_numbers + '">' + this.title + '</a></td>';
			                      	htmls += '<td>'+ this.member_id + '</td>';
									htmls += '<td>'+ this.dates + '</td>';   
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