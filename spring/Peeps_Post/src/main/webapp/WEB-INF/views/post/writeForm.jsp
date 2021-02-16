<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>test</title>
</head>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap')
	;
</style>

<style>
.post_wrap {
	width: 1000px;
	height: auto;
	background-color: white;
	margin: 200px auto;
	border: 1px solid #eef0ed;
}

.post {
	margin: 80px auto 65px;
}

.pdate_wrap {
	text-align: right;
	height: 40px;
	font-family: 'Nanum Gothic', sans-serif;
	font-weight: 800;
}

.ptitle {
	border: 1px solid;
	width: 770px;
	height: 50px;
	margin-bottom: 15px;
	font-size: 1.5em;
	padding: 5px 15px;
}

.post_photoinput {
	margin: 20px 0;
}

.pcontent {
	resize: none;
	width: 770px;
	height: 600px;
	font-size: 1.4em;
	padding: 15px;
	margin-bottom: 5px;
}

.pcontent::-webkit-scrollbar {
	display: none;
}
/* 스크롤바 숨김 & 스크롤 정상 작동 */
.post_cnclorsubmt {
	text-align: right;
}

.post_cnclorsubmt>input {
	margin: 20px 0 0 20px;
	width: 100px;
	height: 40px;
	font-size: 1.1em;
	font-family: 'Nanum Gothic', sans-serif;
}

#imguploadbtn {
	width: 45px;
	height: 45px;
}

#preview {
	width: 800px;
	min-height: 50px;
	margin: 15px 0px;
	border: 1px solid #ccc;
}

.selProductFile {
	width: 180px;
	height: 180px;
	margin: 10px;
}

.plocwrap {
	margin: 10px 0;
}

.searchlocbtn {
	border: 0px solid;
	background-color: #ccc;
	border-radius: 5px;
	width: 80px;
	height: 35px;
	margin: 5px 0;
}

.searchlocBox {
	border: 0px solid;
	background-color: transparent;
	cursor: default;
}

body {
	background-color: #fcf9f6;
	font-family: 'Nanum Gothic', sans-serif;
}
</style>

<!--jquery 라이브러리 로드-->
<script src="https://code.jquery.com/jquery-1.12.4.min.js" 
		integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" 
		crossorigin="anonymous">
</script>    

<script>
        
        $(document).ready(function(){
            
            // 게시글 글자 수 제한
            $('textarea').keyup(function(){
                // 현재 입력 문자열의 길이
                var inputStrLen = $(this).val().length;
                if(inputStrLen>1500){
                    alert('1500자 까지만 입력이 가능합니다.');
                    var userInput = $(this).val().substr(0,1500);
                    $(this).val(userInput);
                    inputStrLen = 1500;
                }
                $('#textnumber').text(inputStrLen);
            });
            
            // 제목 글자 수 제한
            $('.ptitle').keyup(function(){
                // 현재 입력 문자열의 길이
                var inputStrLen = $(this).val().length;
                if(inputStrLen>30){
                    alert('30자 까지만 입력이 가능합니다.');
                    var userInput = $(this).val().substr(0,30);
                    $(this).val(userInput);
                    inputStrLen = 30;
                }
                /* $('#textnumber').text(inputStrLen); */
            });
            
            
            // 파일 업로드 버튼 클릭 후 파일 선택
            $("#postformfile").on("change", handleImgFileSelect);
            
            
            // 파일 submit
            $("#submitbtn").on("click", function(e){
            	
            	var formData = new FormData();
            	
            	var inputFile = $("input[name='postformfile']");
            	
            	var files = inputFile[0].files;
            	
            	console.log(files);
            	
            	for(var i=0; i<files.length; i++){
            		formData.append("postformfile", files[i]);
            	}
            	
            	console.log(formData);
            	
            	$.ajax({
            		url: '${pageContext.request.contextPath}/post/ajaxupload',
            		processData: false,
            		contentType: false,
            		data: formData,
            		type: 'POST',
            		enctype: 'multipart/form-data', 

            		success: function(result){
            			alert("업로드 성공");
            		},
            		error: function(e){
            			alert("업로드 실패");
            		}
            	});
            })
             
        });
        
     	// 파일 업로드 버튼 클릭
        function fileUploadAction() {
            console.log("fileUploadAction");
            $("#postformfile").trigger('click');
        }
        
        // 파일 업로드 메서드
        function handleImgFileSelect(e){
        	// 이미지 개수 제한
		      if(e.target.files.length>20){
		    	  alert("이미지는 20개까지 업로드 가능합니다.")
		    	  $("input[type='file']").val("");
		    	  return false;
		      }
        	
        	// 이미지 정보들을 초기화
            sel_files = [];
            $(".preview").empty();
 
            var files = e.target.files;
            var filesArr = Array.prototype.slice.call(files);
 
            var index = 0;
            
            // 이미지 확장자 이외 제한
            filesArr.forEach(function(f) {
                if(!f.type.match("image.*")) {
                    alert("확장자는 이미지 확장자만 가능합니다.");
                    return;
                }
 
                sel_files.push(f);
 
                var reader = new FileReader();
                reader.onload = function(e) {
                	var html = "<a href=\"javascript:void(0);\" onclick=\"deleteImageAction("+index+")\" id=\"img_id_"+index+"\">"
                		html += "<img src=\"" + e.target.result + "\" data-file='"+f.name+"' class='selProductFile' title='Click to remove'></a>";
                	
                	$(".preview").append(html);
                    index++;
 
                }
                reader.readAsDataURL(f);
                
            });
        }
        
        // 파일 개별 취소
        function deleteImageAction(index) {            
            console.log("index : "+index);
            sel_files.splice(index, 1);
 
            var img_id = "#img_id_"+index;
            $(img_id).remove();
 
            console.log(sel_files);
        }      
    
