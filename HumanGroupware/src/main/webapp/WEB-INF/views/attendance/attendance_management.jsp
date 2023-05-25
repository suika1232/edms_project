<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근태 관리</title>
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
			<div>근태 관리</div>
		</div>
		<div>
			서류 양식 다운로드
		</div>
		<div>
			<div>
				<select style="width:80px;" id="select_team" name="select_team">
							<option value="야근" selected>야근</option>
				</select>
			</div>
			<div>
				발신인<input type=text>
			</div>
			<div>
				수신인
				<select style="width:200px;" id="addressee_select" name="addressee_select">
				
				</select>
			</div>
			<div>
				<input type=text style="width:250px; height:250px"placeholder="전달사항">
			</div>
			<div>
				첨부파일<input type=file>
			</div>
		</div>
	</div>
</div>

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