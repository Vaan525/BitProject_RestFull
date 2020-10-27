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
</head>
<body>
            
            <input type="hidden" name="goods_numbers" value="${contentView.goods_numbers}">
            <div class="container">
            <a class="dropdown-item" href="modify?goods_numbers=${contentView.goods_numbers}">수정</a>
            <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dest/${contentView.destination_name}/goods/delete?goods_numbers=${contentView.goods_numbers}">삭제</a>
            
               <h4>상품 정보</h4><hr/>
               <div class="board-contents">
                  여행지명 : ${contentView.destination_name}<hr/>
                  ------상품정보----------------------------------------<br/>
                  판매업자 : <span>${contentView.seller}</span><br/>
                  상품명 : <span>${contentView.name}</span><br/>
                  상품 가격 : <span>${contentView.price}</span><br/>
                  상품 재고수량: <span>${contentView.amount}</span><br/>
                  상품 판매 상태 : <span>${contentView.status}</span><br/>
                  상품 판매 시작일 : <span>${contentView.sellstart}</span><br/>
                  상품 판매 종료일 : <span>${contentView.sellend}</span><br/>
               <hr/>
               </div>
   
</body>
</html>