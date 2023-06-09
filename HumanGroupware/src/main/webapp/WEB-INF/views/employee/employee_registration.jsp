<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 부서 변경</title>
<link type="text/css" rel="stylesheet" href="/resources/css/employee_registration.css">
</head>
<body>
<!-- 임시 링크용 -->
<div class="option" style="border:0.1px solid black; width:150px;text-align:center;">
	<a>[임시 링크용 div]</a>
	<div>
		<a href="/employee/organization">조직도</a><br>
		<a href="/employee/inquiry">직원조회</a><br>
		<a href="/employee/registration">부서/직급변경</a><br>
		<a href="/attendance/current">근태현황</a><br>
		<a href="/attendance/management">근태관리</a><br>
		<a href="/attendance/byEmployee">직원별 근태현황</a>
	</div>
</div>
<!-- 임시 링크용 -->

<!-- 사원관리 / 상세 -->
<div class="inquiry_main">
		<a>부서/직급 변경</a>
	</div>
<div>
	
	<div class="employee_all">
		<div>
			<div class="employee_people">
				<div class="image">
					<img src="/resources/img/people.png">
					
				</div>				
				<div class="test">
					<div class="input_box_name">
						<a class="a_box_name">사 원 명</a>
						<input type=text id="employee_kname" class="input_type">
					</div>
					<div class="input_box_name">
						<a class="a_box_name">연 락 처</a>
						<input type=text id="employee_phone" class="input_type">
					</div>
					<div class="input_box_name">
						<a class="a_box_name">이 메 일</a>
						<input type=text id="employee_email" class="input_type">
					</div>
					<div class="input_box_name">
						<a class="a_box_name">아 이 디</a>
						<input type=text id="employee_id" class="input_type">
					</div>
					
				</div>
			</div>
			<div class="test2">
				<div class="emp_depart_box">
					입 사 일 자<input type=date id=entering_date class="input_box_result">
				</div>
				
				<div class="emp_depart_box">
					<a id=employee_team1>부 서</a>
					<input type="text" id="employee_team2"  value="" class="input_box_result" disabled>
					<select id="select_team" name="select_team" class="input_box_select">
						<option value="1">선택</option>
					</select>
	
				</div>
				<div class="emp_depart_box">
					<a id=employee_position1>직 급</a>
					<input type="text" id="employee_position2" value=""class="input_box_result" disabled>
					<select id="select_position" name="select_position" class="input_box_select">
						<option value="1">선택</option>
					</select>
				</div>
				
				<div class="emp_depart_box">
					<a id=employee_form>고 용 형 태</a>
					<input type="text" id="employee_form2"  value=""class="input_box_result" disabled>
					<select id="select_form" name="select_form" class="input_box_select">
						<option value="1">선택</option>
					</select>
				</div>
							
				<div>
					<input type=hidden id=emp_position1>
					<input type=hidden id=emp_depart1>
				</div>
			</div>
			<div>
				<input type="button" value="등록" id=employee_insert3 class="insert_btn">
			</div>
	</div>
</div>
</div>

			
</body>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document).ready(function(){
	loadExemployee();
	loadDep_name();
	loadPos_name();
	loadJob_type();
	
})
// select 직접입력 
	// 이메일
	.on("change", "#select_team", function(){
		let selectedOption = $(this).children("option:selected").val();
		console.log(selectedOption);
	 })
	$('#selectEmail').change(function(){
	   $("#selectEmail option:selected").each(function () {
			if($(this).val()== '1'){
				 $("#employee_email3").val('');
				 $("#employee_email3").attr("disabled",false); 
			}else{ 
				 $("#employee_email3").val($(this).text());
				 $("#employee_email3").attr("disabled",true);
			}});
	});
	// 직급
	$('#select_position').change(function(){
		   $("#select_position option:selected").each(function () {
				if($(this).val()== '1'){
					 $("#employee_position2").val('');
					 $("#employee_position2").attr("disabled",true); 
				}else{ 
					 $("#employee_position2").val($(this).text());
					 $("#employee_position2").attr("disabled",true);
					 loadExemployee();
				}});
	});
	// 고용형태
	$('#select_form').change(function(){
		   $("#select_form option:selected").each(function () {
				if($(this).val()== '1'){
					 $("#employee_form2").val('');
					 $("#employee_form2").attr("disabled",true); 
				}else{ 
					 $("#employee_form2").val($(this).text());
					 $("#employee_form2").attr("disabled",true);
					 loadExemployee();
				}});
	});
	// 부서
	$('#select_team').change(function(){
		   $("#select_team option:selected").each(function () {
				if($(this).val()== '1'){
					 $("#employee_team2").val('');
					 $("#employee_team2").attr("disabled",true); 
				}else{ 
					 $("#employee_team2").val($(this).text());
					 $("#employee_team2").attr("disabled",true);
					 loadExemployeeDep();					 
				}});
	});
	
	// 사원 정보 업데이트 ( update ) department_insert0  employee_insert
	$('#employee_insert3').on("click",function(){
 		$.ajax({
			url:'/employee_update0',
			data:{emp_join:$('#entering_date').val(),
				   emp_position:$('#emp_position1').val(),
				   emp_depart:$('#emp_depart1').val(),
				   emp_id:$('#employee_id').val()},
			type:'post',
			dataType:'text',
			beforeSend:function(){
		        let emp_position = $.trim($('#emp_position1').val());
		        let employee_team = $.trim($('#employee_team2').val());
		           if(emp_position==""||emp_position==null){
		              alert('직급, 고용형태를 잘못 선택하셨습니다.');
		              return false;
		           }
		           if(employee_team==""||employee_team==null){
			              alert('부서를 미선택 하셨습니다.');
			              return false;
			           }
			},
			success:function(data){
				if(data=="ok"){
					alert('정보 입력이 완료되었습니다.')
					document.location.href="/employee/registration";
				}else{
					alert('알수 없는 오류가 발생하였습니다.')
					document.location.href="/employee/registration";
				}
			}
		})
	})
	
// 한글, 영어만 입력가능
	function employee_kor(e)  {
		e.value = e.value.replace(/[^가-힣]/ig, '')
	}

// select option (부서, 직급, 고용형태) 불러오기
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
	function loadJob_type(){
		$.ajax({url:'/form_select0',
				 type:'post',
				 dataType:'json',
				 success:function(data){
					 for(let i=0; i<data.length; i++){
						 form0 = data[i];
						 let option='<option value='+form0['job_type']+'>'+form0['job_type']+'</option>';
						 $('#select_form').append(option);
					 }},
	})}
	
	// 직급, 고용형태 position_id 확인 ( hidden ) emp_depart1
	function loadExemployee(){
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
})}
	
	

</script>
</html>