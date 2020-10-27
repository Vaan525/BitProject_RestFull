<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="s" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Fashi Template">
    <meta name="keywords" content="Fashi, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>RestFuLL | 약관동의</title>
   
</head>

<body>

<%@ include file="/WEB-INF/include/js-header.jsp"%>
    
<!--약관동의 체크박스 전체선택 전체해제--> 
<script>
    
   function check_all() {
        var checkObjs = $("input[name='chk']");
       
       if(checkObjs.length == $("input[name='chk']:checked").length) {
            checkObjs.prop("checked", false);
       }
       else {
           checkObjs.prop("checked", true);
       }
        
    };
    
    
/*필수 약관 동의 안할시 경고창*/
</script>
    
        <script type="text/javascript">
        $(document).ready(function(){
    
            $("#nextBtn").click(function(){    
                if($("#check_1").is(":checked") == false){
                    alert("필수 약관에 동의 하셔야 다음 단계로 이동합니다.");
                    return false;
                }else if($("#check_2").is(":checked") == false){
                    alert("필수 약관에 동의 하셔야 다음 단계로 이동합니다.");
                    return false;
                }else if($("#check_3").is(":checked") == false){
                    alert("필수 약관에 동의 하셔야 다음 단계로 이동합니다.");
                    return false;
                }else {
                	$("#terms_form").submit();
                }
            });    
        });
    </script>

    
    <!-- Register Confirm Section Begin -->
    <div class="register-login-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 offset-lg-3">
                    <div class="join-form" >
                        <h2>약관동의</h2>
                        <form action="${pageContext.request.contextPath}/join" id="terms_form" name="my_form" method="get">
                            <ul class="join_box">
                                <li class="checkBox check01">
                                    <ul class="clearfix">
                                        <li disabled>이용약관, 개인정보 수집 및 이용,
                                            위치정보 이용약관, 프로모션 안내
                                            메일 수신(선택)에 모두 동의합니다.</li>
                                        <li class="checkAllBtn">
                                            <input type="checkbox" id="chk_all" class="chkAll" onclick="check_all()" value="all선택">
                                        </li>
                                    </ul>
                                </li>
                                <li class="checkBox check02">
                                    <ul class="clearfix">
                                        <li>이용약관 동의(필수)</li>
                                        <li class="checkBtn">
                                            <input type="checkbox" name="chk" id="check_1"> 
                                        </li>
                                    </ul>
                                    
                                    <textarea disabled >제 1 조 (목적)

 이 약관은  RestfuLL 주식회사 ("RestfuLL회사" 또는 "RestfuLL")가 제공하는 RestfuLL 및 RestfuLL 관련 제반 서비스의 이용과 관련하여 회사와 회원과의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.

 제 2 조 (정의)
 이 약관에서 사용하는 용어의 정의는 다음과 같습니다.
 ①"서비스"라 함은 구현되는 단말기(PC, TV, 휴대형단말기 등의 각종 유무선 장치를 포함)와 상관없이 "회원"이 이용할 수 있는 RestfuLL 및 RestfuLL 관련 제반 서비스를 의미합니다.
 ②"회원"이라 함은 회사의 "서비스"에 접속하여 이 약관에 따라 "회사"와 이용계약을 체결하고 "회사"가 제공하는 "서비스"를 이용하는 고객을 말합니다.
 ③"아이디(ID)"라 함은 "회원"의 식별과 "서비스" 이용을 위하여 "회원"이 정하고 "회사"가 승인하는 문자와 숫자의 조합을 의미합니다.
 ④"비밀번호"라 함은 "회원"이 부여 받은 "아이디와 일치되는 "회원"임을 확인하고 비밀보호를 위해 "회원" 자신이 정한 문자 또는 숫자의 조합을 의미합니다.
 ⑤"게시물"이라 함은 "회원"이 "서비스"를 이용함에 있어 "서비스상"에 게시한 부호ㆍ문자ㆍ음성ㆍ음향ㆍ화상ㆍ동영상 등의 정보 형태의 글, 사진, 동영상 및 각종 파일과 링크 등을 의미합니다. 
                                    </textarea>
                                </li>
                                
                                <li class="checkBox check03">
                                    <ul class="clearfix">
                                        <li>개인정보 수집 및 이용에 대한 안내(필수)</li>
                                        <li class="checkBtn">
                                            <input type="checkbox" name="chk" id="check_2"> 
                                        </li>
                                    </ul>
 
                                    <textarea disabled >정보통신망법 규정에 따라 RestfuLL에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.
 
 1. 수집하는 개인정보
이용자는 회원가입을 하지 않아도 정보 검색, 뉴스 보기 등 대부분의 RestfuLL 서비스를 회원과 동일하게 이용할 수 있습니다. 이용자가 메일, 캘린더, 카페, 블로그 등과 같이 개인화 혹은 회원제 서비스를 이용하기 위해 회원가입을 할 경우, RestfuLL는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다.
                                    </textarea>
                                </li>
                                
                                <li class="checkBox check03">
                                    <ul class="clearfix">
                                        <li>위치정보 이용약관 동의(필수)</li>
                                        <li class="checkBtn">
                                            <input type="checkbox" name="chk" id="check_3"> 
                                        </li>
                                    </ul>

                                    <textarea disabled >위치정보 이용약관에 동의하시면, 위치를 활용한 광고 정보 수신 등을 포함하는 RestfuLL 위치기반 서비스를 이용할 수 있습니다.

제 1 조 (목적)
이 약관은 RestfuLL 주식회사 (이하 “RestfuLL”)가 제공하는 위치정보사업 또는 위치기반서비스사업과 관련하여 회사와 개인위치정보주체와의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.

제 2 조 (약관 외 준칙)
이 약관에 명시되지 않은 사항은 위치정보의 보호 및 이용 등에 관한 법률, 정보통신망 이용촉진 및 정보보호 등에 관한 법률, 전기통신기본법, 전기통신사업법 등 관계법령과 회사의 이용약관 및 개인정보취급방침, 회사가 별도로 정한 지침 등에 의합니다.

제 3 조 (서비스 내용 및 요금)
①회사는 직접 위치정보를 수집하거나 위치정보사업자인 이동통신사로부터 위치정보를 전달받아 아래와 같은 위치기반서비스를 제공합니다. 
1.Geo Tagging 서비스: 게시글 등록 시점의 개인위치정보주체의 위치정보를 게시글과 함께 저장합니다.
2.위치정보를 활용한 검색결과 제공 서비스: 정보 검색을 요청하거나 개인위치정보주체 또는 이동성 있는 기기의 위치정보를 제공 시 본 위치정보를 이용한 검색결과 및 주변결과(맛집, 주변업체, 교통수단 등)를 제시합니다.
3. 이용자 보호 및 부정 이용 방지: 개인위치정보주체 또는 이동성 있는 기기의 위치를 이용하여 권한없는 자의 비정상적인 서비스 이용 시도 등을 차단합니다.
                                    </textarea>
                                </li>
                                
                                <li class="checkBox check04">
                                    <ul class="clearfix">
                                        <li>이벤트 등 프로모션 알림 메일 수신(선택)</li>
                                        <li class="checkBtn">
                                            <input type="checkbox" name="chk" id="check_4"> 
                                        </li>
                                    </ul>

                                </li>
                            </ul>
                            
                            <button type="button" onclick="history.go(-1);" class="site-btn fpmgBt2">취소</button></li>
                            <button type="submit" class="site-btn fpmgBt2" id="nextBtn">다음</button></li>
                            
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Register Form Section End -->
    

<%@ include file="/WEB-INF/include/js-footer.jsp"%>
</body>

</html>