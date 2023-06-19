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

<div class="Mysession_container">
		<div id="Show-img_box"></div>
		<div id="MY_box">
			<% if(session.getAttribute("emp_name") != null && session.getAttribute("emp_id")!="") {%>
				이름: ${ emp_name}
				<div id=emp_depart></div>
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
			<td class="td_5px">추가근무</td>
			<td class="td_5px">조퇴</td>
			<td class="td_5px">휴가</td>
		</tr>
	</thead>
	<tbody id="employee_tbody">
	</tbody>
</table>
<input type=hidden id="id_value">
<input type=text id="start_leave">
<input type=text id="end_leave">
</div>

</body>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document).ready(function(){
	loadDep_name();
	loadatt_id();
	var now = new Date();
	var year = now.getFullYear();
	var month = ('0'+(now.getMonth()+1)).slice(-2);
	var date = ('0'+(now.getDate())).slice(-2);
	var fulldate = (year+'-'+month+'-'+date);
	var hr = ('0'+now.getHours()).slice(-2);
	var min = ('0'+now.getMinutes()).slice(-2);
	var sec = ('0'+now.getSeconds()).slice(-2);
	var time1 = (hr+min+sec);
	var time = parseInt(time1);
	// 현재날짜
	$('#name_input').val(fulldate);
	// param 값 ( 퇴근 )
	var param = 0;
	// 야근시간
	var timeEnd = 0;
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

// 날짜, 부서 선택 후 결과 출력
	$('#select_btn').on('click',function(){
		$('#employee_tbody').empty();
		loadLeave_list();
		console.log('asdf');
		$.ajax({url:'/attendance_list',
				 type:'post',
				 dataType:'json',
				 data:{dep_name:$('#select_team').val(),
					 	attend_date:$('#name_input').val()},
		success:function(data){
			for(let i = 0; i<data.length; i++){
				list = data[i];
				let attendance = '<tr>'
									+ '<td class = td_3spx>'+list['emp_name']+'</td>'
									+ '<td class = td_3spx>'+list['dep_name']+'</td>'
									+ '<td class = td_3spx>'+list['position_name']+'</td>'
									+ '<td class = td_5spx>'+list['start_time']+'</td>'
									+ '<td class = td_5spx>'+list['end_time']+'</td>'
									+ '<td class = td_5spx>'+list['night_time']+'</td>'
									+ '<td class = td_5spx>'+list['tardy_time']+'</td>'
									+ '<td class = td_5spx>'+'-'+'</td>'
									+ '</tr>';
				$('#employee_tbody').append(attendance);
			}
		}			 	
		})
		})
		
	// 휴가 체크
	function loadLeave_list(){
	$.ajax({url:'/leave_select_list',
			 dataType:'json',
			 type:'post',
			 data:{dep_name:$('#select_team').val(),
				 	attend_date:$('#name_input').val()},
			 success:function(data){
				 for(let i = 0; i<data.length; i++){
						list = data[i];
						let attendance = '<tr>'
											+ '<td class = td_3spx>'+list['emp_name']+'</td>'
											+ '<td class = td_3spx>'+list['dep_name']+'</td>'
											+ '<td class = td_3spx>'+list['position_name']+'</td>'
											+ '<td class = td_5spx>-</td>'
											+ '<td class = td_5spx>-</td>'
											+ '<td class = td_5spx>-</td>'
											+ '<td class = td_5spx>-</td>'
											+ '<td class = td_5spx>~ '+list['leave_end']+'</td>'
											+ '</tr>';
						$('#employee_tbody').append(attendance);
					}
			 }})
}
		
		
		
		
	/* 출근 */
	$('#start_id').on('click',function(){
		loadattdance_chack();
	})
	
	/* 퇴근 */
	$('#end_id').on('click', function(){
		// 현재 시간 ( 퇴근 )
		let now = new Date();
		let year = now.getFullYear();
		let month = ('0'+(now.getMonth()+1)).slice(-2);
		let date = ('0'+(now.getDate())).slice(-2);
		let fulldate = (year+'-'+month+'-'+date);
		let hr = ('0'+now.getHours()).slice(-2);
		let min = ('0'+now.getMinutes()).slice(-2);
		let sec = ('0'+now.getSeconds()).slice(-2);
		let time1 = (hr+min+sec);
		time = parseInt(time1);
		if(time < 175000){
			// 조퇴
			param = 2;
			timeEnd = 0;
			loadEnd_time();
		}else if( time > 182000){
			// 야근
			param = 3;
			timeEnd = time-110000;
			timeEnd = '0'+timeEnd;
			loadEnd_time();
		}else {
			// 정상 퇴근
			param = 1;
			timeEnd = 0;
			loadEnd_time();
		}
	})	
	
	
	// 정상 퇴근
	function loadEnd_time(){
		$.ajax({url:'/attendance_end_id',
			 type:'post',
			 dataType:'text',
			 data:{emp_no:$('#id_value').val(),
				 	param: param,
				 	night_time: timeEnd
			 },
			 success:function(data){
				 if(data=='ok'){
					 var result = confirm("퇴근하시겠습니까?")
					 if(!result){
						 alert('취소되었습니다.');
						 return false;
					 } else{
						 alert('퇴근등록 되었습니다.');
					 }
				 } else{
					 alert("오류");
				 }}
})
}

	//출근 1회 제한
	function loadattdance_chack(){
	$.ajax({url:'/attendance_chack',
			 type:'post',
			 dataType:'json',
			 data:{emp_no: $('#id_value').val(),
				 	attend_date:$('#name_input').val(),
				 	emp_id:'${emp_id}'},
	success:function(data){
		if(data == 1){
			alert("현재 출근 상태입니다.");	
		} else if (data == 0){
			alert("출근 등록 처리중입니다.");
			loadChack();
		}
	}
	})
	}
	//출근 등록
	function loadChack(){
		$.ajax({url:'/attendance_start_id',  
			type:'post', 
			dataType:'text',
			data:{emp_no:$('#id_value').val()
					},
			success:function(data){
				if(data=='ok'){
					alert(' 정상 출근 등록되었습니다.');
				} else{
					alert("오류");
				}
			}
	})
	}


</script>
</html>