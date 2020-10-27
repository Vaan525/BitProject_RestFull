<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<title>아이디 찾기 검색결과</title>
</head>
<body>

<%@ include file="/WEB-INF/include/js-header.jsp"%>

    <!-- id찾기 검색결과 Section Begin -->
    <div class="register-login-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 offset-lg-4">
                    <div class="login-form">
                        <h2>아이디 찾기 검색결과</h2>
						<div class="FindID">
							<h5>
								${ id }
							</h5>
							<button type="button" id="loginBtn" class="site-btn find-btn">로그인</button>
							<button type="button" onclick="history.go(-1);" class="site-btn find-btn">취소</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
<%@ include file="/WEB-INF/include/js-footer.jsp"%>
	
</body>

<script>
	$(function(){
		$("#loginBtn").click(function(){
			location.href='login';
		})
	})
</script>
</html>