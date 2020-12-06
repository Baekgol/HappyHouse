<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Happy House</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	<div class="contents">
	    <div class="container" align="center">
	        <div class="col-lg-6" align="center">
	            <div class="body">
	                <h3>비밀번호를 잊으셨나요?</h3>
	                <p>아이디를 입력하시면 비밀번호를 알려드립니다.</p>
	                <form action="${pageContext.request.contextPath}/member/password" method="post">
	                    <fieldset>
	                        <div class="form-group" align="left">
	                            <label for=ID style="display: block">ID:</label>
	                            <input type="text" class="form-control" id="ID" name="userid" required>
	                        </div>
	                        <div style="text-align: right; display: block">
	                        	<input type="submit" id="loginBtn" class="btn btn-primary" value="비밀번호 찾기">
	                        </div>
	                    </fieldset>
	                </form>
	                <c:if test="${not empty successMsg}">
	                	<p class="success" style="margin-top : 5px">${successMsg}</p>
	                	<a href="${pageContext.request.contextPath}/login">
	                		<button id="loginBtn" class="btn btn-primary">로그인 화면으로 돌아가기</button>
	                	</a>
	                </c:if>
					<c:if test="${not empty errorMsg}">
	                	<p class="error" style="margin-top : 5px">${errorMsg}</p>
	                </c:if>
	            </div>
	
	        </div>
	    </div>
	</div>
</body>
</html>