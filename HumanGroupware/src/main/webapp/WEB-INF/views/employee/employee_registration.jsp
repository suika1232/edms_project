<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css?family=Ubuntu" rel="stylesheet">
<title>사원 등록 페이지</title>
</head>
<style>
  #imageContainer {
    width: 150px;
    height: 200px;
    background-size: contain;
    background-repeat: no-repeat;
    background-position: center;
    border:1px solid #000;
  }
</style>



<body>



<header>

</header>
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
			사원등록
		</div>
		<div id=employee_import>
			사원 정보 입력
			<!-- 입사일자 <<이런거 변경 예정 -->
			<div>
				<input type="file" id="imageInput" onchange="changeButtonText(this)">
				<div id="imageContainer">
			</div>
			</div>
			<div><a id=employee_insert>입사일자</a><input type=date id=entering_date></div>
			
			<div><a id=employee_team1>부서</a>
					<input type="text" id="employee_team2" style="width:80px;" value="">
					<select style="width:80px;" id="select_team" name="select_team">
						<option value=1 selected>직접입력</option>
					</select>

			</div>
			<!-- db 연동하면 안적어도됨 -->
			<div><a id=employee_position1>직급</a>
					<input type="text" id="employee_position2" style="width:80px;"value="">
					<select style="width:80px;"id="select_position" name="select_position">
						<option value="1">직접입력</option>
					</select>
			</div>
			
			<div><a id=employee_form>고용형태</a>
					<input type="text" id="employee_form2" style="width:80px;" value="">
					<select style="width:80px;" id="select_form" name="select_form">
						<option value="1">직접입력</option>
					</select>
						
					</div><br>
			<div><a id=employee_insert>사원명</a><input type=text id="employee_kname" style="width:100px;" oninput="employee_kor(this)" /></div><br>
			<div><a id=employee_insert>생년월일</a><input type=date readonly></div><br>
			<div><a id=employee_insert>핸드폰</a><input type=text id="employee_phone" style="width:100px;"></div><br>			
			<div><a id=employee_email1>이메일</a><input type=text style="width:125px;" id=employee_email2>@
					<input type="text"  id="employee_email3" style="width:125px;" disabled value="naver.com">
					<select style="width:125px;margin-right:10px" name="selectEmail" id="selectEmail">
					 	<option value="1">직접입력</option>
					 	<option value="naver.com" selected>naver.com</option>
					 	<option value="hanmail.net">hanmail.net</option>
						<option value="hotmail.com">hotmail.com</option>
						<option value="nate.com">nate.com</option>
						<option value="yahoo.co.kr">yahoo.co.kr</option>
						<option value="empas.com">empas.com</option>
						<option value="dreamwiz.com">dreamwiz.com</option>
						<option value="freechal.com">freechal.com</option>
						<option value="lycos.co.kr">lycos.co.kr</option>
						<option value="korea.com">korea.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="hanmir.com">hanmir.com</option>
						<option value="paran.com">paran.com</option>
					</select>
			</div>
            <div>주소
            <input type="text" id="postcode" name=postcode class="address" style="width:150px;" placeholder="우편번호" readonly>
			<input type="button" onclick="execDaumPostcode()" class=btnadd value="우편번호 찾기"><br>
			<input type="text" id="roadAddress" name=roadAddress style="width:300px;" class="address" readonly placeholder="도로명주소" readonly><br>
			<span id="guide" style="color:#999;display:none"></span>
			<input type="text" id="detailAddress" name=detailAddress style="width:300px;" class="address" placeholder="상세주소">
			</div>
		</div>
		<button id=employee_insert name=employee_insert>등록</button>
	</div>

</div>

<footer>

</footer>

</body>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/js/addressapi.js"></script>


<script>
$(document).ready(function(){
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
					 $("#employee_position2").attr("disabled",false); 
				}else{ 
					 $("#employee_position2").val($(this).text());
					 $("#employee_position2").attr("disabled",true);
				}});
	});
	// 고용형태
	$('#select_form').change(function(){
		   $("#select_form option:selected").each(function () {
				if($(this).val()== '1'){
					 $("#employee_form2").val('');
					 $("#employee_form2").attr("disabled",false); 
				}else{ 
					 $("#employee_form2").val($(this).text());
					 $("#employee_form2").attr("disabled",true);
				}});
	});
	// 부서
	$('#select_team').change(function(){
		   $("#select_team option:selected").each(function () {
				if($(this).val()== '1'){
					 $("#employee_team2").val('');
					 $("#employee_team2").attr("disabled",false); 
				}else{ 
					 $("#employee_team2").val($(this).text());
					 $("#employee_team2").attr("disabled",true);
				}});
	});

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
</script>
</html>