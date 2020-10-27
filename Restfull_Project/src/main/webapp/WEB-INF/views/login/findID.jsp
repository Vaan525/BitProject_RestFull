<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>아이디 찾기</title>
</head>
<body>
<%@ include file="/WEB-INF/include/js-header.jsp"%>

    <!-- id찾기 Section Begin -->
    <div class="register-login-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 offset-lg-4">
                    <div class="login-form">
                        <h2>아이디 찾기</h2>
                        
						<form action="doFindID" method="post">
							<div class="FindID">
								<div class="group-input">
	                                <label for="Email">Email</label>
	                               <input type="text" id="email" name="email" required>
	                            </div>
	
								<button type="submit" id="findBtn" class="site-btn find-btn">찾기</button>
								<button type="button" onclick="history.go(-1);" class="site-btn find-btn">취소</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	
<%@ include file="/WEB-INF/include/js-footer.jsp"%>

</body>
</html>