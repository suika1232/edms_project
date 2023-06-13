<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원별 근태현황</title>
<link type="text/css" rel="stylesheet" href="/resources/css/attendance_byemployee.css">
</head>
<body>

<!-- 임시 링크용 -->
<div class="option" style="border:0.1px solid black; width:150px;text-align:center;">
	<a>[임시 링크용 div]</a>
	<div>
		<a href="/employee/organization">조직도</a><br>
		<a href="/employee/inquiry">사원조회</a><br>
		<a href="/employee/registration">사원등록</a><br>
		<a href="/attendance/current">근태현황</a><br>
		<a href="/attendance/management">근태관리</a><br>
		<a href="/attendance/byEmployee">사원별 근태현황</a>
		<input type=button value="출근" id="start_id">
		<input type=button value="퇴근" id="end_id">
	</div>
</div>
<!-- 임시 링크용 -->
<div class="Mysession_container">
		<div id="Show-img_box"></div>
		<div id="MY_box">
			<% if(session.getAttribute("emp_name") != null && session.getAttribute("emp_id")!="") {%>
				이름: ${ emp_name} , ${emp_id }
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
		<a>직원별 근태현황</a>
	</div>
		<div class="select_ch"	>
			<div class="select_ch_all">
				<select class="select_team" id="select_team"  name="select_team" value="부서명">
					<option value="">전체</option>
				</select>
				
				<input class="name_input" type=date id="name_input">
				<input class="select_btn" type=button value="검색" id=select_btn>
			</div>
		</div>
<div class="employee_data">
<table class="employee_table" id="employee_table">
	<thead>
		<tr class="tr_table">
			<td class="td_3px">이름</td>
			<td class="td_3px">부서</td>
			<td class="td_3px">직급</td>
			<td class="td_5px">출근</td>
			<td class="td_5px">퇴근</td>
			<td class="td_5px">야근</td>
			<td class="td_5px">조퇴</td>
			<td class="td_3px">외근</td>
			<td class="td_3px">휴가</td>
		</tr>
	</thead>
	<tbody id="employee_tbody">
	</tbody>
</table>
<input type=hidden id="id_value">
</div>

</body>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document).ready(function(){
	loadDep_name();
	loadatt_id();
	var now = new Date();
	var year = now.getFullYear();
})

/* 출근, 퇴근 임시 확인용 */
$('#start_id').on('click',function(){
		$.ajax({url:'/attendance_start_id',  
				type:'post', 
				dataType:'text',
				data:{emp_no:$('#id_value').val()
						},
				success:function(data){
					if(data=='ok'){
						alert('출근 성공');
					} else{
						alert("오류");
					}
				}
		})
	})
$('#end_id').on('click', function(){
	$.ajax({url:'/attendance_end_id',
			 type:'post',
			 dataType:'text',
			 data:{emp_no:$('#id_value').val(),
				 
			 },
			 success:function(data){
				 if(data=='ok'){
					 alert('퇴근 성공');
				 } else{
					 alert("오류");
				 }}
})
})


$('#select_btn').on('click',function(){
	$('#employee_tbody').empty();
	let date = $('#name_input').val();
	let replaces_date = date.replace(/-/g,'');
	console.log(date);
	$.ajax({url:"/attendance_list",
			 type:'post',
			 dataType:'json',
			 data:{dep_name:$('#select_team').val(),
				 	attend_date:$('#name_input').val(),},
	success:function(data){
		for(let i = 0; i<data.length; i++){
			list = data[i];
			let attList = '<tr><td class="td_3spx">'+list['emp_name']+'</td>'	// 이름
						 + '<td class="td_3spx">'+list['dep_name']+'</td>'			// 부서
						 + '<td class="td_3spx">'+list['position_name']+'</td>'	// 직급
						 + '<td class="td_5spx">'+list['start_time']+'</td>'			// 출근
						 + '<td class="td_5spx">'+list['end_time']+'</td>'			// 퇴근
						 + '<tr>';
			$('#employee_tbody').append(attList);
			console.log(attList);
		}}
	})
})



//select option (부서, 직급, 고용형태) 불러오기
	// 부서명 불러오기 ( select )
	function loadDep_name(){
		$.ajax({url:'/department_select0',
				 type:'post',
				 dataType:'json',
				 success:function(data){
					 for(let i=0; i<data.length; i++){
						 team0 = data[i];
						 let option= '<option value='+team0['dep_name']+'>'+team0['dep_name']+'</option>'; 
						 $('#select_team').append(option);
					 }},
	})}
	
// 사원 번호 불러오기 ( select )
	function loadatt_id(){
	$.ajax({url:'/id_load_select',
			 type:'post',
			 dataType:'json',
			 data:{emp_id:'${emp_id}'},
			 success:function(data){
				 for(let i=0; i<data.length; i++){
					 id = data[i];
					 let emp_no = id['emp_no'];
					 $('#id_value').val(emp_no);
					 console.log(emp_no);
					 }
			 }})
}
</script>
</html>