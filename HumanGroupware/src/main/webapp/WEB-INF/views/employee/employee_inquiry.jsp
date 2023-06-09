<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>사원 조회 페이지</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;700&display=swap" rel="stylesheet">   
<link type="text/css" rel="stylesheet" href="/resources/css/employee_inquiry.css">
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
	</div>
</div>
<!-- 임시 링크용 -->

<!-- 사원관리 / 상세 -->
<div>
	
	<!-- 상세 -->
	<div class="employee_Box">
		<div class="inquiry_main">
			<a>직원 조회</a>
		</div>
		<div class="select_ch"	>
			<div class="select_ch_all">
				<select class="select_team" id="select_team"  name="select_team" style="width:80px; " value="부서명">
					<option value="">전체</option>
				</select>
				<select class="select_position" id="select_position"  name="select_position" style="width:80px;" value="직급">
					<option value="">전체</option>
				</select>
				
				<input class="name_input" type=text placeholder="이름" id="name_input">
				<input class="number_input" type=text placeholder="번호[-제외]" id="number_input">
				<input class="mail_input" type=text  placeholder="이메일주소[@포함]" id="mail_input">
				<input class="select_btn" type=button value="검색" id=button>
				<input type=hidden id=employee_team2><br>
				<input type=hidden id=employee_position2><br>
				<input type=hidden id=employee_form2>
			</div>
		</div>
		<div class="list" id="list">

		</div>
	</div>

</div>
</body>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document).ready(function(){
	loadDep_name();
	loadPos_name();
})

// 검색, 사원 조회 ( select )
$('#button').on('click', function(){
	$('#list').empty();
		$.ajax({url:'/employee_search',
			type:'post',
			dataType:'json',
			data:{emp_name:$('#name_input').val(), 
				   emp_mobile:$('#number_input').val(), 
				   emp_email:$('#mail_input').val(), 
				   dep_name:$('#employee_team2').val(),
				   position_name:$('#employee_position2').val()
			},
			success:function(data){
				for(let i=0; i<data.length; i++){
					empData = data[i];
					let divResult = '<div class = "line"><div class = "user"><div class="profile"><img src="/resources/img/people.png"></div>'
										+'<div class = "details"><h1 class = "name">'+empData['emp_name']+' '+empData['position_name']+'</h1></div></div>'
										+'<div class = "department"><p>'+empData['dep_name']+'</p></div>'
										+'<div class = "gender"><span></span><p>'+empData['emp_gender']+'</p></div>'
										+'<div class = "email"><p>'+empData['emp_email']+'</p></div>'
										+'<div class="phone"><p>0'+empData['emp_mobile']+'</p></div>'
				            			+'<div class="job_type"><p>'+empData['job_type']+'</p></div>'
			            				+'<div class="message"><a href="#" class="btn"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-envelope-fill" viewBox="0 0 16 16"><path d="M.05 3.555A2 2 0 0 1 2 2h12a2 2 0 0 1 1.95 1.555L8 8.414.05 3.555ZM0 4.697v7.104l5.803-3.558L0 4.697ZM6.761 8.83l-6.57 4.027A2 2 0 0 0 2 14h12a2 2 0 0 0 1.808-1.144l-6.57-4.027L8 9.586l-1.239-.757Zm3.436-.586L16 11.801V4.697l-5.803 3.546Z"/></svg></a></div></div>';
			            				
			            				$('#list').append(divResult);
					$('#name_input').val('');
					$('#number_input').val('');
					$('#mail_input').val('');
				}}})})

				
				
	// 직급 hidden 저장 select 클릭
	$('#select_position').on('click',function(){
		   $("#select_position option:selected").each(function () {
				if($(this).val()== ''){
					 $("#employee_position2").val('');
					 $("#employee_position2").attr("disabled",true); 
				}else{ 
					 $("#employee_position2").val($(this).text());
					 $("#employee_position2").attr("disabled",true);
					 
				}});
	});
	// 고용형태 hidden 저장 select 클릭
	$('#select_form').on('click',function(){
		   $("#select_form option:selected").each(function () {
				if($(this).val()== ''){
					 $("#employee_form2").val('');
					 $("#employee_form2").attr("disabled",true); 
				}else{ 
					 $("#employee_form2").val($(this).text());
					 $("#employee_form2").attr("disabled",true);
				}});
	});
	// 부서 hidden 저장 select 클릭
	$('#select_team').on('click',function(){
		   $("#select_team option:selected").each(function () {
				if($(this).val()== ''){
					 $("#employee_team2").val('');
					 $("#employee_team2").attr("disabled",true);				
					}else{ 
					 	$("#employee_team2").val($(this).text());
					 	$("#employee_team2").attr("disabled",true);
				}});
	});
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
		
	// 직급명 불러오기 ( select )
	function loadPos_name(){
		$.ajax({url:'/position_select0',
				 type:'post',
				 dataType:'json',
				 success:function(data){
					 for(let i=0; i<data.length; i++){
						 position0 = data[i];
						 let option='<option value='+position0['position_name']+'>'+position0['position_name']+'</option>';
						 $('#select_position').append(option);
					 }},
	})}
	
	// 고용형태 불러오기 ( select )
/* 	function loadJob_type(){
		$.ajax({url:'/form_select0',
				 type:'post',
				 dataType:'json',
				 success:function(data){
					 for(let i=0; i<data.length; i++){
						 form0 = data[i];
						 let option='<option value='+form0['job_type']+'>'+form0['job_type']+'</option>';
						 $('#select_form').append(option);
					 }},
	})} */

	// 직급, 고용형태 position_id 확인 ( hidden ) emp_depart1
/*  	function loadExemployee(){
		$.ajax({url:'/exemploye_select1',
			 type:'post',
			 dataType:'json',
			 data:{position_name:$('#employee_position2').val(), job_type:$('#employee_form2').val()},
			 success:function(data){
				 for(let i=0; i<data.length; i++){
					 ex0 = data[i];
					 let ex= ex0['position_id']
					 $('#emp_position1').val(ex);
				 }},
})}
	function loadExemployeeDep(){
		$.ajax({url:'/exemployee_select2',
			 type:'post',
			 dataType:'json',
			 data:{dep_name:$('#employee_team2').val()},
			 success:function(data){
				 for(let i=0; i<data.length; i++){
					 ex0 = data[i];
					 let ex= ex0['dep_id']
					 $('#emp_depart1').val(ex);
				 }},
})} */
</script>
</html>