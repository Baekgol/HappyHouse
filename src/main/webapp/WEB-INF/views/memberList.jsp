<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Member 화면</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="shortcut icon" href="img/favicon.ico">
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	<h2 style="color: black">Happy House 회원 목록</h2>&nbsp
	<table class="table" style="width: 600px; text-align: center;">
	  	<thead class="thead-dark">
			<tr>
				<th scope="col">아이디</th>
				<th scope="col">비밀번호</th>
				<th scope="col">탈퇴</th>
			</tr>
		</thead>
		<c:forEach items="${members}" var="dto">
			<tr>
				<td>${dto.userid}</td>
				<td>${dto.userpwd}</td>
				<td><a href="${pageContext.request.contextPath}/admin/delete/${dto.userid}"><button class="btn btn-danger">추방</button></a></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>