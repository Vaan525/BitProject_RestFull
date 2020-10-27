<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="s" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Fashi Template">
    <meta name="keywords" content="Fashi, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <!-- 로고 -->
	<link rel="shortcut icon" href="resources/img/o_1.ico"/>
	
    <title></title>
    
    <script src="resources/js/jquery-3.3.1.min.js"></script>
    <script src="resources/js/popper.js"></script>
    <script src="resources/js/bootstrap.min.js"></script>
    
    <!-- 자동완성 cdn -->
     <link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> 
	
	<!-- 소셜로그인 --> 
    <script type="text/javascript" src="https://static.nid.naver.com/resources/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>


    <!-- Css Styles -->
    <link rel="stylesheet" href="resources/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="resources/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="resources/css/themify-icons.css" type="text/css">
    <link rel="stylesheet" href="resources/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="resources/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="resources/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="resources/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="resources/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="resources/css/style.css" type="text/css">
    
	 <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css?family=Muli:300,400,500,600,700,800,900&display=swap" rel="stylesheet">
    
</head>




<body>

    <!-- Header Section Begin -->
    <header class="header-section">

         
 		<!-- 자동완성 자바스크립트 -->
        <script>
        $(function() {
        	
	        var searchSource = [
				"부산","부천","부경",
				"서울","서산","광주","전주","여수","여주","대전",
				"제주도","거제도","인천","양양","강릉"
	        ];
	        
	        $("#searchbox").autocomplete({
	        	source: searchSource,
	        	select : function(event, ui) {
	        		console.log(ui.item);
	        	},
	        	focus :function(event, ui) {
	        		return false;
	        	},
	        	minLength:1,
	        	autoFocus : true,
	        	classes : {
	        		"ui-autocomplete" : "highlight"
	        	},
	        	delay : 500,
	        	close : function(event) {
	        		console.log(event);
	        	}
	        	
	        });
  
   		 });
        </script>
         
        <div class="container">
                <div class="inner-header">
                    <div class="row">
                        <div class="col-lg-2 col-md-2">
                            <div class="logo">
                                <a href="${pageContext.request.contextPath}/">
                                    <img src="resources/img/LOGOsmall.png" alt="">
                                </a>
                            </div>
                        </div>
                         <div class="col-lg-6 col-md-6 offset-lg-1 search-top">
                           <form name="searchform" method="get" action="${pageContext.request.contextPath}/search">
                                <div class="advanced-search">
                                    <div class="input-group">
	                                    <input type="hidden" name="boardlist_numbers" value="<c:out value='1'/>">
                                        <input type="text" name="searchWord" id="searchWord" placeholder="어느 지역으로 여행을 가시나요?">
                                        <button type="submit" id="submit" value="검색"><i class="ti-search"></i></button>
                                    </div>
                                </div>
                            </form>
                        </div>
                        
                        <div class="col-lg-3 col-md-3 order-last">
			             	<div class="ht-right">
				             	<c:if test="${member_id eq null}">
					           		<sec:authorize access="isAnonymous()">
					                    <button type="button" class="login-panel">
					                   		 <a href="${pageContext.request.contextPath}/login">로그인</a>  
					                 	</button>
					                </sec:authorize>
					             </c:if>
					             
					             
				             	 <sec:authorize access="isAuthenticated()">
									<div class="showloign">
			 	             			<sec:authentication var="principal" property="principal"/>
			 	             			<input type="hidden" name="member_id" value="${principal.user.member_id}"/>
				             			<c:if test="${principal.user.authority_name == 'ROLE_USER'}">
				             				<div class="userlogin">
												<strong>${principal.user.name}</strong>님
									        	<a href="<c:url value="/user/userModify" />">🏠‍</a>
									    	</div>
									    </c:if>
								            
								        <c:if test="${principal.user.authority_name == 'ROLE_ADMIN'}">
						            		<a href="<c:url value="/admin/userList" />">👾관리자 홈👾</a>
								        </c:if>
								        
										<form:form action="${pageContext.request.contextPath}/logout" method="POST">
											<input type="submit" id="logoutsubmit" value="로그아웃" />
										</form:form>
									</div>
						        </sec:authorize>
						    </div>
			           </div>  
			      </div>
			</div>
		</div>

  
        <div class="nav-item">
            <div class="container">
                <nav class="nav-menu mobile-menu">
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/user/writeView">글작성</a></li>
                        <li><a href="${pageContext.request.contextPath}/travel/">여행코스작성</a></li>
                        <li><a href="${pageContext.request.contextPath}/notice/<c:out value='2'/>">공지사항</a></li>
                        <li><a href="${pageContext.request.contextPath}/notice/<c:out value='5'/>">이벤트</a></li>
                        <li><a href="${pageContext.request.contextPath}/FAQ">자주하는질문</a></li>
                    </ul>
                </nav>
               <div id="mobile-menu-wrap"></div>
            </div>
        </div>
        
        
    </header>
</body>
</html>