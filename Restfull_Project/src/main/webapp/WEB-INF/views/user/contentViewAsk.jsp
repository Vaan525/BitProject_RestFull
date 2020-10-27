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
   
  </style>
</head>
<body>
<%@ include file="/WEB-INF/include/js-header.jsp"%>
         <!-- 메인 컨텐츠  -->
         <div class="contentswrapper">
            <input type="hidden" name="board_numbers" value="${contentView.board_numbers}">
               <h2><p>${contentView.title}</p></h2>
               <p>${contentView.member_id}</p>
               <p>${contentView.dates}</p>
               
               <div id="photo-view">
                  <!-- 사진들 -->
                  <div id="pictures">
                     <c:forEach items="${filelist}" var="file">
                        <img src="${file.filedirectory }" />
                     </c:forEach>
                  </div>
               </div>
               
               <div>
                  <p>${contentView.contents}</p>
               </div>
               
                        <!-- 답변 글 -->
            <div id="rightbox"style="float:right">            
               <div>
                  <div id="commentlist">
                     <div id="reply">
                        <section class="replyForm">
                           <table id="list-table">
                           
                           </table>
                        </section>
                     </div>
                  </div>
                  <script>
                     $(function(){
                        var board_numbers = ${contentView.board_numbers};
                        var member_id = $('#myId').text();
                        
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
                                                                                                    
                                          });   //each end

                                }

                                $("#list-table").append(htmls);
                                }
                           });
                        };
                            commentList(); // 처음 시작했을 때 실행되도록 해당 함수 호출
                     });
                  </script>
               </div>
            </div>
            
         </div>
            <%@ include file="/WEB-INF/include/js-footer.jsp"%>
</body>
</html>