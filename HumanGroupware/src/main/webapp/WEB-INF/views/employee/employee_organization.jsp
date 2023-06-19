<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>조직도</title>
<link type="text/css" rel="stylesheet" href="/resources/css/employee_organization.css">
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
	<a>조직도</a>
</div>

	
	<div class="organization">
		
		<ul class="tree">
			<li>
				<input type="checkbox" id="root">
				<label for="root">그룹웨어</label>
				<ul>
					<li>
						<input type="checkbox" id="node1">
						<label for="node1">부서명</label>
						<ul>
							<li>
								<input type="checkbox" id="node21">
								<label for="node21" class="lastTree">부서명+1</label>
							</li>
						</ul>
					</li>
					<li>
						<input type="checkbox" id="node2">
						<label for="node2">부서명</label>
						<ul>
							<li>
								<input type="checkbox" id="node21">
								<label for="node21" class="lastTree">부서명+1</label>
							</li>
						</ul>
					</li>
				</ul>
			</li>
		</ul>
	</div>
	<!-- 부서 추가 -->
	<div class="add">
		<div class="add_department_a">
			<input type=text class="dep_name" id="dep_name" value="부 서 명"  id="dep_name" disabled><br>
			
			<input type=text class="dep_parent"  id="dep_parent" value="상위 부 서 명" disabled><br>
			<input type=text class="dep_manager" id="dep_manager" value="담당 부 서 명" disabled><br>
			<input type=text class="dep_name" id="del_name" value="삭 제 부 서 명"  id="dep_name" disabled>
			<input type=button value="삭제" id="delete_btn" class="delete_btn"><br>
		</div>
		<div class="add_department">
			<input type= text class="depart_name" id="depart_name" placeholder="[2~20자 이내]" ><br>
			<select class="depart_parent" id=depart_parent>
				<option value="0">없음</option>
			</select>
			<select class="depart_manager" id=depart_manager>
				<option value="0">없음</option>
			</select>
			<select class="depart_parent" id=depart_id>
				<option value="없음">없음</option><br>
			</select>
			<input type=button value="추가" id=update_btn class="update_btn"><br>
		</div>
		
	<input type=hidden id="parent_number" value="0"><br>
	<input type=hidden id="manager_number" value="0">
	<input type=hidden id="id_number" value="없음">
	</div>
	
	
	
</body>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document).ready(function(){
	loadDep_name();
})

// click 상위, 담당부서명 hidden 저장 ( select )
$('#depart_parent').on('click',function(){
	console.log($('#depart_parent').val());
	$('#parent_number').val($('#depart_parent').val());
});
$('#depart_manager').on('click',function(){
	$('#manager_number').val($('#depart_manager').val());
});
$('#depart_id').on('click',function(){
	$('#id_number').val($('#depart_id').val());
})

// click 추가상태


// select option (부서, 직급, 고용형태) 불러오기
	// 부서명 불러오기 ( select )
	function loadDep_name(){
		$.ajax({url:'/department_select0',
				 type:'post',
				 dataType:'json',
				 success:function(data){
					 for(let i=0; i<data.length; i++){
						 option = data[i];
						 let parent = '<option value='+option['dep_id']+'>'+option['dep_name']+'</option>';
						 let manager = '<option value='+option['dep_manager']+'>'+option['dep_name']+'</option>';
						 let id ='<option value='+option['dep_id']+'>'+option['dep_name']+'</option>';
						 $('#depart_parent').append(parent);
						 $('#depart_manager').append(manager);
						 $('#depart_id').append(id);
					 }},
	})}

// 새 부서명 ( insert )
$('#update_btn').on('click',function(){
	console.log('dk');
	let dep_name = $('#depart_name').val();
	let dep_parent = $('#parent_number').val();
	let dep_manager = $('#manager_number').val();
	$.ajax({url:'/department_insert',  
			 type:'post', 
			 dataType:'text',
			 data:{dep_manager:$('#manager_number').val(),
					dep_parent:$('#parent_number').val(),
					dep_name:$('#depart_name').val(),
			},
			beforeSend:function(){
				if(dep_name==''||dep_name==null){
					alert('부서명을 입력해주십시오.');
					return false;
				}
			},
			success:function(data){
				if(data=='ok'){
					alert(dep_name+' 가(이) 추가 되었습니다.');
					location.reload();
				} else{
					alert("부서등록에 실패하였습니다.");
				}
			}
	})
})
	
// 부서 삭제
$("#delete_btn").on("click", function(){
	$.ajax({url:'/department_delete', 
			 type:'post', 
			 data:{dep_id:$('#id_number').val()}, 
			 dataType:'text',
	beforeSend:function(){
		if($('#id_number').val()=='없음'){
			alert('삭제할 부서를 선택해 주십시오.');
			return false;
	}},
			success:function(data){
				if(data=='ok'){
					if(!confirm('선택한 부서를 삭제하시겠습니까?'));
					alert('선택 부서가 영구제거되었습니다.');
					location.reload();					
						return false;
			    } else {
					alert("삭제 불가능.");
				}
	}})
});
</script>
</html>