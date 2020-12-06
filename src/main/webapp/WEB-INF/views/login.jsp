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
                <h3>HappyHouse 로그인!</h3>
                <c:if test="${not empty errorMsg}">
                    <p class="error">${errorMsg}</p>
                </c:if>
                <form action="${pageContext.request.contextPath}/login" method="post">
                    <fieldset>
                        <div class="form-group" align="left">
                            <label for=ID style="display: block">ID:</label>
                            <input type="text" class="form-control" id="ID" name="userid" required>
                        </div>
                        <div class="form-group" align="left">
                            <label for="PW">Password:</label>
                            <input type="password" class="form-control" id="PW" name="userpwd" required>
                        </div>
                        <div style="text-align: right; display: block">
                            <input type="submit" id="loginBtn" class="btn btn-primary" value="로그인">
                        </div>
                        <div style="text-align: right; margin-top:5px; display: block">
                            <a href="${pageContext.request.contextPath}/member/password"> 비밀번호를 잊으셨나요? </a>
                        </div>
                    </fieldset>
                </form>
            </div>

        </div>
    </div>
</div>
</body>
</html>
