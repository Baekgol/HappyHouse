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
			<canvas id="avgChart"></canvas>
		
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
		var ctxAvg = document.getElementById('avgChart');
		var chartAvgLabels = [];
		var chartAvgData = [];
		var loginInfo = "${loginInfo}";
		if(loginInfo==""){}
		else{
			$.getJSON("${pageContext.request.contextPath}/avgdata", function(data) {
				$.each(data, function(idx, obj) {
					chartAvgLabels.push(obj.avgGuName);
					chartAvgData.push(obj.avg);
				});
				createAvgChart();
				console.log("create AvgChart")
			});
		}
		var avgChartData = {
				labels : chartAvgLabels,
				datasets : [
				{
					label : "평균 매매가",
					backgroundColor: 'rgba(255, 159, 64, 0.2)',
					borderColor:'rgba(255, 159, 64, 1)',
					borderWidth: 1,
					data : chartAvgData
				}
				]
			}
			function createAvgChart() {
				var ctxAvg = document.getElementById("avgChart").getContext("2d");
				LineChartDemo = Chart.Bar(ctxAvg, {
					data : avgChartData,
					options : {
						scales : {
							yAxes : [ {
								ticks : {
									beginAtZero : true
								}
							} ]
						}
					}
				})
			}
		
	</script>
</body>
</html>

