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
    <title>RestFuLL | 메인페이지</title>

</head>

<body>

<%@ include file="/WEB-INF/include/js-header.jsp"%>


    <!-- Hero Section Begin -->
    <section class="hero-section">
        <div class="hero-items owl-carousel">
            <div class="single-hero-items set-bg" data-setbg="resources/img/KR_15.jpg">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-5">
                            <h3>휴식 가득한 여행</h3>
                            <p></p>
                            
                            <!--<a href="#" class="primary-btn"></a>-->
                        </div>
                    </div>
                </div>
            </div>

            <div class="single-hero-items set-bg" data-setbg="resources/img/KR_1.jpg">
            </div>

            <div class="single-hero-items set-bg" data-setbg="resources/img/KR_3.jpg">
            </div>


            <div class="single-hero-items set-bg" data-setbg="resources/img/KR_7.jpg">
            </div>
            
           	<div class="single-hero-items set-bg" data-setbg="resources/img/KR_8.jpg">
            </div>

        </div>
    </section>
    <!-- Hero Section End -->


<%@ include file="/WEB-INF/include/js-footer.jsp"%>


</body>

</html>