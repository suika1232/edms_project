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
	</div>
</div>
<!-- 임시 링크용 -->
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

</div>

</body>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document).ready(function(){
	loadDep_name();
})

$('#select_btn').on('click',function(){
	$('#employee_tbody').empty();
	let date = $('#name_input').val();
	let replaces_date = date.replace(/-/g,'');
	console.log(replaces_date);
	$.ajax({url:"/attendance_list",
			 type:'post',
			 dataType:'json',
			 data:{dep_name:$('#select_team').val(),
				 	no:replaces_date},
		/* 날짜 넣었을 경우 필요 */
 		/* beforeSend:function(){
           if(replaces_date==""||replaces_date==null){
              alert('날짜를 선택하여주십시오.');
              return false;
           }
	}, */
	success:function(data){
		for(let i = 0; i<data.length; i++){
			list = data[i];
			let attList = '<tr><td class="td_3spx">'+list['emp_name']+'</td>'	// 이름
						 + '<td class="td_3spx">'+list['dep_name']+'</td>'			// 부서
						 + '<td class="td_3spx">'+list['position_name']+'</td>'		// 직급
						 + '<tr>';
			$('#employee_tbody').append(attList);
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
</script>
</html>