</script>


<body>



	<div class="post_wrap">
		<form method="post" enctype="multipart/form-data">
		<table class="post">
			<tr>
				<td>
					<input type="hidden" name="userIdx" value="1">
				</td>
			</tr>
			<!-- 날짜 -->
			<tr>
				<td class="pdate_wrap">
					<%
					Date now = new Date();
					SimpleDateFormat ymd = new SimpleDateFormat("yyyy.MM.dd");
					SimpleDateFormat hms = new SimpleDateFormat("hh.mm.ss");
					%>
					<div class="pdate"><%= ymd.format(now) %></div>
				</td>
			</tr>
			<!-- 제목 -->
			<tr>
				<td>
					<input type="text" class="ptitle" name="ptitle" placeholder="제목을 입력해주세요." required>
				</td>
			</tr>
			<!-- 파일 -->
			<tr>
				<td>
					<input type="hidden" class="pthumbnail" name="pthumbnail" value="">
					<div>
						<input type="file" accept="image/*" 
						name="postformfile" id="postformfile"
						multiple hidden>
						<a href="javascript:" onclick="fileUploadAction();" class="my_button">
						<img id="imguploadbtn" src="<c:url value="/resources/img/imguploadbtn.png"/>"/>
						</a>
					</div>
					<!-- 파일 프리뷰 -->
					<div id="preview" class="preview">
        			</div>
				</td>
			</tr>
			<!-- 글 내용 -->
			<tr>
				<td>
					<textarea rows="50"  
							  class="pcontent" name="pcontent"
							  placeholder="내용을 입력해주세요." required
					></textarea>
					<div><span id="textnumber">0</span>/1500</div>
				</td>
			</tr>
			<!-- 위치 추가 -->
			<tr>
				<td>
					<div class="plocwrap">
					<input type="button" class="searchlocbtn" 
					onclick="sample5_execDaumPostcode()" value="위치 추가">
					<input type="text" id="sample5_address" name="ploc" class="searchlocBox" 
						onfocus="this.blur()"
					readonly>
					<br>
					<div id="map"
						style="width: 800px; height: 300px; margin-top: 10px; display: none"></div>
				
					<script
						src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
					<script
						src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3ed6849fd6d5d015aebf82a3eb747333&libraries=services"></script>
					<script>
						var mapContainer = document.getElementById('map'), // 지도를 표시할 div
						mapOption = {
							center : new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
							draggable: false, // 확대축소 & 드래그 막기
							level : 3
						// 지도의 확대 레벨
						};
						
						//지도를 미리 생성
						var map = new daum.maps.Map(mapContainer, mapOption);
						//주소-좌표 변환 객체를 생성
						var geocoder = new daum.maps.services.Geocoder();
						//마커를 미리 생성
						var marker = new daum.maps.Marker({
							position : new daum.maps.LatLng(37.537187, 127.005476),
							map : map
						});
				
						function sample5_execDaumPostcode() {
							new daum.Postcode({
								oncomplete : function(data) {
									var addr = data.address; // 최종 주소 변수
				
									// 주소 정보를 해당 필드에 넣는다.
									document.getElementById("sample5_address").value = addr;
									// 주소로 상세 정보를 검색
									geocoder.addressSearch(data.address, function(results,
											status) {
										// 정상적으로 검색이 완료됐으면
										if (status === daum.maps.services.Status.OK) {
				
											var result = results[0]; //첫번째 결과의 값을 활용
				
											// 해당 주소에 대한 좌표를 받아서
											var coords = new daum.maps.LatLng(result.y,
													result.x);
											// 지도를 보여준다.
											mapContainer.style.display = "block";
											map.relayout();
											// 지도 중심을 변경한다.
											map.setCenter(coords);
											// 마커를 결과값으로 받은 위치로 옮긴다.
											marker.setPosition(coords)
										}
									});
								}
							}).open();
						}
					</script>
					</div>
				</td>
			</tr>
			<!-- 버튼 -->
			<tr>
				<td class="post_cnclorsubmt">
					<input type="button" value="취소">
					<input type="submit" value="등록" id="submitbtn">
				</td>
			</tr>
		</table>
		</form>
	</div>

</body>
</html>
