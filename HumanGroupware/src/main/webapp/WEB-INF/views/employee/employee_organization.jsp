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

<div class="inquiry_main">
	<a>부서/직급 등록</a>
</div>

	<!-- 직급 추가 -->
	<div class="add_position">
		<div class="add_department_a">
			<input type=text class="dep_parent" value="직 급 명"  id="position_input" disabled><br>
			
			<input type=text class="dep_parent" value="고 용 형 태" disabled><br>
			<input type=text class="dep_manager" id="dep_manager" value="" disabled><br>
			<input type=text class="dep_name"value="삭 제 직 급 명"  id="dep_name" disabled>
			<input type=button value="삭제" id="P_delete_btn" class="delete_btn"><br>
		</div>
		<div class="add_department">
			<input type= text class="depart_name" id="position_name" placeholder="[2~10자 이내]" ><br>
			<select class="depart_parent" id=job_type>
				<option value="계약직">계약직</option>
				<option value="정규직">정규직</option>
			</select>
			<input type=text class="dep_manager" id="dep_manager" value="" disabled><br>
			<select class="depart_parent" id=position_select>
				<option value="없음">없음</option><br>
			</select>
			<input type=button value="추가" id=P_update_btn class="update_btn"><br>
		</div>
		
	<input type=hidden id="position_id_num" value="없음">
	</div>
	
	<!-- 부서 추가 -->
	<div class="add">
		<div class="add_department_a">
			<input type=text class="dep_parent" id="dep_name" value="부 서 명"  id="dep_name" disabled><br>
			
			<input type=text class="dep_parent"  id="dep_parent" value="상위 부 서 명" disabled><br>
			<input type=text class="dep_manager" id="dep_manager" value="담당 부 서 장" disabled><br>
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
	loadDep_boss_name();
	loadpositon_select();
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
$('#position_select').on('click',function(){
	$('#position_id_num').val($('#position_select').val());
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
						 let id ='<option value='+option['dep_id']+'>'+option['dep_name']+'</option>';
						 $('#depart_parent').append(parent);
						 $('#depart_id').append(id);
					 }},
	})}
	// 삭제 직급 아이디 불러오기 ( select )
	function loadpositon_select(){
		$.ajax({url:'/position_name_select',
				type:'post',
				dataType:'json',
				success:function(data){
					for(let i=0; i<data.length; i++){
						option = data[i];
						let id = '<option value='+option['position_id']+'>'+option['position_name']+'['+option['job_type']+']</option>';
						$('#position_select').append(id);
					}
				}})
	}
// 담당 부서장 명 불러오기 ( select )
	function loadDep_boss_name(){
		$.ajax({url:'/dep_boss_name_select',
			type:'post',
			 dataType:'json',
			 success:function(data){
					for(let i=0; i<data.length; i++){
						option = data[i];
						let manager = '<option value = '+option['emp_no']+'>'+option['emp_name']+' '+option['position_name']+'</option>';
						$('#depart_manager').append(manager);
					}
				}})
}
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
// 새 직급명 ( insert )
$('#P_update_btn').on('click',function(){
	console.log('dk');
	let positionName = $('#position_name').val();
	let jobType = $('#job_type').val();
	$.ajax({url:'/position_insert',  
			 type:'post', 
			 dataType:'text',
			 data:{position_name:$('#position_name').val(),
					job_type:$('#job_type').val(),
			},
			beforeSend:function(){
				if(positionName==''||positionName==null){
					alert('직급명을 입력해주십시오.');
					return false;
				}
			},
			success:function(data){
				if(data=='ok'){
					alert(positionName+' 가(이) 추가 되었습니다.');
					location.reload();
				} else{
					alert("직급등록에 실패하였습니다.");
				}
			}
	})
})
	
// 부서 삭제
$("#P_delete_btn").on("click", function(){
	$.ajax({url:'/position_delete', 
			 type:'post', 
			 data:{position_id:$('#position_id_num').val()}, 
			 dataType:'text',
	beforeSend:function(){
		if($('#position_select').val()=='없음'){
			alert('삭제할 직급을 선택해 주십시오.');
			return false;
	}},
			success:function(data){
				if(data=='ok'){
					if(!confirm('선택한 직급을 삭제하시겠습니까?'));
					alert('선택 직급이 영구제거되었습니다.');
					location.reload();					
						return false;
			    } else {
					alert("삭제 불가능.");
				}
	}})
});

//부서 삭제
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