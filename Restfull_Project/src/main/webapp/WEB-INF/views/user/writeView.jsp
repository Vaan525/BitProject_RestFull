<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>RestFuLL | 글작성 </title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
		<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=fawtmt0h7b&submodules=geocoder"></script>

</head>
<body>
<%@ include file="/WEB-INF/include/js-header.jsp"%>

    <script>
        //임의의 file object영역
        var files = {};
        var previewIndex = 0;
 
        // image preview 기능 구현
        // input = file object[]
        function addPreview(input) {
            if (input[0].files) {
                //파일 선택이 여러개였을 시의 대응
                for (var fileIndex = 0; fileIndex < input[0].files.length; fileIndex++) {
                    var file = input[0].files[fileIndex];
 
                    if (validation(file.name))
                        continue;
 
                    var reader = new FileReader();
                    reader.onload = function(img) {
                        //div id="preview" 내에 동적코드추가.
                        //이 부분을 수정해서 이미지 링크 외 파일명, 사이즈 등의 부가설명을 할 수 있을 것이다.
                        var imgNum = previewIndex++;
                        $("#preview")
                              
                        .append(
                                        "<div class=\"preview-box\" value=\"" + imgNum +"\">"
                                                + "<img class=\"thumbnail\" src=\"" + img.target.result + "\"\/>"
                                                + "<a href=\"#\" value=\""
                                                + imgNum
                                                + "\" onclick=\"deletePreview(this)\">"
                                                + "X" + "</a>" + "</div>");
                        files[imgNum] = file;
                    };
                    reader.readAsDataURL(file);
                }
            } else
                alert('invalid file input'); // 첨부클릭 후 취소시의 대응책은 세우지 않았다.
        }
 
        //preview 영역에서 삭제 버튼 클릭시 해당 미리보기이미지 영역 삭제
        function deletePreview(obj) {
            var imgNum = obj.attributes['value'].value;
            delete files[imgNum];
            $("#preview .preview-box[value=" + imgNum + "]").remove();
            /*resizeHeight();*/
        }
 
        //client-side validation
        //always server-side validation required
        function validation(fileName) {
            fileName = fileName + "";
            var fileNameExtensionIndex = fileName.lastIndexOf('.') + 1;
            var fileNameExtension = fileName.toLowerCase().substring(
                    fileNameExtensionIndex, fileName.length);
            if (!((fileNameExtension === 'jpg')
                    || (fileNameExtension === 'gif') || (fileNameExtension === 'png'))) {
                alert('jpg, gif, png 확장자만 업로드 가능합니다.');
                
                return true;
            } else {
            	
                return false;
            }
        }
 
        $(document).ready(function() {
            //submit 등록. 실제로 submit type은 아니다.
            $('.write-btn').on('click',function() {                        
                var form = $('#boardForm')[0];
                var formData = new FormData(form);
    
                for (var index = 0; index < Object.keys(files).length; index++) {
                    //formData 공간에 files라는 이름으로 파일을 추가한다.
                    //동일명으로 계속 추가할 수 있다.
                    formData.append('files',files[index]);
                }
            });
            // <input type=file> 태그 기능 구현
            $('#attach input[type=file]').change(function() {
                addPreview($(this)); //preview form 추가하기
            });
        });
    </script>



<!-- <글쓰기 부분> -->

