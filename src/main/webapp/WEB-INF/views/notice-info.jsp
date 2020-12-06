<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HappyHouse-공지사항</title>
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	<div class="container contents">
		<table border="1" class="table table-hover" style="margin-top:10px;">
			<tr id="notice_title">
				<th colspan="5" style="color:white;">공지사항</th>
			</tr>
			<tr>
				<th>글번호</th>
				<td>${dto.bnum}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${dto.bwriter}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${dto.btitle}</td>
			</tr>
			<tr>
				<th>작성일시</th>
				<td>${dto.bwriteDate}</td>
			</tr>
			<tr>
				<th>조회수</th>
				<td>${dto.bread_cnt}</td>
			</tr>
			<tr>
				<th>작성내용</th>
				<td>${dto.bcontent}</td>
			</tr>
		</table>
		<div style="text-align:right;">
			<a href="${pageContext.request.contextPath}/notice/noticeList" style="margin-right:20px;">목록으로</a>
		</div>
		<c:if test="${not empty loginInfo}">
			<c:if test="${loginInfo.userid eq 'admin'}">
				<a href="${pageContext.request.contextPath}/notice/modify/${dto.bnum}">
					<button class="btn btn-primary">수정</button>
				</a>
				<a href="${pageContext.request.contextPath}/notice/delete/${dto.bnum}">
					<button class="btn btn-danger">삭제</button>
				</a>
			</c:if>
		</c:if>
	</div>
</body>
</html>