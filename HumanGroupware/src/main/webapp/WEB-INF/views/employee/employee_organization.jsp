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
	</div>
	</div>
<!-- 임시 링크용 -->
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
			<input type=text class="dep_name" value="부 서 명"  id="dep_name" disabled><br>
			
			<input type=text class="dep_parent" value="상위 부 서 명" disabled><br>
			<input type=text class="dep_manager" value="담당 부 서 명" disabled><br>
		</div>
		<div class="add_department">
			<input type= text class="depart_name" id="depart_name" placeholder="[2~20자 이내]" ><br>
			<select class="depart_parent" id=depart_parent>
				<option value="">없음</option>
			</select>
			<select class="depart_manager" id=depart_manager>
				<option value="">없음</option>
			</select>
		</div>
	</div>
	<input type=button value="추가" id=update_btn><br>
	임시 parent<input type=text id="parent_number" value=""><br>
	임시 manager<input type=text id="manager_number" value="">
	임시 id<input type=text id="id_number" value="">
	
	임시 삭제 select
	<select class="depart_parent" id=depart_parent>
				<option value="">없음</option>
	</select>
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


// select option (부서, 직급, 고용형태) 불러오기
	// 부서명 불러오기 ( select )
	function loadDep_name(){
		$.ajax({url:'/department_select0',
				 type:'post',
				 dataType:'json',
				 success:function(data){
					 for(let i=0; i<data.length; i++){
						 option = data[i];
						 let parent = '<option value='+option['dep_parent']+'>'+option['dep_name']+'</option>';
						 let manager = '<option value='+option['dep_manager']+'>'+option['dep_name']+'</option>';
						 $('#depart_parent').append(parent);
						 $('#depart_manager').append(manager);
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
	
//삭제구현  

/* $("#payorder_delete").on("click", function(){
	let chk = "";
	$.ajax({url:'/order_delete', type:'post', data:{cart_id: chk}, dataType:'text',
			beforeSend:function(){
				if($('input:checkbox[name=check]').is(":checked")==0){
					alert('선택하십시오');
					return false;
			}},
			success:function(data){
				if(data=='ok'){
					if(!confirm('선택한 부서를 삭제하시겠습니까?')) 
						return false;
			    } else {
					alert("삭제 불가능.");
				}
	}})
}); */
</script>
</html>