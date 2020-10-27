<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>RestFuLL | FAQ</title>
 	 <meta name="viewport" content="width=device-width, initial-scale=1">

</head>
<body>
<%@ include file="/WEB-INF/include/js-header.jsp"%> 


    <div class="text-center"><h2>자주하는 질문(FAQ)</h2></div>
    <hr>
  <!-- Blog Section Begin -->
    <section class="blog-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-6 col-sm-8 order-2 order-lg-1">
                    <div class="blog-sidebar">

                        <div class="blog-catagory">
                            <h4>고객센터</h4>
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/notice/<c:out value='2'/>">공지사항</a></li>
                                <li><a href="${pageContext.request.contextPath}/notice/<c:out value='5'/>">이벤트</a></li>
                                <li><a href="${pageContext.request.contextPath}/FAQ">자주하는질문</a></li>
                                <li><a href="${pageContext.request.contextPath}/personal">약관 및 정책</a></li>
                            </ul>
                        </div>
                        
                    </div>
                </div>
                <!--ajax로 받아야하는 부분-마이페이지 start-->
                <div class="col-lg-9 order-1 order-lg-2">
                    <div class="faq-accordin">
                    
                        <div class="accordion" id="accordionExample">
                           
                           <div class="card">
                           	<div class="card-heading active">
                                <a class="active" data-toggle="collapse" data-target="#collapseOne">
                                    Q. 회원가입은 어떻게 해야하나요??
                                </a>
                            </div>
                            <div id="collapseOne" class="collapse show" data-parent="#accordionExample">
                                <div class="card-body">
                                   	 홈페이지 <strong>우측 상단</strong>에 보이시는 로그인 버튼을 누르시면 로그인 창으로 이동합니다.<br>
                                   	 로그인창 아래에 있는 회원가입 버튼을 통해 회원가입이 가능하십니다.
                                </div>
                            </div>
                           </div>
                           
                            <div class="card">
                                <div class="card-heading">
                                    <a data-toggle="collapse" data-target="#collapseTwo">
                                        Q. 여행지 코스 작성하는 방법이 뭔가요?
                                    </a>
                                </div>
                                <div id="collapseTwo" class="collapse" data-parent="#accordionExample">
                                    <div class="card-body">
                                        <p>
											A. 가능합니다. 홈페이지 하단부의 대표전화(010-1234-5678)로 문의 바랍니다.
										</p>
                                    </div>
                                </div>
                            </div>
                            
                            
                            <div class="card">
                                <div class="card-heading">
                                    <a data-toggle="collapse" data-target="#collapseThree">
                                    	Q. 무통장 입금은 불가능 한가요??	
                                    </a>
                                </div>
                                <div id="collapseThree" class="collapse" data-parent="#accordionExample">
                                    <div class="card-body">
                                        <p>
											A. 가능합니다. 홈페이지 하단부의 대표전화(010-1234-5678)로 문의 바랍니다.
											
										</p>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
   <!--FAQ END-->



    <%@ include file="/WEB-INF/include/js-footer.jsp"%>
</body>

</html>