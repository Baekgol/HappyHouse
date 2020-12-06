<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">

 .card-body{
 	height: 380px;
 }
 .card-title{
 	height: 110px;
 }
 .col-3{
 	margin-bottom: 20px;
 }
 #newsBtn{
 	background-color: #ffab00;
 	border-color: #ffab00;
 }
 h2{
 	margin-left: 20px;
 }
 hr{
  margin-bottom: 20px;
 }
</style>
<meta charset="UTF-8">
<title>News</title>
</head>


<body>
<%@ include file="../include/header.jsp" %>
	<div class="container contents">
	<div class="container">
	<h2>News</h2>
	<hr>
		<c:forEach items="${newsList }" var="dto" varStatus="status">
			<c:if test="${status.count%4 eq 1}">
				<div class="row">
			</c:if>
					<div class="col-3">
						<div class="card">
							<a href="${dto.originallink}" class="btn btn-primary" id="newsBtn"><strong>기사보기</strong></a>
							<div class="card-body">
								<h5 class="card-title"><strong>${dto.title }</strong></h5>
								<p class="card-text">${dto.description}</p>
							</div>
						</div>
					</div>
			<c:if test="${status.count}%4 eq 1">
				</div>
			</c:if>
		</c:forEach>
	</div>
	</div>
</body>
</html>