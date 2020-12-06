<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="../../include/header.jsp" %>
	
	<script>
		// 매물 삭제 버튼 이벤트
	    $(document).on("click","#deleteBtn", function(){
	    	console.log($(this).val());
			$.ajax({
				url: "${pageContext.request.contextPath}/dealDel",
	            type: "POST",
	            data: {
	                dealNo: $(this).val(),
	            },
	            success: function () {
			        alert("성공");
			        location.reload(true);
	            	// console.log("$(this).val() : " + $(this).val());
	            },
	            error: function (){
	            	alert("실패");
	            	// console.log("$(this).val() : " + $(this).val());
	            }
			})
		});// click btn
	</script>
	
		<div class="container contents">
		<table id="interestList" class="table" style="margin-top:10px;">
		<button class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/dealAdd'">등록</button>
			<tr id="notice_title">
				<th colspan="7" style="color:white;"><h4 style="display: inline">${loginInfo.nickname}</h2> 님의 매물 목록</th>
			</tr>
			<tr>
				<th>동(지번)</th>
				<th>아파트 이름</th>
				<th>거래 금액</th>
				<th>건축 년도</th>
				<th>거래일</th>
				<th>넓이</th>
				<th>층</th>
			</tr>
			<c:choose>
				<c:when test="${empty myDealList}">
					<tr><td colspan="7">추가된 매물이 없습니다.</td></tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${myDealList}" var="item">
						<tr style="border: 0;">
							<td>${item.dong}(${item.jibun})</td>
							<td>${item.aptName}</td>
							<td>${item.dealAmount}</td>
							<td>${item.buildYear}</td>
							<td>${item.dealYear}-${item.dealMonth }-${item.dealDay }</td>
							<td>${item.area}</td>
							<td>${item.floor}</td>
							<td style="border: 0;"><button class='btn btn-danger' id='deleteBtn' value="${item.no}">삭제</button></td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
		</div>
</body>
</html>