<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/custom.css">
<link href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<body>
	<nav class="navbar navbar-light bg-dark" id="menuBar">
		<a href="${pageContext.request.contextPath}/" class="navbar-brand"><img src="/img/myLogo.png" width="180" height="55"></a>
		<div class="form-inline">
			<c:if test="${empty loginInfo}">
				<a href="${pageContext.request.contextPath}/register">
					<button class="btn btn-primary" id="registBtn">회원가입</button>
				</a>
				<a href="${pageContext.request.contextPath}/login">
					<button class="btn btn-success" id="loginBtn">로그인</button>
				</a>
			</c:if>
			<c:if test="${not empty loginInfo}">
				<c:if test="${loginInfo.admin eq true}">
					<a href="${pageContext.request.contextPath}/admin">
						<button class="btn btn-danger" id="adminBtn">관리자</button>
					</a>
				</c:if>
				<c:if test="${loginInfo.admin ne true}">
					<div class="dropdown">
					  <button class="btn btn-primary" id="userBtn"><strong>${loginInfo.nickname}</strong> 님</button>
					  <div class="dropdown-content">
					    <a href="${pageContext.request.contextPath}/dealList">매물 등록/관리</a>
					    <a href="${pageContext.request.contextPath}/interestList">나의 관심매물</a>
					    <a href="${pageContext.request.contextPath}/member/find/${loginInfo.userid}">회원정보 수정</a>
					    <a onclick="return delchk();" href="${pageContext.request.contextPath}/member/delete/${loginInfo.userid}">회원탈퇴</a>
					  </div>
					</div>
				</c:if>
				<a href="${pageContext.request.contextPath}/logout">
					<button class="btn btn-warning" id="logoutBtn">로그아웃</button>
				</a>
			</c:if>
		</div>
	</nav>
</body>
<script type="text/javascript">
function delchk(){
    return confirm("정말 탈퇴하시겠습니까?");
}
</script>