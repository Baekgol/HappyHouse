<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Member 화면</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	<script type="text/javascript">
		$(function(){
			$("#modifyTryBtn").click(function(){
				$(this).hide();
				$("#modifyApplyBtn").show();
				$("#modifyCancelBtn").show();
				$("#pwdInput").show();
				$("input[type=password]").attr("readonly", false);
				$("input[type=email]").attr("readonly", false);
				$("select[name=sido]").attr("disabled", false);
				$("select[name=gugun]").attr("disabled", false);
				$("select[name=sido] option:eq(0)").remove();
				$("select[name=sido] option").filter(function(){
					return $(this).html()=="${loginInfo.sido}";
				}).attr("selected", "selected");
				
				$.ajaxSetup({async: false});
				$.get("${pageContext.request.contextPath}/map/gugun"
						,{sido:$("#sido").val()}
						,function(data, status){
							$.each(data, function(index, vo) {
								$("#gugun").append("<option value='"+vo.gugunName+"'>"+vo.gugunName+"</option>");
							});//each
						}//function
						, "json"
				);//get
				
				$("select[name=gugun] option:eq(0)").remove();
				$("select[name=gugun] option").filter(function(){
					return $(this).html()=="${loginInfo.gugun}";
				}).attr("selected", "selected");
			})
			
			$("#modifyCancelBtn").click(function(){
				$("select[name=sido]").append("<option value='0'>${loginInfo.sido}</option>");
				$("select[name=sido]").val('0');
				$("select[name=gugun]").append("<option value='0'>${loginInfo.gugun}</option>");
				$("select[name=gugun]").val('0');
				$("select[name=sido]").attr("disabled", true);
				$("select[name=gugun]").attr("disabled", true);
				$("input[type=password]").val("");
				$("input[type=password]").attr("readonly", true);
				$("input[type=email]").val("${loginInfo.email}");
				$("input[type=email]").attr("readonly", true);
				$("#pwdInput").hide();
				$(this).hide();
				$("#modifyApplyBtn").hide();
				$("#modifyTryBtn").show();
			})
			
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
            <h3>회원정보</h3>
            <form action="${pageContext.request.contextPath}/member/modify" method="post">
	            <table class="table">
	            	<colgroup>
	            		<col width="30%"/>
	            		<col width="70%"/>
	            	</colgroup>
	            	<tr>
	            		<td>ID</td>
	            		<td><input type="text" class="form-control" name="userid" value="${loginInfo.userid}" readonly></td>
	            	</tr>
	            	<tr id="pwdInput">
	            		<td>Password</td>
	            		<td><input type="password" class="form-control" name="userpwd" readonly required="required"></td>
	            	</tr>
	            	<tr>
	            		<td>Nickname</td>
	            		<td><input type="text" class="form-control" name="nickname" value="${loginInfo.nickname}" readonly></td>
	            	</tr>
	            	<tr>
	            		<td>Email</td>
	            		<td><input type="email" class="form-control" name="email" value="${loginInfo.email}" readonly required="required"></td>
	            	</tr>
	            	<tr>
	            		<td>Region of Interest</td>
	            		<td>
	            			<select id="sido" name="sido" disabled="disabled">
                            	<option value="0">${loginInfo.sido}</option>
                            </select>
                            <select id="gugun" name="gugun" disabled="disabled">
                            	<option value="0">${loginInfo.gugun}</option>
                            </select>
						</td>
	            	</tr>
	            </table>
	            <div id="modifyBtnBox">
					<input type="button" id="modifyTryBtn" class="btn btn-primary" value="수정하기">
					<input type="submit" id="modifyApplyBtn" class="btn btn-warning" value="수정완료">
					<input type="button" id="modifyCancelBtn" class="btn btn-danger" value="돌아가기">
				</div>
            </form>
        </div>
    </div>
</body>
</html>