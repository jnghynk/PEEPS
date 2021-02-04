<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav>
	<div class="navbar">
		<ul>
			<a href="<c:url value="/"/>">HOME</a>
		</ul>
		<ul>
			<a href="<c:url value="/post"/>">게시글(POST)</a>
		</ul>
		<ul>
			<a href="<c:url value="/map"/>">지도(MAP)</a>
		</ul>
		<ul>
			<a href="<c:url value="/guest"/>">방명록(GUEST)</a>
		</ul>
	</div>
</nav>

