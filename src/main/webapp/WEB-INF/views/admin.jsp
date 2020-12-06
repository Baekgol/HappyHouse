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
	<style type="text/css">
	</style>
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	<div class="container contents">
	<table id="interestList" class="table" style="margin-top:10px;">
		<tr id="notice_title">
			<th colspan="7" style="color:white;"><h2 style="display: inline">${loginInfo.nickname}</h2> 의 회원관리 목록입니다.</th>
		</tr>
		<tr>
			<th style="text-align: center;">아이디</th>
			<th style="text-align: center;">비밀번호</th>
			<th style="text-align: center;">탈퇴</th>
		</tr>
		<c:choose>
			<c:when test="${empty members}">
				<tr><td colspan="3">회원이 없습니다.</td></tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${members}" var="dto">
					<tr style="border: 0;">
						<td style="text-align: center;">${dto.userid}</td>
						<td style="text-align: center;">${dto.userpwd}</td>
						<c:choose>
							<c:when test="${dto.admin}">
								<td style="text-align: center;"><button class="btn btn-warning admin" style="background-color: gray; border: gray; color: white;">관리자</button></td>
							</c:when>
							<c:otherwise>
								<td style="text-align: center;"><a href="${pageContext.request.contextPath}/admin/delete/${dto.userid}"><button class="btn btn-danger">추방</button></a></td>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
	</div>
	
	<script>
		$(document).on("click", ".admin", function(){
			alert("혹시.. 싸우셨나요..? 같은 관리자를 왜 추방하려고 하시죠ㅜ");
		});
	</script>
</body>
</html>