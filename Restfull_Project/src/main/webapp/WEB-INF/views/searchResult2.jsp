<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=fawtmt0h7b"></script>
	<script type="text/javascript" src="resources/js/MarkerClustering.js"></script>

	<style>
		.container contents {
			background-color: white;
		}
		
		.main-postings{
			background-color: white;
			display:inline-block;
			border: 1px solid black;
			width:300px;
			height:350px;
			text-align:center;
			position:absolute;
			padding: 30px  20px  30px  20px;
			margin:10px 10px 10px 10px;
		}
	</style>
							
</head>
<body>
<%@ include file="/WEB-INF/include/js-header.jsp"%>
	<!-- 게시글 목록 -->
	
	
	<div class="container contents">
		<div class="row">
		<!-- 게시물 list -->
			<div style="width:50%; height:500px; float:left">
				<h2>리스트 뽑기</h2>
					<c:forEach items="${boardlist}" var="vo">
						<div class="col-xs-6 col-md-3 main-postings">
						    <a href="contentView?board_numbers=${vo.board_numbers}" class="thumbnail">
						      <img src="${vo.thumbnail }"/>
						      <div class="caption">
					                <h3>${vo.title}</h3>
					                <p>${vo.location}</p>
					                <p>${vo.destinationVO.jibunaddress}</p>
					                <input type="hidden" name="lat" value="${vo.destinationVO.lat}"/>
					                <input type="hidden" name="lng" value="${vo.destinationVO.lng}"/>
					          </div>
						    </a>
						</div>
					</c:forEach>
			</div>
			<c:if test="${paging.startPage != 1 }">
			<a href="search?boardlist_numbers=${boardlist_numbers}&searchWord=${searchWord}&nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&lt;</a>
		</c:if>
		<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
			<c:choose>
				<c:when test="${p == paging.nowPage }">
					<b>${p }</b>
				</c:when>
				<c:when test="${p != paging.nowPage }">
					<a href="search?boardlist_numbers=${boardlist_numbers}&searchWord=${searchWord}&nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.endPage != paging.lastPage}">
			<a href="search?boardlist_numbers=${boardlist_numbers}&searchWord=${searchWord}&nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&gt;</a>
		</c:if>
		</div>
	</div>
	
	
	
	
	<!-- 지도 -->
	<div id="map" style="width:100%; height:500px;"></div>
	
	
	<script>
		$(document).ready(function(){
			var divLength = $('div .main-postings').val();
			
			console.log("divLength" + divLength);
				//1. 지도 세팅.임시로 지도의 센터를 첫 게시물의 좌표에 맞춰둠(검색했을 때 지도 중심을 어디로 놓아야 될지, 어떻게 해야될지 의논...)
				//1-1. 지도 세팅을 위한 center 좌표 가져오기. 알아서 자동으로 첫번째 좌표 반환하는 듯
				var centerX = $('input[name="lat"]').val(),
					centerY = $('input[name="lng"]').val();
				console.log(centerX,centerY);
				
				//1-2. 지도 생성. center에 지도 중앙 좌표 입력
				var map = new naver.maps.Map('map', {
				    center: new naver.maps.LatLng(centerX, centerY),
				    zoom: 15
				}); 
				
				var xs = $('input[name="lat"]');
				var ys = $('input[name="lng"]');
				
				console.log("xs:" + xs);
				console.log("ys:" + ys);
				
				//2. 마커 찍기.
				//2-1. 마커를 찍을 좌표 리스트를 뽑기 위한 레코드 수 계산(x,y 좌표 분리)
				var records = $("input[name=lat]").length;
				console.log("게시물 수 : " + records);
				
				//배열 생성
				var latlngX = new Array();
				var latlngY = new Array();
				
				//배열에 값 주입
				for(var i=0; i<records; i++){                          
					latlngX[i] = $("input[name=lat]").eq(i).val();
				}
				
				for(var i=0; i<records; i++){                          
					latlngY[i] = $("input[name=lng]").eq(i).val();
				}
				
				console.log(latlngX);
				console.log(latlngY);

				var latlngs=new Array();
				//x,y좌표 합치기
				for(var i=0; i<records; i++){                          
					latlngs.push(new naver.maps.LatLng(latlngX[i], latlngY[i]));
				}
				console.log("test 출력 - 좌표들 : "+latlngs);
				
				//2-3. 좌표 배열(latlngs배열)을 마커의 position으로 지정하여 배열 수만큼 마커를 생성함
							
				var markers=new Array();
				
				for (var i=0, ii=latlngs.length; i<ii; i++) {
				    var marker = new naver.maps.Marker({
				        position: latlngs[i],
				        map: map
				    });
				    
				    markers.push(marker);
				}
				
				var htmlMarker1 = {
				        content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(resources/img/cluster-marker-1.png);background-size:contain;"></div>',
				        size: N.Size(40, 40),
				        anchor: N.Point(20, 20)
				    },
				    htmlMarker2 = {
				        content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(resources/img/cluster-marker-2.png);background-size:contain;"></div>',
				        size: N.Size(40, 40),
				        anchor: N.Point(20, 20)
				    },
				    htmlMarker3 = {
				        content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(resources/img/cluster-marker-3.png);background-size:contain;"></div>',
				        size: N.Size(40, 40),
				        anchor: N.Point(20, 20)
				    },
				    htmlMarker4 = {
				        content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(resources/img/cluster-marker-4.png);background-size:contain;"></div>',
				        size: N.Size(40, 40),
				        anchor: N.Point(20, 20)
				    },
				    htmlMarker5 = {
				        content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(resources/img/cluster-marker-5.png);background-size:contain;"></div>',
				        size: N.Size(40, 40),
				        anchor: N.Point(20, 20)
				    };
				
				
				var markerClustering = new MarkerClustering({
			        minClusterSize: 2,
			        maxZoom: 15, //map 변수와 똑같이 설정
			        map: map,
			        markers: markers,
			        disableClickZoom: false,
			        gridSize: 120,
			        icons: [htmlMarker1, htmlMarker2, htmlMarker3, htmlMarker4, htmlMarker5],
			        indexGenerator: [10, 100, 200, 500, 1000],
			        stylingFunction: function(clusterMarker, count) {
			            $(clusterMarker.getElement()).find('div:first-child').text(count);
			        }
			    });
				
			});
	</script>
	

<hr/>
<%@ include file="/WEB-INF/include/js-footer.jsp"%>

</body>

</html>