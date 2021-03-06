<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>
#alarm_mask {
	text-align: right;
	width: auto;
	max-width: 70%;
	background-color: #F2D665;
	border-radius: 5px;
	margin: 30px;
	word-wrap: break-word;
}

#alarm {
	text-align: left;
	width: auto;
	max-width: 70%;
	background-color: #F4F4F4;
	border-radius: 5px;
	margin: 30px;
	word-wrap: break-word;
}

#my_modal {
	display: none;
	width: 600px;
	height: 400px;
	padding: 20px 60px;
	background-color: #fefefe;
	border: 1px solid #888;
	border-radius: 10px;
	padding: 20px 60px;
	overflow: auto;
}

#my_modal .modal_close_btn {
	position: fixed;
	top: 10px;
	right: 10px;
}

strong {
	width: 500px;
	height: 30px;
	text-align: center;
	margin-top: 10px;
}

#btn {
	position: fixed;
	text-align: right;
	font-size: 10px;
}
</style>

<!-- SocketJS CDN -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>

</head>

<!-- css -->
<link rel="styleSheet" href="<c:url value="/css/default.css"/>">

<body>

	<!-- nav -->
	<div id="nav">
		<nav>
			<ul class="icon">

				<li class="left"><span><input type="search"
						placeholder="@kyung_s2">
						<button>
							<a href="#"><img
								src="<c:url value='/icon/navi/search.png' />"></a>
						</button></span></li>

				<li class="center"><a id="Logo"><img
						src="<c:url value='/icon/navi/Logo.png' />"></a></li>

				<li class="right"><ahref="#none">
					<img onclick="sendAlarm('comment')"
						src="<c:url value='/icon/navi/Content.png' />">
					</a> <a href="#none"> <img onclick="sendAlarm('like')"
						src="<c:url value='/icon/navi/008-notification.png' />"></a> <a
						href="#"><img onclick="sendAlarm('follow')"
						src="<c:url value='/icon/navi/050-wechat.png'/>"></a>
			</ul>
		</nav>
	</div>

	<!--modal -->
	<div id="my_modal">
		<div id="my_modal_header">????????? ??????</div>
		<button type="button" class="modal_close_btn">x</button>
	</div>

</body>

<script>
	sock = new SockJS("<c:url value="/alarm"/>");

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
			sock.send(JSON.stringify(alm)); // JSON???????????? ??????
			console.log(JSON.stringify(alm));
			console.log('??? ????????? ????????? ??????');
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
			// ?????? ??????
			case "comment":
				console.log("1111comment");
				var printHTML = "<div id='alarm_mask'>";
				printHTML += "<div id='alarm'>";
				printHTML += "<strong>" + obj.sender + " ?????? ???????????? ?????????";
				printHTML += obj.post + " ??? ????????? ???????????????!</strong> <br>";
				printHTML += "</div>";
				printHTML += "</div>";
				$('#my_modal_header').append(printHTML);
				console.log("comment");
				//console.log(val.al_idx);
				break;
			// ????????? ??????
			case "like":
				console.log("22222222comment");
				var printHTML = "<div id='alarm_mask'>";
				printHTML += "<div id='alarm'>";
				printHTML += "<strong>" + obj.sender + " ?????? ???????????? ?????????";
				printHTML += obj.post + " ??? ???????????? ???????????????!</strong> <br>";
				printHTML += "</div>";
				printHTML += "</div>";
				$('#my_modal_header').append(printHTML);
				console.log("like");
				//console.log(val.al_idx);
				break;
			// ????????? ??????
			case "follow":
				console.log("33333333333333333comment");
				var printHTML = "<div id='alarm_mask'>";
				printHTML += "<div id='alarm'>";
				printHTML += "<strong>" + obj.sender;
				printHTML += " ?????? ???????????? ????????? ????????????!</strong> <br>";
				printHTML += "</div>";
				printHTML += "</div>";
				$('#my_modal_header').append(printHTML);
				console.log("follow");
				//console.log(val.al_idx);
				break;
			} // switch ???
		} // if
		//}
	} // onMessage ??????

	function onClose() {
		console.log('console close');
	};
</script>

<script>
	function modal(id) {
		var zIndex = 9999;
		var modal = $('#' + id);
		// ?????? div ?????? ??????????????? ?????????
		var bg = $('<div>').css({
			position : 'fixed',
			zIndex : zIndex,
			left : '0px',
			top : '0px',
			width : '100%',
			height : '100%',
			overflow : 'auto',
			// ????????? ????????? ????????? ????????? ???
			backgroundColor : 'rgba(0,0,0,0.500)'
		}).appendTo('body');
		modal
				.css(
						{
							position : 'fixed',
							boxShadow : '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',
							// ????????? ????????? ?????? ?????? ?????? ?????????
							zIndex : zIndex + 1,
							// div center ??????
							top : '50%',
							left : '50%',
							transform : 'translate(-50%, -50%)',
							msTransform : 'translate(-50%, -50%)',
							webkitTransform : 'translate(-50%, -50%)'
						}).show()
				// ?????? ?????? ??????, ????????? ???????????? ?????? div ?????????
				.find('.modal_close_btn').on('click', function() {
					bg.remove();
					modal.hide();
				});

	}
</script>
</html>