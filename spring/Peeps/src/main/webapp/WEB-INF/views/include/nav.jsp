<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title></title>
</head>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<body>

	<!-- nav -->
	<div id="nav">
		<nav>
			<ul class="icon">

				<li class="left"><span><input type="search" id="search" placeholder="검색">
						<button id="keyword" type="submit">
							<img
								src="<c:url value="/resources/images/icon/navi/search.png"/>">
						</button></span></li>

				<li class="center"><a id="Logo"><img
						src="<c:url value='/resources/images/icon/Logo.png' />"></a></li>

				<li class="right"><a id="Home"
					href="${pageContext.request.contextPath}/TimeLine?email=${email}"><img
						src="<c:url value='/resources/images/icon/navi/023-home.png' />"></a>
					<a id="Content" href="<c:url value="/post/upload"/>"><img
						src="<c:url value='/resources/images/icon/navi/Content.png' />"></a>
					<a id="Alarm" href="#none"> <img onclick="modal('al_my_modal')"
						src="<c:url value='/resources/images/icon/navi/008-notification.png' />"></a>
					<a id="Chat"
					href="${pageContext.request.contextPath}/user/chatting"> <img
						src="<c:url value='/resources/images/icon/navi/050-wechat.png'/>">
				</a> <c:set var="loginType" value="${loginType}" /> <c:choose>
						<c:when test="${loginType eq 'email' }">
							<img id="MyPage_img"
								src="https://peepsmember.s3.ap-northeast-2.amazonaws.com/peeps/profile${m_photo}">
						</c:when>
						<c:when test="${loginType ne 'email' }">
							<img id="MyPage_img" src="<c:url value="${m_photo}"/>">

						</c:when>

					</c:choose></li>
			</ul>

		</nav>
	</div>

	<!--modal -->
	<div id="al_my_modal">
		<div id="my_modal_header">알람목록</div>

		<button type="button" class="modal_close_btn">x</button>

	</div>

</body>
<script>
	sock = new SockJS(
			"http://54.180.153.91:8080/chat/alarm");

	sock.onopen = onOpen;
	sock.onmessage = onMessage;
	sock.onclose = onClose;
	$(document).ready(function() {

		function sendAlarm(type) {
			var alm = {
				type : type,
				sender : 'sender',
				receiver : 'receiver',
				post : 'post'
			}
			sock.send(JSON.stringify(alm)); // JSON문자열로 반환
			console.log(JSON.stringify(alm));
			console.log('위 메세지 소켓에 전송');
		}
	});
	function onOpen() {
		console.log('open');
	};
	function onMessage(evt) {
		var data = evt.data;
		var obj = JSON.parse(data);
		var currentuser_session = $('#sessionuserid').val();
		//if (obj.receiver == currentuser_session) { //m_idx = m_idx
		if (obj != "") {
			switch (obj.type) {
			// 댓글 알람
			case "comment":
				console.log("1111comment");
				var printHTML = "<div id='alarm_mask'>";
				printHTML += "<div id='alarm'>";
				printHTML += "<strong>" + obj.sender + " 님이 회원님의 게시물";
				printHTML += obj.post + " 에 댓글을 남겼습니다!</strong> <br>";
				printHTML += "</div>";
				printHTML += "</div>";
				$('#my_modal_header').append(printHTML);
				console.log("comment");
				//console.log(val.al_idx);
				break;
			// 좋아요 알람
			case "like":
				console.log("22222222comment");
				var printHTML = "<div id='alarm_mask'>";
				printHTML += "<div id='alarm'>";
				printHTML += "<strong>" + obj.sender + " 님이 회원님의 게시물";
				printHTML += obj.post + " 에 좋아요를 눌렀습니다!</strong> <br>";
				printHTML += "</div>";
				printHTML += "</div>";
				$('#my_modal_header').append(printHTML);
				console.log("like");
				//console.log(val.al_idx);
				break;
			// 팔로우 알람
			case "follow":
				console.log("33333333333333333comment");
				var printHTML = "<div id='alarm_mask'>";
				printHTML += "<div id='alarm'>";
				printHTML += "<strong>" + obj.sender;
				printHTML += " 님이 회원님을 팔로우 했습니다!</strong> <br>";
				printHTML += "</div>";
				printHTML += "</div>";
				$('#my_modal_header').append(printHTML);
				console.log("follow");
				//console.log(val.al_idx);
				break;
			} // switch 문
		} // if
		//}
	} // onMessage 함수
	function onClose() {
		console.log('console close');
	};
</script>

<script>
	function modal(id) {
		var zIndex = 9999;
		var modal = $('#' + id);
		// 모달 div 뒤에 희끄무레한 레이어
		var bg = $('<div>').css({
			position : 'fixed',
			zIndex : zIndex,
			left : '0px',
			top : '0px',
			width : '100%',
			height : '100%',
			overflow : 'auto',
			// 레이어 색갈은 여기서 바꾸면 됨
			backgroundColor : 'rgba(0,0,0,0.500)'
		}).appendTo('body');
		modal
				.css(
						{
							position : 'fixed',
							boxShadow : '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',
							// 시꺼먼 레이어 보다 한칸 위에 보이기
							zIndex : zIndex + 1,
							// div center 정렬
							top : '50%',
							left : '50%',
							transform : 'translate(-50%, -50%)',
							msTransform : 'translate(-50%, -50%)',
							webkitTransform : 'translate(-50%, -50%)'
						}).show()
				// 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
				.find('.modal_close_btn').on('click', function() {
					bg.remove();
					modal.hide();
				});
	}
