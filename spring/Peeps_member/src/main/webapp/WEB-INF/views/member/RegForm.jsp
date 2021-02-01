<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="apple-touch-icon" sizes="76x76"
	href="resources/img/apple-icon.png">
<link rel="icon" type="image/png" href="resources/img/favicon.png">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>Insert title here</title>
<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'
	name='viewport' />
<meta name="viewport" content="width=device-width" />

<!--     Fonts and icons     -->
<link
	href="http://netdna.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.css"
	rel="stylesheet">

<!-- CSS Files -->
<link href="<c:url value="/resources/css/bootstrap.min.css"/>"
	rel="stylesheet" />
<link href="<c:url value="/resources/css/gsdk-bootstrap-wizard.css"/>"
	rel="stylesheet" />

<!-- CSS Just for demo purpose, don't include it in your project -->
<link href="<c:url value="/resources/css/demo.css"/>" rel="stylesheet" />
<link href="<c:url value="/resources/css/reg.css"/>" rel="stylesheet" />
</head>
<body>
	<div class="image-container set-full-height"
		style="background-color: #fcf9f6">
		<div class="logo-container">
			<!-- 로고 넣기 -->
			<img id="logo" src="images/KakaoTalk_20210127_164336960.png">
		</div>

		<!--   Big container   -->
		<div class="container">
			<div class="row">
				<div class="col-sm-8 col-sm-offset-2">

					<!--      Wizard container        -->
					<div class="wizard-container">

						<div class="card wizard-card" id="wizardProfile">
							<form id="regForm" method="post" enctype="multipart/form-data">
								<!--        You can switch ' data-color="orange" '  with one of the next bright colors: "blue", "green", "orange", "red"          -->

								<div class="wizard-header">
									<h3>
										<b>PEEPS</b> <br>
									</h3>
								</div>

								<!-- nav css 수정하기 -->
								<div>
									<ul>
										<li id="top_nav">회원가입</li>
									</ul>

								</div>
								<div id="login_wrap">
									<div class="form-group-left">
										<input type="email" id="login_text" name="email"
											placeholder="이메일"> <input type="password"
											id="login_text" name="password" placeholder="비밀번호">
									</div>
									<div class="form-group-right">
										<input type="text" id="login_text" name="id" placeholder="아이디">
										<input type="text" id="login_text" name="name"
											placeholder=" 사용자 이름 ">
									</div>
								</div>
								<input type="submit" id="sign_btn" value="회원가입" />
								<div id="or_wrap">
									<ul>
										<li>
											<hr>
										</li>
										<li>또는</li>
										<li>
											<hr>
										</li>
									</ul>
								</div>
								<!-- 카카오랑 구글 이미지 -->
								<div>
									<a href="#"><img id="k_login"
										src="images/kakao_login_medium_narrow.png"></a> <a href="#"><img
										id="g_login" src="images/google_login.png"></a>
								</div>
								<div class="wizard-footer height-wizard">
									<div class="clearfix">
										<br>
									</div>
								</div>
							</form>
						</div>
					</div>
					<!-- wizard container -->
				</div>
			</div>
			<!-- end row -->
		</div>
		<!--  big container -->

		<div class="footer">
			PEEPS<i class="fa fa-heart heart"></i>GNJKK
		</div>

	</div>

</body>
<!--   Core JS Files   -->
<script src="<c:url value="/resources/js/jquery-2.2.4.min.js"/>"
	type="text/javascript"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"
	type="text/javascript"></script>
<script src="<c:url value="/resources/js/jquery.bootstrap.wizard.js"/>"
	type="text/javascript"></script>

<!--  Plugin for the Wizard -->
<script src="<c:url value="/resources/js/gsdk-bootstrap-wizard.js"/>"></script>

<!--  More information about jquery.validate here: http://jqueryvalidation.org/	 -->
<script src="<c:url value="/resources/js/jquery.validate.min.js"/>"></script>
</html>