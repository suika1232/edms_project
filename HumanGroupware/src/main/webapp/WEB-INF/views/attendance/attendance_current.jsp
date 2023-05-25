<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근태 현황</title>
</head>
<body>

<div>
<!-- 공통 -->
	<div id=employeeMain>
		<div id=employeeOption>나의 근태 관리</div>
		
		<div id=organization><a href="/hw/attendance/current">근태 현황</a></div>
		<div id=inquiry><a href="/hw/attendance/management">근태 관리</a></div>
		<div id=registration><a href="/hw/attendance/byEmployee">사원별 근태 현황</a></div>
	</div>
	
	<div>
		<div>
			<div>
				월별 확인
				 <label>1</label><input type="checkbox" id=checkboxCurrent>
				 <label>2</label><input type="checkbox" id=checkboxCurrent>
				 <label>3</label><input type="checkbox" id=checkboxCurrent>
				 <label>4</label><input type="checkbox">
				 <label>5</label><input type="checkbox">
				 <label>6</label><input type="checkbox">
				 <label>7</label><input type="checkbox">
				 <label>8</label><input type="checkbox">
				 <label>9</label><input type="checkbox">
				 <label>10</label><input type="checkbox">
				 <label>11</label><input type="checkbox">
				 <label>12</label><input type="checkbox">
			</div>
			<div>
				근태 현황
			</div>
		</div>
		<div>
			현황 테이블
		</div>
		<div>
			달력
		</div>
		<div>
			<div>
				이번달 출근 일수 <input type=text style="width:50px;">
			</div>
			<div>
				이번달 지각 일수 <input type=text style="width:50px;">
			</div>
			<div>
				이번달 야근 일수 <input type=text style="width:50px;">
			</div>
			<div>
				이번달 외근 일수 <input type=text style="width:50px;">
			</div>
		</div>
	</div>
</div>
	
</body>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document).ready(function(){
	
})

</script>
</html>