</script>

<script>
	$(document).ready(function() {

		$.ajax({
			 url : "http://54.180.153.91:8080/chat/alarm/select",
			type : "GET",
			dataType : "json",
			success : function(data) {

				print(data);

				$('#Alarm').click(function() {
					modal('al_my_modal');
				});

			}, // success
			error : function() {
				console.log("alarm/select 실패");
			}
		}); // ajax

	}); // ready

	function print(alarmList) {

		if (alarmList == "") {
			var printHTML = "<div id='alarm'>";
			printHTML += "<strong>알람이 없습니다!";
			printHTML += "</strong> <br>";
			printHTML += "</div>";
			$('#my_modal_header').append(printHTML);
			console.log("알람 없음!");
		} else {
			$.each(alarmList, function(key, val) {
				switch (val.type) {
				// 댓글 알람
				case "comment":
					console.log("1111comment");
					var printHTML = "<div id='alarm_mask'>";
					printHTML += "<button id='btn' value=" + val.al_idx
							+ " onclick='del_al(" + val.al_idx + ");' />";
					printHTML += "<div id='alarm'>";
					printHTML += "<strong>" + val.sender + " 님이 회원님의 게시물";
					printHTML += val.post + " 에 댓글을 남겼습니다!</strong> <br>";
					printHTML += "</div>";
					printHTML += "</div>";
					$('#my_modal_header').append(printHTML);
					console.log("comment");
					//console.log(val.al_idx);
					break;
				// 좋아요 알람
				case "like":
					console.log("22222222comment");
					var printHTML = "<div id='alarm_mask'>";
					printHTML += "<button id='btn' value=" + val.al_idx
							+ " onclick='del_al(" + val.al_idx + ");' />";
					printHTML += "<div id='alarm'>";
					printHTML += "<strong>" + val.sender + " 님이 회원님의 게시물";
					printHTML += val.post + " 에 좋아요를 눌렀습니다!</strong> <br>";
					printHTML += "</div>";
					printHTML += "</div>";
					$('#my_modal_header').append(printHTML);
					console.log("like");
					//console.log(val.al_idx);
					break;
				// 팔로우 알람
				case "follow":
					console.log("33333333333333333comment");
					var printHTML = "<div id='alarm_mask'>";
					printHTML += "<button id='btn' value=" + val.al_idx
							+ " onclick='del_al(" + val.al_idx + ");' />";
					printHTML += "<div id='alarm'>";
					printHTML += "<strong>" + val.sender;
					printHTML += " 님이 회원님을 팔로우 했습니다!</strong> <br>";
					printHTML += "</div>";
					printHTML += "</div>";
					$('#my_modal_header').append(printHTML);
					console.log("follow");
					//console.log(val.al_idx);
					break;
				} // switch 문
			}); // $.each
		} // else
	} // print 함수

	function modal(id) {
		var zIndex = 9999;
		var modal = $('#' + id);
		// 모달 div 뒤에 희끄무레한 레이어
		var bg = $('<div>').css({
			position : 'fixed',
			zIndex : zIndex,
			left : '0px',
			top : '0px',
			width : '100%',
			height : '100%',
			overflow : 'auto',
			// 레이어 색갈은 여기서 바꾸면 됨
			backgroundColor : 'rgba(0,0,0,0.500)'
		}).appendTo('body');
		modal
				.css(
						{
							position : 'fixed',
							boxShadow : '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',
							// 시꺼먼 레이어 보다 한칸 위에 보이기
							zIndex : zIndex + 1,
							// div center 정렬
							top : '50%',
							left : '50%',
							transform : 'translate(-50%, -50%)',
							msTransform : 'translate(-50%, -50%)',
							webkitTransform : 'translate(-50%, -50%)'
						}).show()
				// 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
				.find('.modal_close_btn').on('click', function() {
					bg.remove();
					modal.hide();
				});
	}
</script>
<script>
	function del_al(al_idx) {

		var al_idx = {
			"al_idx" : $("#btn").val()
		};

		$.ajax({
			url : "http://54.180.153.91:8080/chat/alarm/delete",
			type : 'post',
			data : al_idx,
			success : function(data) {
				$('#alarm_mask').remove(); // 알람 css도 제거!
				$('#my_modal_header').scrollTop(
						$('#my_modal_header')[0].scrollHeight); // 제거 후 알람들 위로 올리기
				console.log("삭제 성공ㅎㅎㅎ");
			},
			error : function() {
				console.log("삭제 왜 안돼,,,,,?");
			}
		}); // ajax

	} // del_al
</script>

<script>
$(document).on("click", "#keyword", function(){
	
	var keyword = $('#search').val();
	console.log(keyword);

	if (keyword.trim() == "") {
		alert("한 글자 이상 입력하세요");
	} else {
		location.href = "${pageContext.request.contextPath}/user/finduser?keyword="+ encodeURI(encodeURIComponent(keyword));
	}

});

	
$(document).on("click", "#MyPage_img", function(){
	var id = "${id}";
	

	location.href = "${pageContext.request.contextPath}/user/mypage?id=" + encodeURI(encodeURIComponent(id));

});

</script>
<script>
//로그인체크
$.ajax({
	url : '${pageContext.request.contextPath}/user/loginChk',
	type: 'get',
	success : function(data){
		console.log(data);
		if(data == false){
			alert("로그인이 필요합니다");
			location.href = "${pageContext.request.contextPath}/";
		}
	},
	error : function() {
		console.log("로그인체크 실패,,,,");
	}
});
</script>
</html>