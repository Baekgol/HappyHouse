<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}
</style>
<script language="javascript">
function goPopup(){
	// 주소검색을 수행할 팝업 페이지를 호출합니다.
	// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
	var pop = window.open("${pageContext.request.contextPath}/popup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
}
function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		document.form.address.value = roadAddrPart1;
 		document.form.addrDetail.value = addrDetail;
 		document.form.code.value = admCd;
		document.form.AptName.value = bdNm;
		document.form.siNm.value = siNm;
		document.form.sggNm.value = sggNm;
		document.form.dong.value = emdNm;
		document.form.lnbrMnnm.value = lnbrMnnm;
		document.form.lnbrSlno.value = lnbrSlno;
}

</script>
<title>주소 입력 샘플</title>
</head>
<body>
	<%@ include file="../../include/header.jsp" %>
    <div class="container contents" align="center">
        <div class="col-lg-6" align="center">
            <div class="body">
                <h3>매물 등록하기</h3>
                <form name="form" id="form" action="${pageContext.request.contextPath}/dealAdd" method="post">
					<input type="hidden" id="code"  name="code" placeholder="행정구역코드"/>
					<input type="hidden" id="AptName"  name="AptName" placeholder="건물명"/>
					<input type="hidden" id="siNm"  name="siNm" placeholder="시도명"/>
					<input type="hidden" id="sggNm"  name="sggNm" placeholder="시군구명"/>
					<input type="hidden" id="dong"  name="dong" placeholder="읍면동명"/>
					<input type="hidden" id="lnbrMnnm"  name="lnbrMnnm" placeholder="지번본번(번지)"/>
					<input type="hidden" id="lnbrSlno"  name="lnbrSlno" placeholder="지번부번(호)"/>
                    <fieldset>
                        <div class="form-group" align="left">
                            <label for=roadFullAddr style="display: block">매물 주소:</label> 
                            <input type="text" class="form-control" id="address"  name="address" required readonly />
                            <input type="button" onClick="goPopup();" value="주소찾기" class="btn btn-primary"/>
                        </div>
                        <div class="form-group" align="left">
                            <label for=roadFullAddr style="display: block">상세 주소:</label> 
                            <input type="text" class="form-control" id="addrDetail"  name="addrDetail" required />
                        </div>
                        <div class="form-group" align="left">
                            <label for="buildYear">건축년도:</label>
                            <input type="number" class="form-control" id="buildYear" name="buildYear" required>
                        </div>
                        <div class="form-group" align="left">
                            <label for="dealDate">거래날짜:</label>
                            <input type="date" class="form-control" id="dealDate" name="dealDate" required>
                        </div>
                        <div class="form-group" align="left">
                            <label for="area">면적:</label>
                            <input type="text" step="0.001" class="form-control" id="area" name="area" required>
                        </div>
                        <div class="form-group" align="left">
                            <label for="floor">층:</label>
                            <input type="number" class="form-control" id="floor" name="floor" required>
                        </div>
                        <div class="form-group" align="left">
                            <label for="dealAmountInt">매매가:</label>
                            <input type="number" class="form-control" id="dealAmountInt" name="dealAmountInt" required>
                        </div>
                        
                        <div class="form-group" align="left"></div>
                        <div style="text-align: right; display: block">
                            <input type="submit" id="registBtn" class="btn btn-primary" value="등록">
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
</body>
</html>