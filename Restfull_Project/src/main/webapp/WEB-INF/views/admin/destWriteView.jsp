<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>RestFuLL | 여행지등록</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=fawtmt0h7b&submodules=geocoder"></script>
</head>

<body>
<%@ include file="/WEB-INF/include/js-header.jsp"%>
	<div class="text-center"><h2>여행지 등록</h2></div>

 <!-- Blog Section Begin -->
    <section class="blog-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-6 col-sm-8 order-2 order-lg-1">
                    <div class="blog-sidebar">
                        <div class="blog-catagory">
                            <h4>관리자페이지</h4>
                            <ul>
                                <li><a href="<c:url value="/admin/userList" />">유저 관리</a></li>
                                <li><a href="<c:url value="/admin/notice" />">공지사항 및 이벤트 관리</a></li>
                                <li><a href="<c:url value="/admin/qnas" />">문의 및 신고 답변</a></li>
                                <li><a href="<c:url value="/admin/dest" />">여행지 및 상품 관리</a></li>
                            	<li><a href="<c:url value="/admin/requestList" />">상품 주문내역 관리</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!--관리자페이지 여행지등록table start-->
                <div class="col-lg-9 order-1 order-lg-2">
                    <div class="row">
                        <div class="col-lg-12 col-sm-12">
                        	<div class="notice_write">
								<form method="post" action="write" class="dest_register">
									<div class="dest">
										<div class="group-input">
											<label for="destination"> 여행지 이름:</label>
											<input type="text" name="destination_name" id="destination_name"/>
										</div>
										
										<!-- 드롭다운으로 선택 / selected로 보내기-->
										<div class="group-input">
											<!-- 일단 여기는 하드코딩 나중에 시간 나면 ajax로 가져오도록 바꾸기 -->
											<div class="group-sido">
												<select name="sido" id="sido">
													<option value="11" selected>서울/경기</option>
													<option value="28">인천</option>
													<option value="42">강원</option>
													<option value="43">충북</option>
													<option value="44">충남/대전</option>
													<option value="47">경북/대구</option>
													<option value="48">경남/부산/울산</option>
													<option value="45">전북</option>
													<option value="46">전남/광주</option>
													<option value="50">제주</option>
												</select>
												<select name="sigungu_code" id="sigungu_code"></select>
											</div>
											
										</div>
										
										
										<div class="group-input">
											<label for="search"> 위치 검색</label>
												<input id="address" type="text" >
												<button type="submit" id="searchAddress">검색</button>
												
									    		<div id="map">
									    		</div>
									    </div>
									    
									   
									    
									   <!-- 입력할 주소 출력 -->
										<div class="maploc">	
											<label>지번주소</label>
											<input id="jibunAddr" class="addform" name="jibunaddress" type="text" readonly="readonly" >
											<br/>
											<label>도로명 주소 </label> 
											<input id="doroAddr" class="addform" name="doroaddress" type="text">
											<br/>
											<label>추가 주소 </label>
											<input id="detailAddr" class="addform" name="details" type="text">
											<br/>
											<label>x 좌표</label>
											<input id="gps-x" class="addform2" name="lat" type="text" readonly="readonly">
											<label>y 좌표</label>
											<input id="gps-y" class="addform2" name="lng" type="text"  readonly="readonly">

										</div>

									<button type="submit" id="submit">완료</button>
									</div>
								</form>
		                        <button type="button" onclick="history.go(-1);" class="gobackbtn">돌아가기</button>					
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
<%@ include file="/WEB-INF/include/js-footer.jsp"%>


