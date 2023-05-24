<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>사원 조회 페이지</title>
</head>
<body>


<!-- 사원관리 / 상세 -->
<div id=employee_box>

	<!-- 공통 -->
	<div id=employeeMain>
		<div id=employeeOption>사원 관리</div>
		
		<div id=organization><a href="/hw/employee/organization">조직도</a></div>
		<div id=inquiry><a href="/hw/employee/inquiry">사원 조회</a></div>
		<div id=registration><a href="/hw/employee/registration">사원 등록</a></div>
	</div>
	
	<!-- 상세 -->
	<div>
		<div>
			사원 조회
		</div>
		<div>
			<select id="select_team"  name="select_team" style="width:80px; " value="부서명">
				<option value="부서명">부서명</option>
			</select>
			
			<select id="select_position"  name="select_position" style="width:80px;" value="직급">
				<option value="직급">직급</option>
			</select>
			
			<select id="select_form"  name="select_form" style="width:80px;" value="고용형태">
				<option value="고용형태">고용형태</option>
			</select>
			
			<input type=text style="width:80px;" placeholder="이름">
			<input type=text style="width:100px;" placeholder="번호[-제외]">
			<input type=text style="width:150px;" placeholder="이메일주소[@제외]">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  				<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
				</svg>
		</div>
		<div>
						


		</div>
	</div>

</div>
</body>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document).ready(function(){
	loadDep_name();
	loadPos_name();
	loadJob_type();
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

</script>
</html>