<section class="blog-details spad">
	<div class="container">
		<div class="row">
			<div class="col-lg-8 offset-lg-2">
				<div class="blog-details-inner">
					<div class="blog-detail-title">
						<form action="<%=request.getContextPath()%>/user/write" method="post" enctype="multipart/form-data" id="boardForm">
							<!-- hidden -->
							<sec:authentication var="principal" property="principal" />
							<input type="hidden" name="member_id" value="${principal.user.member_id}"/>
							<input type="hidden" name="boardlist_numbers" value="<c:out value='1'/>">
							<input type="hidden" name="filter_numbers" value="<c:out value='1'/>">
								
							<!-- write Data -->
							<div class="group-input">
	                     		<!-- 첨부 버튼 -->
								<div class="writepic">
									<div id="attach">
										<label for="uploadInputBox">📸사진첨부📸 👈🏻CLICK</label>
										<input id="uploadInputBox" style="display:none" type="file" name="file" accept="image/*" multiple />
	                          		</div>
	                                   
									<!-- 미리보기 영역 -->
									<div class="imgs_wrap">
										<div id="preview" class="content">
										</div>
									</div>
								</div>
							</div>
						
							<hr/>
							<!-- 제목,내용 -->		
							<div class="group-input">
								<div class="writetitle">
	 								<label for="title">제목 </label>
									<input type="text" name="title" class="write_tilte" maxlength="20" required>
								</div>
							</div>
									
							<input type="hidden" id="hidden_loc" name="location" maxlength="20" >
									
							<div class="group-input">
								<label for="contents">내용 </label>
								<div class="writecontentx">
									<textarea rows="10" cols="50" name="contents" class="write_content" placeholder="최대 500자 까지 작성 가능합니다." maxlength="500" required></textarea>
								</div>
							</div>
						</form> 
					<!-- 1차 form end -->
							
							
					<!-- 2차 form : 주소정보 등록 -->
					<!-- 위치 직접 지정하기 -->
					<div class="group-input">
						<label for="contents">위치 지정 </label>
						<div id="map"></div>
					</div>
					
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
															
															//가끔 x좌표와 y좌표가 뒤바뀌어서 저장됨. x에 125.~~~~ 처럼 30대가 아니고 120대 숫자가 찍히면 이부분의 x,y 위치를 바꿔주면 됨
								document.getElementById("gps-x").value = y;
								document.getElementById("gps-y").value = x;
							};
									
							function initGeocoder() {
								if (!map.isStyleMapReady) {
									return;
								}
									
								map.addListener('click', function(e) {
									searchCoordinateToAddress(e.coord);
								});
									

									                    }
									
							naver.maps.onJSContentLoaded = initGeocoder;
							naver.maps.Event.once(map, 'init_stylemap', initGeocoder);
						</script>
						<!-- naverMap script End -->
									          
						<!-- 입력할 주소 출력 -->
						<div class="maploc">	
							<form id="addressForm" name="destination-data" >
								<label>여행지명</label>
								<input id="destination_name" class="addform" name="destination_name" type="text" placeholder="여행지명을 입력해주세요" required="required">
								<br/>
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
							</form>
						</div>
						
						

						<!-- 작성 완료 버튼 -->
						<input type="button" class="site-btn write-btn" onclick="submitData()" value="글 게시" >
						
						<script type="text/javascript">
							function submitData(){
								// Get form
								var boardForm = $('#boardForm')[0];
								//여행지명을 게시글의 주소로 setting
							    boardForm.location.value = $('input[name="destination_name"]').val();
							        
								// Create an FormData object 
							    var boardData = new FormData(boardForm);
							        
							    $.ajax({
							        type: "POST",
							        enctype: 'multipart/form-data',
							        url: "${pageContext.request.contextPath}/user/writeMainPosting",
							        data: boardData,
							        dataType:"json",
							        processData: false,
							        contentType: false,
							        cache: false,
							        success: function (result) {
							            insertDest(JSON.parse(result));
							      	},
							      	error: function (e) {
							          	console.log("ERROR : ", e);
							           	alert("글을 등록하지 못했습니다. 다시 시도해주세요");
							      	}
							    });
							        
							        
							}
								
							function insertDest(result){
								var addressForm = new Object();
								addressForm.board_numbers = result;
								addressForm.destination_name = $('input[name="destination_name"]').val();
								addressForm.jibunaddress = $('input[name="jibunaddress"]').val();
								addressForm.doroaddress = $('input[name="doroaddress"]').val();
								addressForm.details = $('input[name="details"]').val();
								addressForm.lat = $('input[name="lat"]').val();
								addressForm.lng = $('input[name="lng"]').val();
										
					            console.log(addressForm);
					            console.log(addressForm.jibunaddress);
								$.ajax({
							        type: "POST",
							        url: "${pageContext.request.contextPath}/user/writeMainPosting_dest",
							        data: JSON.stringify(addressForm),
							        contentType:"application/json",
							        success: function () {
							        	location.href = "${pageContext.request.contextPath}/contentView?board_numbers=" + result;
							        },
							        error: function (xhr, status) {
							           alert(xhr + " : " + status);
							        }
							    });
							};
						</script>	
						
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
	
	
<%@ include file="/WEB-INF/include/js-footer.jsp"%>
</body>
</html>