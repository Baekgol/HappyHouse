<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="kor">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>부트스트랩 차트그리기</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<!-- 차트 링크 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
</head>
<body>

	<div class="container" align="center">
		<c:if test="${empty loginInfo}">
			<img src="/img/loginPlz.png" alt="로그인 해주세요." width="400">
		</c:if>
		<c:if test="${not empty loginInfo}">
			<canvas id="cntChart"></canvas>
		
		</c:if>
	</div>
	<!-- 부트스트랩 -->
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<!-- 차트 -->
	<script>
		var ctxCnt = document.getElementById('cntChart');
		var chartCntLabels = [];
		var chartCntData = [];
		var loginInfo = "${loginInfo}";
		if(loginInfo==""){}
		else{
			$.getJSON("${pageContext.request.contextPath}/cntdata", function(data) {
				$.each(data, function(idx, obj) {
					chartCntLabels.push(obj.dong);
					chartCntData.push(obj.cnt);
				});
				createCntChart();
				console.log("create Chart")
			});
		}
		var cntChartData = {
				labels : chartCntLabels,
				datasets : [
				{
					label : "매물 개수",
					backgroundColor: [ 
						'rgba(255, 99, 132, 0.2)', 
						'rgba(255, 159, 64, 0.2)',
						'rgba(255, 206, 86, 0.2)', 
						'rgba(75, 192, 192, 0.2)', 
						'rgba(54, 162, 235, 0.2)', 
						'rgba(153, 102, 255, 0.2)',
						], 
					data : chartCntData
				}
				]
			}
		var cntChartOptions = {
// 			scales : {
// 				yAxes : [ {
// 					ticks : {
// 						beginAtZero : true
// 					}
// 				} ]
// 			},
			legend:{
				display: true,
				position:'left',
				labels: {
					fullWidth: false,
					boxWidth: 20,
					fontSize: 8
				}
			},
			cutoutPercentage : 35,
			animation:{animateScale :true}
				
		}
		function createCntChart() {
			var ctxCnt = document.getElementById("cntChart").getContext("2d");
			LineChartDemo = new Chart(ctxCnt, {
				type : 'doughnut',
				data : cntChartData,
				options : cntChartOptions
			})
		}
		
	</script>
</body>
</html>

