<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="sectionContainerCenter">
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a4e58e65f7bc7583810d3845840f24f3"></script>
	<div id="mapContainer" style="width: 100%; height: 100%;"></div>
	<script>
		const options = { //지도를 생성할 때 필요한 기본 옵션
			center: new kakao.maps.LatLng(35.865585, 128.592569), //지도의 중심좌표.
			level: 3 //지도의 레벨(확대, 축소 정도)
		};
	
		const map = new kakao.maps.Map(mapContainer, options); //지도 생성 및 객체 리턴
	</script>
</div> 