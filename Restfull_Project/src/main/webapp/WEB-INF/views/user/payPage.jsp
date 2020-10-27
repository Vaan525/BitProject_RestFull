<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>결제 임시 페이지</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>

<body>

<h1>결제 임시 페이지.</h1>

<h3>[<a href="<c:url value="/home" />">홈으로 돌아가기.</a>]</h3>

<table width="500" cellpadding="0" cellspacing="0" border="1">
		<tr>
			<td>상품 이름</td>
			<td>상품 가격</td>
			<td>상품 여행지</td>
		</tr>
		<c:forEach items="${goodsPay}" var="goodsPay">
		<tr>
			<td>${goodsPay.name}</a></td>
			<td>${goodsPay.price}</td>
			<td>${goodsPay.destination_name}</td>
			<%-- <td>
				<c:forEach begin="1" end="${dto.bIndent}">-</c:forEach>
				<c:forEach begin="1" end="12">-</c:forEach>
				<a href="contentView?board_count=${restful.board_count}">${restful.title}</a></td> --%>
		</tr>
		</c:forEach>
	</table>
 


</body>


</body>
</html>