<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>House Search</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7c430c0a6d462a4f0bf2bea1e9ede620&libraries=services,clusterer,drawing"></script>
</head>
<body style="overflow: hidden">
	<div id="mainLoadingWindow"></div>
	<img id="mainLoadingImg" src="/img/loading.gif" width="150" height="150">
	<%@ include file="../include/header.jsp"%>
	<script type="text/javascript">
		var map, clusterer, placeOverlay, ps;
		var houseInfosMap, houseMarker = [];
		var list = [], dealListIdx = 0, searchWords = [];
		var myInterestList = [];
		var toggleFlag = false;
		
		$(function(){
			let menuBarHeight = $("#menuBar").css("height").replace(/[^0-9]/g, "");
			let bodyHeight = $("body").css("height").replace(/[^0-9]/g, "");
			let dealContentsHeight = bodyHeight - menuBarHeight;
			let dealListHeader = parseInt($("#dealListHeader").css("height").replace(/[^0-9]/g, "")) + 32;
			let searchResultBoxHeight = dealContentsHeight - dealListHeader; 
			$("#searchResultBox").css("height", searchResultBoxHeight);
			let detailPageHeight = dealContentsHeight - dealListHeader; 
			$("#detailPage").css("height", detailPageHeight);
			
			$(document).bind("ajaxStart.main", function(){
				$("#mainLoadingWindow").show();
				$("#mainLoadingImg").show();
			});
			
			$(document).bind("ajaxStop.main", function(){
				$("#mainLoadingWindow").hide();
				$("#mainLoadingImg").hide();
			});
			
			let mainLoadingWindowWidth = $(document).width();
			let mainLoadingWindowHeight = $(document).height();
			$("#mainLoadingWindow").css("width", mainLoadingWindowWidth);
			$("#mainLoadingWindow").css("height", mainLoadingWindowHeight);
			$("#mainLoadingWindow").css("background-color", "black");
			$("#mainLoadingWindow").css("opacity", "0.5");
			
			// 이름으로 검색
			$("#mapSearchBar").on("propertychange change keyup paste input", function(){
				$("#sido").val("0");
				$("#gugun").val("0");
				$("#dong").val("0");
				$("#searchWordList").empty();
				$("#searchWordList").css("height", "");
				
				if($(this).val()!="") {
					$("#detailSearchBtn").removeClass("show");
					$("#mapFilterBox").hide();
					$("#searchWordList").show();
					
					$.ajax({
						type: "get",
						url: "${pageContext.request.contextPath}/map/searchName/"+$(this).val(),
						global: false,
						success: function(searchWordList) {
							let result = "";
							for(info of searchWordList) {
								result += "<li>";
								result += "<span id='"+info.no+"'><strong>"+info.aptName+"</strong></span>";
								result += "</li>";
							}
							$("#searchWordList").append(result);
							if($("#searchWordList").height()>300) $("#searchWordList").css("height", "300");
						}
					});
				}
				else {
					$("#searchWordList").hide();
					$("#mapFilterBox").show();
				}
			});
			
			$("#searchBtn").click(function(){
				listLoadingRegist();
				$("#searchWordList").hide();
				$("#mapFilterBox").show();
				$("#sido").val("0");
				$("#gugun").val("0");
				$("#dong").val("0");
				
				if($("#mapSearchBar").val()=="") {
					$("#detailSearchBtn").removeClass("show");
					return;
				}
				
				let name = $("#mapSearchBar").val();
				$("#mapSearchBar").val("");
				dealListIdx = 0;
				list = [];
				
				for(deal of searchWords) {
					let result = "<table>";
					result += "<colgroup><col width='50%'/><col width='50%'/></colgroup>";
                    result += "<tr><td rowspan='4'><img src='/img/myApt.jpg' width='150'></td>"
                    result += "<td colspan='3'><strong><h4 style='display: inline;'>"+deal.aptName+"</h4></strong>";
                    
                    let flag = false;
                    $.each(myInterestList, function(index, el){
                        if(el != deal.no){ // DB에 있다는 거 아직 발견 못 함.
                            return true;
                        } else { // DB에 있다는 거 발견한 경우
                            flag = true;
                            return false;
                        }
                    })

                    if(flag == false){ // DB에 없으면
                        result += "<button type='button' style='border: 0; outline: 0; background-color:transparent;' class='interestBtn' value=\""+deal.no+"\"><img src='/img/empty_heart.png' id='heart"+deal.no+"' width='25'></button></td></tr>";
                    } else { // DB에 있으면
                        result += "<button type='button' style='border: 0; outline: 0; background-color:transparent;' class='interestBtn' value=\""+deal.no+"\"><img src='/img/full_heart.png' id='heart"+deal.no+"' width='25'></button></td></tr>";
                    }

                    result += "<tr><td colspan='3'><strong><h5 style='display: inline;'>"+deal.dealAmount+"</h5></strong> 만원</td></tr>";
                    result += "<tr><td colspan='3'>"+deal.floor+"층, ";
                    
                    result += "<span class='toggle1 area"+deal.no+"'>" + parseInt(deal.area) + "m<sup>2</sup></span>";
                    result += "<span class='toggle2 area"+deal.no+"' style='display:none'>" + parseInt(deal.area / 3.30579) + "평</span>";
                    result += "<button type='button' style='border: 0; outline: 0; background-color:transparent;' class='convertBtn' value=\""+deal.no+"\"><img src='/img/convert.png' class='convert' width='25'></button></td></tr>";
                    result += "</td></tr>";
                    result += "<tr><td colspan='3' align='left'><button class='btn btn-warning detailBtn' value=\""+deal.no+"\">상세 정보 보기</button></td></tr>";
                    result += "</table>";
                    
                    list.push(result);
				}
				
				let size = 5;
                dealListIdx = 5;
                
                if(list.length<5) {
                    size = list.length;
                    dealListIdx = list.length;
                }
                
                $("#searchResult").empty();
                
                for(let i=0; i<size; i++)
                    $("#searchResult").append(list[i]);
                
                $("#dealNum").html(list.length+"개");
				
				if($("#searchResultBox").css("display")=="none") {
					$("#detailPage").hide();
					$("#searchResultBox").show();
					$("#dealNum").show();
				}
				
				$.ajax({
					type: "get",
					url: "${pageContext.request.contextPath}/map/searchName/"+name,
					global: false,
					success: function(infos) {
		               	map.panTo(new kakao.maps.LatLng(infos[0].lat, infos[0].lng));
					}
				});
				
               	searchWords = [];
			});
			
			$("#searchWordList").on("click", "li", function(){
				let name = $(this).children("span").text();
				
				$.ajax({
					type: "get",
					url: "${pageContext.request.contextPath}/map/search/"+name,
					global: false,
					success: function(infos) {
						searchWords = infos;
						$("#mapSearchBar").val(name);
					}
				});
			});
			
			// 창 크기 변경 시 동적으로 화면 조정
			$(window).resize(function() {
				let menuBarHeight = $("#menuBar").css("height").replace(/[^0-9]/g, "");
				let bodyHeight = $("body").css("height").replace(/[^0-9]/g, "");
				let dealContentsHeight = bodyHeight - menuBarHeight;
				let dealListHeader = parseInt($("#dealListHeader").css("height").replace(/[^0-9]/g, "")) + 32;
				let searchResultBoxHeight = dealContentsHeight - dealListHeader; 
				$("#searchResultBox").css("height", searchResultBoxHeight);
			});
			
			// 스크롤 더보기
			$("#searchResultBox").scroll(function() {
				let scrollTop = $(this).scrollTop();
				let scrollHeight = $(this).height();
				let resultHeight = $("#searchResult").height();
				if(dealListIdx<list.length && scrollTop>=resultHeight-scrollHeight) $("#searchResult").append(list[dealListIdx++])
			});
			
			// 맵 설정
			var container = document.getElementById('map');
			var options = {
				center: new kakao.maps.LatLng(37.5665734, 126.978179),
				level: 5
			};
			
			// 맵 객체
			map = new kakao.maps.Map(container, options);
			
			// 줌 컨트롤 패널
			var zoomControl = new kakao.maps.ZoomControl();
			map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
			map.setMaxLevel(5);
			
			// 클러스터 설정
			clusterer = new kakao.maps.MarkerClusterer({
		        map: map, 
		        averageCenter: true,
		        gridSize: 160,
		        disableClickZoom: true
		    });
			
			// 커스텀 오버레이
			placeOverlay = new kakao.maps.CustomOverlay({zIndex:1}),
			contentNode = document.createElement("div"),
			placeOverlayMarkers = [],
			currCategory = '';
			
			// 장소 검색 이벤트
			ps = new kakao.maps.services.Places(map);
			kakao.maps.event.addListener(map, 'idle', searchPlaces);
			contentNode.className = 'placeinfo_wrap';
			addEventHandle(contentNode, 'mousedown', kakao.maps.event.preventMap);
			addEventHandle(contentNode, 'touchstart', kakao.maps.event.preventMap);
			placeOverlay.setContent(contentNode);
			addCategoryClickEvent();
			
			// 클러스터 마커 클릭 시 발동 
			kakao.maps.event.addListener(clusterer, 'clusterclick', function(cluster){
				listLoadingRegist();
				let dealList = [];
				let dealGroup = cluster.getMarkers();
				$("#searchResult").empty();
				dealListIdx = 0;
				list = [];
                
				for(let i=0; i<dealGroup.length; i++)
					dealList.push(dealGroup[i].getTitle());
				
				// 매물목록 검색
				$.get("${pageContext.request.contextPath}/map/loadDealInfos/deal/"+dealList.toString(), function(dealInfos) {
                    for(deal of dealInfos) {
                        let result = "<table>";
                        result += "<colgroup><col width='50%'/><col width='50%'/></colgroup>";
                        result += "<tr><td rowspan='4'><img src='/img/myApt.jpg' width='150'></td>"
                        result += "<td colspan='3'><strong><h4 style='display: inline;'>"+deal.aptName+"</h4></strong>";
                        
                        let flag = false;
                        $.each(myInterestList, function(index, el){
                            if(el != deal.no){ // DB에 있다는 거 아직 발견 못 함.
                                return true;
                            } else { // DB에 있다는 거 발견한 경우
                                flag = true;
                                return false;
                            }
                        })
                        
                        if(flag == false){ // DB에 없으면
                            result += "<button type='button' style='border: 0; outline: 0; background-color:transparent;' class='interestBtn' value=\""+deal.no+"\"><img src='/img/empty_heart.png' id='heart"+deal.no+"' width='25'></button></td></tr>";
                        } else { // DB에 있으면
                            result += "<button type='button' style='border: 0; outline: 0; background-color:transparent;' class='interestBtn' value=\""+deal.no+"\"><img src='/img/full_heart.png' id='heart"+deal.no+"' width='25'></button></td></tr>";
                        }
                        
                        result += "<tr><td colspan='3'><strong><h5 style='display: inline;'>"+deal.dealAmount+"</h5></strong> 만원</td></tr>";
                        result += "<tr><td colspan='3'>"+deal.floor+"층, ";

                        result += "<span class='toggle1 area"+deal.no+"'>" + parseInt(deal.area) + "m<sup>2</sup></span>";
                        result += "<span class='toggle2 area"+deal.no+"' style='display:none'>" + parseInt(deal.area / 3.30579) + "평</span>";
                        result += "<button type='button' style='border: 0; outline: 0; background-color:transparent;' class='convertBtn' value=\""+deal.no+"\"><img src='/img/convert.png' class='convert' width='25'></button></td></tr>";
                        result += "</td></tr>";
                        result += "<tr><td colspan='3' align='left'><button class='btn btn-warning detailBtn' value=\""+deal.no+"\">상세 정보 보기</button></td></tr>";
                        result += "</table>";
                        
                        list.push(result);
                    }
                    
                    let size = 5;
                    dealListIdx = 5;
                    
                    if(list.length<5) {
                        size = list.length;
                        dealListIdx = list.length;
                    }
                    
                    for(let i=0; i<size; i++)
                        $("#searchResult").append(list[i]);
                    
                    $("#dealNum").html(dealGroup.length+"개");
                    map.panTo(cluster.getCenter());
                    
                    if($("#searchResultBox").css("display")=="none") {
                    	$("#detailPage").hide();
                    	$("#searchResultBox").show();
                    	$("#dealNum").show();
                    }
                });
			});
			
			// 매물 불러오기
			$.get("${pageContext.request.contextPath}/map/loadHouseInfos", function(houseInfos) {
				houseInfosMap = new Map();
				houseInfoMapCreate(houseInfosMap, houseInfos);
				
				$.get("${pageContext.request.contextPath}/map/loadDealInfos", function(dealInfos) {
					addMarker(houseInfosMap, dealInfos);
				});
			});
			
			// 나의 관심 매물 불러오기
			$.ajax({
                url: "${pageContext.request.contextPath}/myInterest",
                type: "GET",
                success: function (results) {
                    for(result of results){
                        myInterestList.push(result.dealno);
                    }
                },
                error: function (results){
                    alert("에러");
                }
            }); // ajax
		});
		
		function listLoadingRegist() {
			$(document).unbind(".main");
			
			$(document).bind("ajaxStart.getList", function(){
				$("#getListLoading").show();
			});
			
			$(document).bind("ajaxStop.getList", function(){
				$("#getListLoading").hide();
			});
		}
		
		function addEventHandle(target, type, callback) {
			if(target.addEventListener) target.addEventListener(type, callback);
			else target.attachEvent('on'+type, callback);
		}
		
		function searchPlaces() {
			if(!currCategory) return;
			placeOverlay.setMap(null);
			removeMarker();
			ps.categorySearch(currCategory, placesSearchCB, {useMapBounds:true});
		}
		
		function placesSearchCB(data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {
		        displayPlaces(data);
		    } 
		    else if (status === kakao.maps.services.Status.ZERO_RESULT) {

		    } 
		    else if (status === kakao.maps.services.Status.ERROR) {
		        
		    }
		}

		function displayPlaces(places) {
		    var order = document.getElementById(currCategory).getAttribute('data-order');

		    for ( var i=0; i<places.length; i++ ) {
		            var marker = addPlaceMarker(new kakao.maps.LatLng(places[i].y, places[i].x), order);
		            (function(marker, place) {
		                kakao.maps.event.addListener(marker, 'click', function() {
		                    displayPlaceInfo(place);
		                });
		            })(marker, places[i]);
		    }
		}
		
		function addPlaceMarker(position, order) {
		    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
		        imageSize = new kakao.maps.Size(27, 28),  // 마커 이미지의 크기
		        imgOptions =  {
		            spriteSize : new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
		            spriteOrigin : new kakao.maps.Point(46, (order*36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
		            offset: new kakao.maps.Point(11, 28) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
		        },
		        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
		            marker = new kakao.maps.Marker({
		            position: position,
		            image: markerImage 
		        });

		    marker.setMap(map);
		    placeOverlayMarkers.push(marker);

		    return marker;
		}
		
		function removeMarker() {
		    for ( var i = 0; i < placeOverlayMarkers.length; i++ ) {
		    	placeOverlayMarkers[i].setMap(null);
		    }   
		    placeOverlayMarkers = [];
		}

		function displayPlaceInfo (place) {
		    var content = '<div class="placeinfo">' +
		                    '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">' + place.place_name + '</a>';   

		    if (place.road_address_name) {
		        content += '    <span title="' + place.road_address_name + '">' + place.road_address_name + '</span>' +
		                    '  <span class="jibun" title="' + place.address_name + '">(지번 : ' + place.address_name + ')</span>';
		    }  else {
		        content += '    <span title="' + place.address_name + '">' + place.address_name + '</span>';
		    }                
		   
		    content += '    <span class="tel">' + place.phone + '</span>' + 
		                '</div>' + 
		                '<div class="after"></div>';

		    contentNode.innerHTML = content;
		    placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
		    placeOverlay.setMap(map);  
		}

		function addCategoryClickEvent() {
		    var category = document.getElementById('category'),
		        children = category.children;

		    for (var i=0; i<children.length; i++) {
		        children[i].onclick = onClickCategory;
		    }
		}

		function onClickCategory() {
		    var id = this.id,
		        className = this.className;

		    placeOverlay.setMap(null);

		    if (className === 'on') {
		        currCategory = '';
		        changeCategoryClass();
		        removeMarker();
		    } else {
		        currCategory = id;
		        changeCategoryClass(this);
		        searchPlaces();
		    }
		}

		function changeCategoryClass(el) {
		    var category = document.getElementById('category'),
		        children = category.children,
		        i;

		    for ( i=0; i<children.length; i++ ) {
		        children[i].className = '';
		    }

		    if (el) {
		        el.className = 'on';
		    } 
		} 
		
		function houseInfoMapCreate(houseInfosMap, houseInfos) {
			for(let i=0; i<houseInfos.length; i++)
				houseInfosMap.set(houseInfos[i].aptName, houseInfos[i]);
		}
		
		function addMarker(houseInfosMap, dealInfos) {
			imageSrc = '/img/house_marker.png';
			imageSize = new kakao.maps.Size(64, 69);
			imageOption = {offset: new kakao.maps.Point(27, 69)};
			markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
			
			for(let i=0; i<dealInfos.length; i++) {
				let currInfo = houseInfosMap.get(dealInfos[i].aptName);
				if(currInfo!=null){
					marker = new kakao.maps.Marker({
					    position: new kakao.maps.LatLng(currInfo.lat, currInfo.lng),
					    title: dealInfos[i].no,
					    image: markerImage
					});
					houseMarker.push(marker);
				}
			}
			clusterer.addMarkers(houseMarker);
		}
	</script>

	<!-- 지도 및 매물 목록 -->
	<div class="row" id="dealContents">
		<!-- 검색창 -->
		<div id="select-opt">
			<div id="mapSearchBox" class="d-flex justify-content-center">
				<input id="mapSearchBar" type="text" class="form-control form-control-sm" placeholder="이름을 입력해주세요.">
				<button id="searchBtn" class="btn btn-success btn-sm">검색</button>
			</div>
			<div id="mapFilterAccordion">
				<div class="card" id="mapFilterBox">
					<div class="card-header" id="card-header">
						<a class="card-link" id="card-link" data-toggle="collapse" href="#detailSearchBtn"> 상세 검색 </a>
					</div>
					<div id="detailSearchBtn" class="collapse"
						data-parent="#mapFilterAccordion">
						<div class="card-body">
							<table id="selectOptTable">
								<tr>
									<td class="dosiName">시도 :</td>
									<td><select id="sido" class="searchUI"><option value="0">선택</option></select></td>
								</tr>
								<tr>
									<td class="dosiName">구군 :</td>
									<td><select id="gugun" class="searchUI"><option value="0">선택</option></select></td>
								</tr>
								<tr>
									<td class="dosiName">읍면동 :</td>
									<td><select id="dong" class="searchUI"><option value="0" id="dongValue">선택</option></select></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<ul id="searchWordList"></ul>
			</div>
		</div>

		<!-- 지도 -->
		<div id="map" class="map_wrap"></div>
		<ul id="category">
	        <li id="BK9" data-order="0"> 
	            <span class="category_bg bank"></span>
	            은행
	        </li>       
	        <li id="MT1" data-order="1"> 
	            <span class="category_bg mart"></span>
	            마트
	        </li>  
	        <li id="PM9" data-order="2"> 
	            <span class="category_bg pharmacy"></span>
	            약국
	        </li>  
	        <li id="OL7" data-order="3"> 
	            <span class="category_bg oil"></span>
	            주유소
	        </li>  
	        <li id="CE7" data-order="4"> 
	            <span class="category_bg cafe"></span>
	            카페
	        </li>  
	        <li id="CS2" data-order="5"> 
	            <span class="category_bg store"></span>
	            편의점
	        </li>      
    	</ul>
		<!-- 매물 목록 -->
		<div id="dealList">
			<div id="dealListHeader">
				<hr>
				<button class='btn btn-info' id='listBtn' style="border: 0; outline: 0; background-color:transparent; display: none;">
					<img src='/img/arrow.png' width='30px;' height='30px;' />
				</button>
				<h4 id="dealListImg"><img src="/img/dealList.png" height="80"> <span id="dealNum"></span></h4>
				<hr>
			</div>
			<div id="searchResultBox">
				<div id="getListLoading">
					<img src="/img/loading.gif" width="150" height="150">
				</div>
				<table class="table table-bordered" id="searchResult">
					<tr><td><img src="/img/firstList.png" width="100%"></td></tr>
				</table>
			</div>
			<div id="detailPage"></div>
		</div>
	</div>
	<script>
		$(document).ready(function(){
			$.ajax({
				type: "get",
				url: "${pageContext.request.contextPath}/map/sido",
				dataType: "json",
				global: false,
				success: function(data) {
					$.each(data, function(index, vo) {
						$("#sido").append("<option value='"+vo.sidoCode+"'>"+vo.sidoName+"</option>");
					});//each
				}
			})
		});//ready
		$(document).ready(function(){
			$("#sido").change(function() {
				hsido = $("#sido").val();
				$.ajax({
					type: "get",
					url: "${pageContext.request.contextPath}/map/gugun",
					data: {sido:$("#sido").val()},
					dataType: "json",
					global: false,
					success: function(data) {
						$("#gugun").empty();
						$("#gugun").append('<option value="0">선택</option>');
						$.each(data, function(index, vo) {
							$("#gugun").append("<option value='"+vo.gugunCode+"'>"+vo.gugunName+"</option>");
						});//each
					}
				})
			});//change
			$("#gugun").change(function() {
				hgungu = $("#gugun").val();
				$.ajax({
					type: "get",
					url: "${pageContext.request.contextPath}/map/dong",
					data: {gugun:$("#gugun").val()},
					dataType: "json",
					global: false,
					success: function(data) {
						$("#dong").empty();
						$("#dong").append('<option value="0">선택</option>');
						$.each(data, function(index, vo) {
							$("#dong").append("<option value='"+vo.dong+"'>"+vo.dong+"</option>");
						});//each
					}
				})
			});//change
			$("#dong").change(function() {
				listLoadingRegist();
				let dong = $("#dong").val();	
				$("#searchResult").empty();
				dealListIdx = 0;
				list = [];
				
				// 지역으로 매물목록 검색
                $.get("${pageContext.request.contextPath}/map/loadDealInfos/dong/"+dong, function(dealInfos) {
                    for(value of dealInfos) {
                        let result = "<table>";
                        result += "<colgroup><col width='50%'/><col width='50%'/></colgroup>";
                        result += "<tr><td rowspan='4'><img src='/img/myApt.jpg' width='150'></td>"
                        result += "<td colspan='3'><strong><h4 style='display: inline;'>"+value.aptName+"</h4></strong>";
                        
                        let flag = false;
                        $.each(myInterestList, function(index, el){
                            if(el != value.no){ // DB에 있다는 거 아직 발견 못 함.
                                return true;
                            } else { // DB에 있다는 거 발견한 경우
                                flag = true;
                                return false;
                            }
                        })

                        if(flag == false){ // DB에 없으면
                            result += "<button type='button' style='border: 0; outline: 0; background-color:transparent;' class='interestBtn' value=\""+value.no+"\"><img src='/img/empty_heart.png' id='heart"+value.no+"' width='25'></button></td></tr>";
                        } else { // DB에 있으면
                            result += "<button type='button' style='border: 0; outline: 0; background-color:transparent;' class='interestBtn' value=\""+value.no+"\"><img src='/img/full_heart.png' id='heart"+value.no+"' width='25'></button></td></tr>";
                        }

                        result += "<tr><td colspan='3'><strong><h5 style='display: inline;'>"+value.dealAmount+"</h5></strong> 만원</td></tr>";
                        result += "<tr><td colspan='3'>"+value.floor+"층, ";
                        
                        result += "<span class='toggle1 area"+value.no+"'>" + parseInt(value.area) + "m<sup>2</sup></span>";
                        result += "<span class='toggle2 area"+value.no+"' style='display:none'>" + parseInt(value.area / 3.30579) + "평</span>";
                        result += "<button type='button' style='border: 0; outline: 0; background-color:transparent;' class='convertBtn' value=\""+value.no+"\"><img src='/img/convert.png' class='convert' width='25'></button></td></tr>";
                        result += "</td></tr>";
                        result += "<tr><td colspan='3' align='left'><button class='btn btn-warning detailBtn' value=\""+value.no+"\">상세 정보 보기</button></td></tr>";
                        result += "</table>";
                        
                        list.push(result);
                    }
                    
                    let size = 5;
                    dealListIdx = 5;
                    
                    if(list.length<5) {
                        size = list.length;
                        dealListIdx = list.length;
                    }
                    
                    for(let i=0; i<size; i++)
                        $("#searchResult").append(list[i]);
                    
                    $("#dealNum").html(list.length+"개");
                    $.get("${pageContext.request.contextPath}/map/address/"+dong, function(address) {
                        map.panTo(new kakao.maps.LatLng(address.lat, address.lng));
                    });
                });
	        });//change

			// 평 <-> m^2 변환 버튼 이벤트
			$(document).on("click", ".convertBtn", function(){
				let dealNo = $(this).val();
				let thisArea = parseInt($("#area"+dealNo).text());
				if(toggleFlag == false){ // 평으로 환산하기
					 $(".toggle1").filter(".area"+dealNo).hide();
					 $(".toggle2").filter(".area"+dealNo).show();
					 toggleFlag = true;
				} else { // m^2로 환산하기
					 $(".toggle1").filter(".area"+dealNo).show();
					 $(".toggle2").filter(".area"+dealNo).hide();
					 toggleFlag = false;
				}
			 }); // click convertBtn
			 
	     // 관심매물 추가 버튼 이벤트
            $(document).on("click", ".interestBtn", function (){
                if($(this).children('img').attr("src") == "/img/empty_heart.png"){
                    myInterestList.push($(this).val());
                    $.ajax({
                        url: "${pageContext.request.contextPath}/insertInterest",
                        type: "POST",
                        data: {
                            dealNo: $(this).val(),
                        },
                        success: function (dealNo) {
                            $("#heart"+dealNo).attr("src","/img/full_heart.png");
                        },
                        error: function (dealNo){
                            alert("이미 추가된 매물입니다.");
                        }
                    })
                } else if($(this).children('img').attr("src") == "/img/full_heart.png"){
                    for(var i=0; i<myInterestList.length; i++){
                        if(myInterestList[i] == $(this).val()){
                            delete myInterestList[i];
                        }
                    }
                    $.ajax({
                        url: "${pageContext.request.contextPath}/deleteInterest",
                        type: "POST",
                        data: {
                            dealNo: $(this).val(),
                        },
                        success: function (dealNo) {
                            $("#heart"+dealNo).attr("src","/img/empty_heart.png");
                        },
                        error: function (dealNo){
                            alert("이미 삭제된 매물입니다.");
                        }
                    })
                }
            });// click Interest btn
			
			// 상세정보 보기 버튼 이벤트
            $("#searchResult").on("click", ".detailBtn", function (){
            	$('#listBtn').show();
            	$('#dealListImg').hide();
            	// 상세 정보 테이블 만들기
				$.get("${pageContext.request.contextPath}/detail"
						,{dong:$("#dong").val(), dealNo: $(this).val()}
						,function(theDeal){
							$("#detailPage").empty();
							$("#searchResultBox").hide();
							$("#detailPage").show();
							
                            let result = "<table class='table table-bordered'>";
                            result += "<tr><td colspan='4'><img src='/img/myApt.jpg' width='300' align='center'></td></tr>"
                            result += "<tr><td>이름</td><td colspan='3'><strong><h2>"+theDeal.aptName+"</h2></strong></td></tr>";
                            result += "<tr><td>거래 금액</td><td colspan='3'><strong><h2 style='display: inline;'>"+theDeal.dealAmount+"</h2></strong><h3 style='display: inline;'> 만원</h3></td></tr>";
                            result += "<tr><td>동(지번)</td><td><strong>"+theDeal.dong+"("+theDeal.jibun+")</strong><td>거래일</td><td><strong>"+theDeal.dealYear+"년 " +theDeal.dealMonth+"월 "+theDeal.dealDay+"일</strong></td></tr>";
                            result += "<tr><td>층</td><td><strong>"+theDeal.floor+"</strong></td><td>넓이</td><td><strong>"+parseInt(theDeal.area)+"</strong></td></tr>";
                            result += "</table>";
                            
                            $.ajax({
                                url: "${pageContext.request.contextPath}/qnaList",
                                type: "GET",
                                async: false,
                                data: {
                                    dealno: theDeal.no,
                                    userid: theDeal.type,
                                },
                                success: function (data) {
                                    result += data;
                                },
                                error: function (dealNo){
                                    alert("에러..");
                                }
                            })
                            
                            $("#detailPage").append(result);
                            $("#dealNum").hide();
						}//function
						, "json"
				);//get
			});// click detail btn
			
			// 매물 목록 돌아가기
            $(document).on("click", "#listBtn", function(){
            	$('#listBtn').hide();
            	$('#dealListImg').show();
				$("#detailPage").hide();
            	$("#searchResultBox").show();
            	$("#dealNum").show();
            });// click list btn
		});//ready
	</script>
</body>
</html>