<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근태 관리</title>
<link type="text/css" rel="stylesheet" href="/resources/css/attendance_management.css">
</head>
<body>
<!-- 임시 링크용 -->
<div class="option" style="border:0.1px solid black; width:150px;text-align:center;">
	<a>[임시 링크용 div]</a>
	<div>
		<a href="/employee/organization">조직도</a><br>
		<a href="/employee/inquiry">직원조회</a><br>
		<a href="/employee/registration">부서변경</a><br>
		<a href="/attendance/current">근태현황</a><br>
		<a href="/attendance/management">근태관리</a><br>
		<a href="/attendance/byEmployee">직원별 근태현황</a>
		<input type=button value="출근">
		<input type=button value="퇴근">
	</div>
</div>
<!-- 임시 링크용 -->
<div class="Mysession_container">
		<div id="Show-img_box"></div>
		<div id="MY_box">
			<% if(session.getAttribute("emp_name") != null && session.getAttribute("emp_id")!="") {%>
				이름: ${ emp_name} 
				<div id=emp_depart>부서: </div>
				<div id="My_box1">
				<a href='/employee/mypage'>마이페이지</a>
				<a href='/employee/logout'>로그아웃</a>
				</div>
			<% } else {%>
				로그인 후 이용해주세요
				<div class="My_box2">
				<a href='/employee/login'>로그인</a>
				<a href="/employee/signin">회원가입</a><br>
				</div>
			<% } %>
		</div>
	</div>
<div class="inquiry_main">
	<a>근태관리</a>
</div>

<div class="all_dataSend">
	<div class="data_div">
	자료
	</div>

	<div class="send_div">
	전송
	</div>
</div>

<input type="button" value="전송" id=employee_insert3 class="send_btn">




<!-- <select style="width:200px;" id="addressee_select" name="addressee_select">
				
</select> -->
</body>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document).ready(function(){
	loadAtt_employee();
})

// 직원 이름 불러오기 ( select )
	function loadAtt_employee(){
		$.ajax({url:'/attendance_employee0',
				 type:'post',
				 dataType:'json',
				 
				 success:function(data){
					 console.log('실행');
					 for(let i=0; i<data.length; i++){
						 employee1 = data[i];
						 let option='<option value='+employee1['emp_name']+'>'+employee1['emp_name']+'['+employee1['emp_email']+']</option>';
						 $('#addressee_select').append(option);
					 }},
	})}
</script>
</html>