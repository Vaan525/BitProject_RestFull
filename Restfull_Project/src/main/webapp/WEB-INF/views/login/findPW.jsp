<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	$(function(){
		$("#findBtn").click(function(){
			$.ajax({
				url : "doFindPW",
				type : "POST",
				data : {
					member_id : $("#member_id").val(),
					email : $("#email").val()
				},
				success : function(result) {
					alert(result);
				},
			})
		});
	})
</script>
<title>비밀번호 찾기</title>
</head>
<body>

<%@ include file="/WEB-INF/include/js-header.jsp"%>

    <!-- pw찾기 Section Begin -->
    <div class="register-login-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 offset-lg-4">
                    <div class="login-form">
                        <h2>비밀번호 찾기</h2>
                      	<div class="FindPW">  
                        	<div class="group-input">
			                    <label for="ID">ID</label>
			                     <input type="text" id="member_id" name="member_id" required>
							</div>
			               
			              	<div class="group-input">
			                    <label for="Email">Email</label>
			                    <input type="text" id="email" name="email" required>
			              	</div>
	               
							<button type="button" id="findBtn" class="site-btn find-btn">찾기</button>
							<button type="button" onclick="history.go(-1);" class="site-btn find-btn">취소</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
<%@ include file="/WEB-INF/include/js-footer.jsp"%>
</body>
</html>