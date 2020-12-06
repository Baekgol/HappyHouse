<%@page import="org.apache.jasper.tagplugins.jstl.core.Import"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Happy House</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
<style type="text/css">
	.col-6{
		margin-bottom: 30px;
	}
	.table {
		border-collapse: separate;
		border-spacing: 20px 20px;
	}
</style>
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	<script type="text/javascript">
		$(function(){
			let bodyHeight = $("body").css("height").replace(/[^0-9]/g, "");
			let menuBarHeight = $("#menuBar").css("height").replace(/[^0-9]/g, "");
			let jumbotronHeight = $(".jumbotron").css("height").replace(/[^0-9]/g, "");
			let infosMarginTop = $("#infos").css("margin-top").replace(/[^0-9]/g, "");
			let infosHeight = bodyHeight - menuBarHeight - jumbotronHeight - infosMarginTop;
		})
	</script>
	<div class="jumbotron" id="mainImg" style="height: 500px; ">
		<div class="d-flex justify-content-center" id="goSale">
		  	<a href="house"><img src="/img/go_button.png"></a>
		</div>
	</div>
	<div class="container" id="infos">
		<div class="row" id="usefulInfos">
			<div class="col-6" style="margin-top: 20px;">
				<h5 class="infoTitle"><strong>공지사항</strong></h5>
				<a class="moreBtn" href="${pageContext.request.contextPath}/notice/noticeList"><button type="button" class="btn btn-dark btn-sm">더보기</button></a>
				<hr>
				<table class="table">
					<c:forEach items="${noticeList}" var="notice" begin="0" end="4">
						<tr>
							<td>
								<a style="color: black;" href="${pageContext.request.contextPath}/notice/info?num=${notice.bnum}">${notice.btitle}</a>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div class="col-6" style="margin-top: 20px;">
				<h5 class="infoTitle"><strong>뉴스</strong></h5>
				<a class="moreBtn" href="${pageContext.request.contextPath}/news"><button type="button" class="btn btn-dark btn-sm">더보기</button></a>
				<hr>
				<table class="table">
					<c:forEach items="${newsList}" var="news">
						<tr>
							<td>
								<a style="color: black;" href="${news.originallink}" target="_blank">${news.title}</a>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<div class="row" id="interestInfos" style="margin-top: 50px;">
			<div class="col-6">
				<h5 class="infoTitle" style="display: inline;"><strong><h4 style="display: inline;">${loginInfo.sido}</h4> 평균 매매가</strong></h5>
				<hr>
				<%@ include file="chart/avgChart.jsp" %>
			</div>
			<div class="col-6">
				<h5 class="infoTitle" style="display: inline;"><strong><h4 style="display: inline;">${loginInfo.sido} ${loginInfo.gugun}</h4> 매매량</strong></h5>
				<hr>
				<%@ include file="chart/cntChart.jsp" %>
			</div>
		</div>
	</div>
</body>
</html>