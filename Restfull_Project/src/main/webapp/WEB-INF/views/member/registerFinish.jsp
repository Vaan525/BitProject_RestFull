<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>RestFuLL | 가입완료</title>
   

</head>

<body>

<%@ include file="/WEB-INF/include/js-header.jsp"%>
    <!-- Register Section Begin -->
    <div class="register-login-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 offset-lg-4">
                    <div class="register-form">
                        <h2>가입완료</h2>
							<button type="submit" class="site-btn home-btn"><a href="${pageContext.request.contextPath}/">홈으로</a></button>
                            <button type="submit" class="site-btn home-btn"><a href="${pageContext.request.contextPath}/login">로그인</a></button>    		
                   </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Register Form Section End -->
    

 	<%@ include file="/WEB-INF/include/js-footer.jsp"%>
	</body>
</html>