<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>   -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- <link rel="stylesheet" -->
<!-- 	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> -->
<style type="text/css">

/* Bootstrap 수정 */
.table>thead {
	background-color: #ffab00;
	color: #ffffff;
}

.table>thead>tr>th {
	text-align: center;
}

.table-hover>tbody>tr:hover {
	background-color: #fffae6;
}

.table>tbody>tr>td {
	text-align: center;
}

.table>tbody>tr>#title {
	text-align: left;
}

div>#paging {
	text-align: center;
}

.hide {
	display: none;
}

.show {
	display: table-row;
}

.item td {
	cursor: pointer;
}
</style>
</head>

<body>
	<div id="qna">
		<div>
			<h3>Q&A</h3>
			<table class="table table-striped table-bordered table-hover"
				id="arco">
				<thead>
					<tr class="">
						<th>번호</th>
						<th>제목</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="qna" items="${pagDto.qnaList}" varStatus="status">
						<tr class="item">
							<td id="qnum">${qna.id }</td>
							<td id="title">${qna.title}</td>
						</tr>

						<tr class="hide">
							<td>내용
								<hr>답변
							</td>
							<td colspan="4">${qna.contents }
								<hr> <c:if test="${empty qna.answer }">
									<c:if test="${loginInfo.userid eq type}">
										<!-- 딜 type꺼내와야함 -->
										<form id="ansForm"
											action="${pageContext.request.contextPath}/ansUpdate"
											method="post">
											<div class="input-group mb-3 input-group-sm">
												<div class="input-group-prepend">
													<span class="input-group-text">내용</span>
												</div>
												<input type="text" name="answer" id="answer"
													class="form-control">
											</div>
											<input type="hidden" name="id" id="id" value="${qna.id}">
											<button id="ansSubmitBtn" type="submit"
												class="btn btn-secondary btn-sm">답변등록</button>
										</form>
									</c:if>
									<c:if test="${loginInfo.userid ne type }">
										<!-- 딜 type (id)꺼내와야함 -->
	                                       			답변이 없습니다.
	                                       		</c:if>
								</c:if> <c:if test="${not empty qna.answer }">
                                       			${qna.answer }
                                       		</c:if> <br>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${not empty loginInfo.userid}">
						<c:if test="${loginInfo.userid ne type}">
							<tr>
								<td colspan="5">
									<form id="qnaForm"
										action="${pageContext.request.contextPath}/qnaAdd"
										method="post">
										<div class="input-group mb-3 input-group-sm">
											<div class="input-group-prepend">
												<span class="input-group-text">제목</span>
											</div>
											<input type="text" name="title" id="title"
												class="form-control">
										</div>
										<div class="input-group mb-3 input-group-sm">
											<div class="input-group-prepend">
												<span class="input-group-text">내용</span>
											</div>
											<input type="text" name="contents" id="contents"
												class="form-control">
										</div>
										<input type="hidden" name="userid" id="userid"
											value="${loginInfo.userid}"> <input type="hidden"
											name="dealno" id="dealno" value="${dealno}">
										<!-- dealno 정해줘야함 -->
										<button id="qnaSubmitBtn" type="submit"
											class="btn btn-secondary btn-sm">질문등록</button>
									</form>
								</td>
							</tr>
						</c:if>
					</c:if>
					<tr>
						<td colspan="5"><c:if test="${pagDto.startPage>1}">
								<a
									href="${pageContext.request.contextPath}/qnaList?page=${pagDto.startPage-1}">이전</a>
							</c:if> <c:forEach begin="${pagDto.startPage}" end="${pagDto.endPage}"
								var="i">

								<a href="${pageContext.request.contextPath}/qnaList?page=${i}">
									<c:if test="${i eq pagDto.curPage}">
										<b>[${i}]</b>
									</c:if> <c:if test="${i ne pagDto.curPage}">[${i}]</c:if>
								</a>
							</c:forEach> <c:if test="${pagDto.endPage < pagDto.totalPage}">
								<a
									href="${pageContext.request.contextPath}/qnaList?page=${pagDto.endPage+1}">다음</a>
							</c:if></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

	<script type="text/javascript">
		$(function() {
			var article = ("#arco .show");
			$("#arco .item td").click(function() {
				var myArticle = $(this).parents().next("tr");
				if ($(myArticle).hasClass('hide')) {
					$(article).removeClass('show').addClass('hide');
					$(myArticle).removeClass('hide').addClass('show');
				} else {
					$(myArticle).addClass('hide').removeClass('show');
				}
			});

			// qna submit 해보자..
			$('#qnaSubmitBtn').click(
					function() {
						$("#qnaForm").submit(
								function(event) {
									event.preventDefault();
									var url = $(this).attr("action");
									var data = $(this).serialize();

									$.post(url, data).done(
											function(data) {
												console.log('--->', data);
												$('#qna').load(
														'${pageContext.request.contextPath}/qnaList?dealno=${dealno}'
																+ '#qna');
											});
								});
					});

			// ans submit 해보자..
			$('#ansSubmitBtn').click(
					function() {
						$("#ansForm").submit(
								function(event) {
									event.preventDefault();
									var url = $(this).attr("action");
									var data = $(this).serialize();

									$.post(url, data).done(
											function(data) {
												console.log('--->', data);
												$('#qna').load(
														'${pageContext.request.contextPath}/qnaList?dealno=${dealno}'
																+ '#qna');
											});
								});
					});
		});
	</script>
</body>
</html>