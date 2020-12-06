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
	<script type="text/javascript">
	    $(function(){
	    	$("option[value='0']").attr("hidden", true);
	    	$.get("${pageContext.request.contextPath}/map/sido"
				,function(data, status){
					$.each(data, function(index, vo) {
						$("#sido").append("<option value='"+vo.sidoCode+"'>"+vo.sidoName+"</option>");
					});//each
				}//function
				, "json"
			);//get
			
			$("#sido").change(function() {
				$.get("${pageContext.request.contextPath}/map/gugun"
						,{sido:$("#sido").val()}
						,function(data, status){
							$("#gugun").empty();
							$("#gugun").append('<option value="선택">선택</option>');
							$("option[value='선택']").attr("hidden", true);
							$.each(data, function(index, vo) {
								$("#gugun").append("<option value='"+vo.gugunName+"'>"+vo.gugunName+"</option>");
							});//each
						}//function
						, "json"
				);//get
			});//change
	    })
	</script>
    <div class="container contents" align="center">
        <div class="col-lg-6" align="center">
            <div class="body">
                <h3>HappyHouse 회원가입!</h3>
                <c:if test="${not empty errorMsg}">
                    <p class="error">${errorMsg}</p>
                </c:if>
                <form action="${pageContext.request.contextPath}/register" method="post">
                    <fieldset>
                        <div class="form-group" align="left">
                            <label for=userid style="display: block">ID:</label>
                            <input type="text" class="form-control" id="userid" name="userid" required>
                        </div>
                        <div class="form-group" align="left">
                            <label for="userpwd">Password:</label>
                            <input type="password" class="form-control" id="userpwd" name="userpwd" required>
                        </div>
                        <div class="form-group" align="left">
                            <label for="confirm">Password Confirm:</label>
                            <input type="password" class="form-control" id="confirm" name="confirm" required>
                        </div>
                        <div class="form-group" align="left">
                            <label for="nickname">Nickname:</label>
                            <input type="text" class="form-control" id="nickname" name="nickname" required>
                        </div>
                        <div class="form-group" align="left">
                            <label for="email">Email:</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="form-group" align="left">
                            Region of Interest:<br>
                            <select id="sido" name="sido" required="required">
                            	<option value="0">시도</option>
                            </select>
                            <select id="gugun" name="gugun" required="required">
                            	<option value="0">구군</option>
                            </select>
                        </div>
                        <div class="form-group" align="left"></div>
                        <div style="text-align: right; display: block">
                            <input type="submit" id="registBtn" class="btn btn-primary" value="회원가입">
                        </div>
                    </fieldset>
                </form>
            </div>

        </div>
    </div>
</body>
</html>
