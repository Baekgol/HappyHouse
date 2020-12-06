<%@page import="com.ssafy.happyhouse.model.dto.MemberDto"%>
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
				<th>제목</th>
				<th>작성자</th>
				<th>작성일시</th>
				<th>조회수</th>
			</tr>
			<c:choose>
				<c:when test="${empty pagDto or empty pagDto.noticeList}">
					<tr><td colspan="5">작성된 게시글이 없습니다.</td></tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${pagDto.noticeList}" var="dto">
						<tr>
							<td>${dto.bnum}</td>
							<td><a href="${pageContext.request.contextPath}/notice/info?num=${dto.bnum}">${dto.btitle}</a></td>
							<td>${dto.bwriter}</td>
							<td>${dto.bwriteDate}</td>
							<td>${dto.bread_cnt}</td>
						</tr>
					</c:forEach>
					
					<tr>
						<td colspan="5">
							<c:if test="${pagDto.startPage>1}">
								<a href="${pageContext.request.contextPath}/notice/noticeList?page=${pagDto.startPage-1}">이전</a>
							</c:if>
							<c:forEach begin="${pagDto.startPage}" end="${pagDto.endPage}" var="i">
								
								<a href="${pageContext.request.contextPath}/notice/noticeList?page=${i}">
								<c:if test="${i eq pagDto.curPage}"><b>[${i}]</b></c:if>
								<c:if test="${i ne pagDto.curPage}">[${i}]</c:if>
								</a>
							</c:forEach>
							
							<c:if test="${pagDto.endPage < pagDto.totalPage}">
								<a href="${pageContext.request.contextPath}/notice/noticeList?page=${pagDto.endPage+1}">다음</a>
							</c:if>
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
		<c:if test="${not empty loginInfo}">
			<c:if test="${loginInfo.userid eq 'admin'}">
				<div style="text-align:right;">
					<a href="${pageContext.request.contextPath}/notice/writer" style="margin-right:20px;">글쓰기</a>
				</div>
			</c:if>
		</c:if>
	</div>
</body>
</html>