</body>
 <!-- 시군구 코드 script -->
                <script>
					$(function(){
						function getOptionList(){
										
							var sidoCode = $("#sido option:selected").val();
									
							console.log("가져오는지 확인 sidoCode : " + sidoCode);								    
							$.ajax({
								url: "${pageContext.request.contextPath}/admin/dest/getSigunguCode/" + sidoCode,
								type: "GET",
								dataType:"json",
								success: function (result) {
							    //옵션 초기화
							       	$('#sigungu_code').empty();
								    $(result).each(function(){		
							           $('#sigungu_code').append('<option value="'+this.sigungu_code+'">'+this.sigunguName+'</option>');
							        })
								 }
										
							});
						};
						getOptionList();
						
						//변경이 생길 때마다 list 다시 가져오기
						$('#sido').on('change', function(){
							getOptionList();
						});
					});
						
				</script>
				
				 <!-- 맵 -->
									    <script>
						                    var map = new naver.maps.Map("map", {
						                    center: new naver.maps.LatLng(37.3595316, 127.1052133),
						                    zoom: 15,
						                    mapTypeControl: true
						                    });
						
						                    var infoWindow = new naver.maps.InfoWindow({
						                    anchorSkew: true
						                    });
						
						                    map.setCursor('pointer');
						                   
						                    function searchCoordinateToAddress(latlng) {
						
						                    infoWindow.close();
						
						                    naver.maps.Service.reverseGeocode({
						                        coords: latlng,
						                        orders: [
							                        naver.maps.Service.OrderType.ADDR,
							                        naver.maps.Service.OrderType.ROAD_ADDR
						                        ].join(',')
						                    }, function(status, response) {
						                        if (status === naver.maps.Service.Status.ERROR) {
						                        if (!latlng) {
						                            return alert('ReverseGeocode Error, Please check latlng');
						                        }
						                        if (latlng.toString) {
						                            return alert('ReverseGeocode Error, latlng:' + latlng.toString());
						                        }
						                        if (latlng.x && latlng.y) {
						                            return alert('ReverseGeocode Error, x:' + latlng.x + ', y:' + latlng.y);
						                        }
						                        return alert('ReverseGeocode Error, Please check latlng');
						                        }
						
						                        var address = response.v2.address,
						                            htmlAddresses = [];
						
						
						                        if (address.jibunAddress !== '') {
						                            htmlAddresses.push('[지번 주소] ' + address.jibunAddress);
						                        }
						
						                        if (address.roadAddress !== '') {
						                            htmlAddresses.push('[도로명 주소] ' + address.roadAddress);
						                        }
						
						                        infoWindow.setContent([
						                        '<div style="padding:10px;min-width:200px;line-height:150%;">',
						                        '<h4 style="margin-top:5px;">검색 좌표</h4>',
						                        '<button type="button" onclick="setAddressIntoBox()">입력</button><br />',
						                        htmlAddresses.join('<br />'),
						        	          	'<input id="x" type="hidden" value="'+ latlng.x + '"> ',
						        	          	'<input id="y" type="hidden" value="'+ latlng.y + '"> ',
						        	          	'<input id="jibunAddress" type="hidden" value="'+ address.jibunAddress + '"> ',
						        	          	'<input id="roadAddress" type="hidden" value="'+ address.roadAddress + '"> ',
						                        '</div>'
						                        ].join('\n'));
						                        
						                        console.log(" 좌표 검색  latlngs " + latlng.x + ", " + latlng.y);
						                        
						                        infoWindow.open(map, latlng);
						                    });
						                    }
						
						                    function searchAddressToCoordinate(address) {
						                    naver.maps.Service.geocode({
						                        query: address
						                    }, function(status, response) {
						                        if (status === naver.maps.Service.Status.ERROR) {
						                        if (!address) {
						                            return alert('Geocode Error, Please check address');
						                        }
						                        return alert('Geocode Error, address:' + address);
						                        }
						
						                        if (response.v2.meta.totalCount === 0) {
						                        return alert('No result.');
						                        }
						
						                        var htmlAddresses = [],
						                        item = response.v2.addresses[0],
						                        point = new naver.maps.Point(item.x, item.y);
						
						                        if (item.roadAddress) {
						                        htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
						                        }
						
						                        if (item.jibunAddress) {
						                        htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
						                        }
						
						                        if (item.englishAddress) {
						                        htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
						                        }
												
						                        infoWindow.setContent([
						                        '<div style="padding:10px;min-width:200px;line-height:150%;">',
						                        '<h4 style="margin-top:5px;">검색 주소 : '+ address +'</h4>',
						                        '<button type="button" onclick="setAddressIntoBox()">입력</button><br />',
						                        htmlAddresses.join('<br />'),
						        	          	'<input id="x" type="hidden" value="'+ item.x + '"> ',
						        	          	'<input id="y" type="hidden" value="'+ item.y + '"> ',
						        	          	'<input id="jibunAddress" type="hidden" value="'+ item.jibunAddress + '"> ',
						        	          	'<input id="roadAddress" type="hidden" value="'+ item.roadAddress + '"> ',
						                        '</div>'
						                        ].join('\n'));
													                        
						                        map.setCenter(point);
						                        infoWindow.open(map, point);
						                    });
						                    }
						
						
											function setAddressIntoBox() {
												
												var jibunAddr = $("#jibunAddress").val(); 
											    var doroAddr = $("#roadAddress").val(); 
												var x= $("#x").val();
												var y= $("#y").val();
													  	
												document.getElementById("jibunAddr").value = jibunAddr;
												document.getElementById("doroAddr").value = doroAddr;
												document.getElementById("gps-x").value = x;
												document.getElementById("gps-y").value = y;
						                    };
						
						                    function initGeocoder() {
						                    if (!map.isStyleMapReady) {
						                        return;
						                    }
						
						                    map.addListener('click', function(e) {
						                        searchCoordinateToAddress(e.coord);
						                    });
						
						                    $('#address').on('keydown', function(e) {
						                        var keyCode = e.which;
						
						                        if (keyCode === 13) { // Enter Key
						                        searchAddressToCoordinate($('#address').val());
						                        }
						                    });
						
						                    $('#searchAddress').on('click', function(e) {
						                        e.preventDefault();
						
						                        searchAddressToCoordinate($('#address').val());
						                    });
						
						                    
						                    }
						
						                    naver.maps.onJSContentLoaded = initGeocoder;
						                    naver.maps.Event.once(map, 'init_stylemap', initGeocoder);
						              	</script>
</html>