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
	<div class="container">
		<form action="${pageContext.request.contextPath}/notice/modify" method="post">
		<table border="1" class="table table-hover" style="margin-top:10px;">
			<tr id="notice_title">
				<th colspan="5" style="color:white;">공지사항</th>
			</tr>
			<tr>
				<th>글번호</th>
				<td><input type="text" name="bnum" class="form-control" value="${dto.bnum}" readonly></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><input type="text" name="bwriter" class="form-control" value="${dto.bwriter}" readonly></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="btitle" class="form-control" value="${dto.btitle}"></td>
			</tr>
			<tr>
				<th>작성일시</th>
				<td><input type="text" name="bwriteDate" class="form-control" value="${dto.bwriteDate}" readonly></td>
			</tr>
			<tr>
				<th>조회수</th>
				<td><input type="text" name="bread_cnt" class="form-control" value="${dto.bread_cnt}" readonly></td>
			</tr>
			<tr>
				<th>작성내용</th>
				<td><input type="text" name="bcontent" class="form-control" value="${dto.bcontent}"></td>
			</tr>
		</table>
			<c:if test="${not empty loginInfo}">
				<c:if test="${loginInfo.userid eq 'admin'}">
					<input type="submit" class="btn btn-primary" value="수정하기"></input>
				</c:if>
			</c:if>
		</form>
		<div style="text-align:right;">
			<a href="${pageContext.request.contextPath}/notice/noticeList" style="margin-right:20px;">목록으로</a>
		</div>
	</div>
</body>
</html>