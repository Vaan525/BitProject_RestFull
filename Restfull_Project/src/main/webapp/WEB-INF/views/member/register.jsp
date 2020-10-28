<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>RestFuLL | 회원가입</title>
</head> 
<body>  

<%@ include file="/WEB-INF/include/js-header.jsp"%>

   

    <!-- Register Section Begin -->
    <div class="register-login-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 offset-lg-4">
                    <div class="register-form">
                        <h2>회원가입</h2>
                        <form action="addUser" name="userInfo" method="post" id ="pwForm">
                           <!--아이디 입력창-->
                            <div class="group-input">
                                <label for="member_id">아이디</label>
                                <input type="text" id="member_id" name="member_id" maxlength="50" required>
                                <input type="button"  class="con-id" value="중복확인" onclick="chkId()">
                                
                            </div>
                            <!--비밀번호 입력창-->
                            <div class="group-input">
                                <label for="password">비밀번호</label>
                                <input type="password" id="pw" name="pw" maxlength="50" placeholder="비밀번호 입력" required>
                            </div>
                            <!--비밀번호 재확인 입력창-->
                            <div class="group-input">
                                <label for="con-password">비밀번호 확인</label>
                                <input type="password" id="pw2" name="pw2" maxlength="50" placeholder="비밀번호 재입력" required>
                            </div>
                            <!--이름 입력창-->
                             <div class="group-input">
                                <label for="name">이름</label>
                                <input type="text" id="name" name="name" required>
                            </div>
                            
                            <!--   <!--생년월일 입력창!!!!!!!!!!!-->
                            <div class="group-input">
                            	<label for="birth">생년월일</label>
                            	<input type="date" id="birth" name="birth" min="1960-01-01" max="2000-12-31" required> 
                            </div>

                            <!--성별 입력창-->
                                <div class="gender">
                                <label for="gender" style="font">성별</label>
                                <div class="row">
                                    <div class="form-check col">
                                        <input class="form-check-input" type="radio" id="gender" name="gender"  value="man" checked>
                                        <label class="form-check-label" for="exampleRadios1">
                                            남자
                                        </label>
                                    </div>
                                    <div class="form-check col">
                                        <input class="form-check-input" type="radio" name="gender" value="woman">
                                        <label class="form-check-label" for="exampleRadios2">
                                            여자
                                        </label>
                                    </div>
                                </div>
                                </div>
                            

                            <!--이메일 입력창-->
                            <div class="group-input">
                                <label for="email">이메일</label>
                                <input type="text" id="email" name="email" aria-describedby="emailHelp" placeholder="이메일주소 입력" required>
                            </div>
                            

                            <input type="submit" class="site-btn register-btn" value="회원가입"/>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

	
	
	
	<%@ include file="/WEB-INF/include/js-footer.jsp"%>
	</body>
	
	<script>
    var chkId = false;
    var regexp = /[0-9a-zA-Z]/;
    var text = $("#member_id").val();
    
    $(function() {
    	
		if($("#pwForm").submit(function() {
			if($("#pw").val() !== $("#pw2").val()){
				alert("비밀번호가 다릅니다.");
				$("#pw").val("").focus();
				$("#pw2").val("");
				return false;
			}else if ($("#pw").val().length < 8) {
				alert("비밀번호는 8자 이상으로 설정해야 합니다.");
				$("#pw").val("").focus();
				return false;
			}else if($.trim($("#pw").val()) !== $("#pw").val()) {
				alert("공백은 입력이 불가능합니다.");
				return false;
			}
			else if($("#member_id").val()==""){
				alert("아이디를 입력해주세요.");
				$("#member_id").focus();
				return false;
			}
			else if($("#pw").val()==""){
				alert("비밀번호를 입력해주세요.");
				$("#pw").focus();
				return false;
			}
			else if($("#name").val()==""){
				alert("이름을 입력해주세요.");
				$("#name").focus();
				return false;
			}
			else if($("#birth").val()==""){
				alert("생년월일을 입력해주세요.");
				$("#birth").focus();
				return false;
			}
			
			else if($("#gender").val()==""){
				alert("성별을 입력해주세요.");
				$("#gender").focus();
				return false;
			}

			else if($("#email").val()==""){
				alert("이메일을 입력해주세요.");
				$("#email").focus();
				return false;
			} 
			else if(chkId == false) {
				alert("아이디 중복 체크를 진행해주세요.");
	    		console.log("id check is not done")
	    		chkId = false;
	    		return false;
			}
			else if(chkId == true){
				console.log("id check is done")
				chkId = true;
				return false;
			}
		}));
		
		 for(var i = 0; i < text.length; i++){
				if(text.charAt(i) != " " && regexp.text(text.charAt(i)) == false){
					alert("한글 및 특수문자는 입력이 불가능 합니다.");
					$('#member_id').val("");
					return;
				}
				if(text.length < 4){
					alert("ID는 4자 이상입니다.");
					$('#member_id').val("");
					return;
				}
			}
		
		
	});
    </script>
    
    <script>
    function onlyNumber(){
        if((event.keyCode<48)||(event.keyCode>57))
           event.returnValue=false;
	}
	</script>
	
	<script>
	function chkId() {
		var id = $('#member_id').val();
		
		$.ajax({
			url : "idCheck",
			type : "GET",
			dataType : "text",
			contentType: 'text/plain; charset=utf-8',
			data : {id},
			
			success : function(data) {	//data : checkSignup에서 넘겨준 결과값
				var result = JSON.parse(data);
				var checkSuccess = result.statusCode === 200;
				
				if(checkSuccess){
					alert("사용 가능한 아이디 입니다.");
				} else {
					alert("사용 불가능한 아이디 입니다.");
					checkSuccess = 400;
				}
				
	         }, 
	         error : function(req, status, errThrown) {
			 alert("network error occur");
			}
		});
	}	
	</script>
	
	<!-- 휴대폰 인증 js -->
	<script> 
		
		function sendSms() { 
					$.ajax({ 
						url: "<%=request.getContextPath()%>/sendSms",
						data: { 
							receiver: $("#phone").val() 
						},
						type: "post",
						success: function(success) {
									
									console.log("인증문자 전송 성공");
									alert("인증문자 전송 성공");
									/* if (result == "true") {
										console.log("result11="+result)
										console.log(result); 
									} else { 
										console.log("result22="+result)
										alert("인증번호 전송 실패"); 
									}  */
						},
						error: function(error){
								console.log("인증문자 전송 실패");
								alert("인증문자 전송 실패");
							
						}
					}); 
		} 
		function phoneCheck() { 
					$.ajax({ url: "<%=request.getContextPath()%>/smsCheck",
						type : "post",
						data : { 
							code : $("#sms").val(),
						},
						success : function(result) {
										console.log("result1="+result)
										console.log("code="+$("#sms").val())
									
									if (result == "ok") {
										console.log("resultOk="+result)
										alert("번호 인증 성공");
									} else {
										console.log("resultFail="+result)
										alert("번호 인증 실패");
									}
						}
					});
		}
		</script>
	
	 
</html>