<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/employee_all.css">
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
			</div><button>삭제</button>
			<div><a id=employee_insert>입사일자</a><input type=date id=entering_date></div>
			
			<div><a id=employee_team1>부서</a>
					<input type="text" id="employee_team2" style="width:80px;" disabled value="총괄부">
					<select style="width:80px"; id="select_team" name="select_team">
						
						<option value="1">직접입력</option>
						<option value="총괄과" selected>총괄부</option>
						<option value="인사과">인사과</option>
						
					</select>

			</div>
			<!-- db 연동하면 안적어도됨 -->
			<div><a id=employee_position1>직책</a>
					<input type="text" id="employee_position2" style="width:80px;" disabled value="신입">
					<select style="width:80px;"id="select_position" name="select_position">
						<option value="1">직접입력</option>
						<option value="신입" selected>신입</option>
						<option value="사원">사원</option>
						<option value="대리">대리</option>
						<option value="과장">과장</option>
						<option value="소장">소장</option>
						<option value="이사">이사</option>
						<option value="사장">사장</option>
					</select>
			</div>
			<div><a id=employee_form>고용형태</a>
					<input type="text" id="employee_form2" style="width:80px;" disabled value="계약직">
					<select style="width:80px;" id="select_form" name="select_form">
						<option value="1">직접입력</option>
						<option value="계약직" selected>계약직</option>
						<option value="정규직">정규직</option>
						<option value="파견직">파견직</option>
					</select>
						
					</div><br>
			<div><a id=employee_insert>사원명</a><input type=text id="employee_kname" style="width:100px;" oninput="employee_kor(this)" /></div><br>
			<div><a id=employee_insert>사원명(영문)</a><input type="text" id="employee_ename" style="width:100px;"oninput="employee_eng(this)" /></div><br>
			<div><a id=employee_insert>생년월일</a><input type=date ></div><br>
			<div><a id=employee_insert>핸드폰</a><input type=text id="employee_phone" style="width:100px;"></div><br>
			<div><a id=employee_insert>부서번호</a><input type=text id="employee_tphone" style="width:100px;"></div><br>
			
			<div><a id=employee_email1>이메일</a><a id=employee_email2><input type=text style="width:125px;"></a>@
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
			
			<div><a id=employee_insert>비상연락망</a><input type=text></div>
			<div><a id=employee_insert>혈액형</a><input type=text></div>
			
<!-- 			우편번호 &nbsp;&nbsp;<input class="underline" type=text size=20px; id="postcode" readonly placeholder="우편번호"><input type="button" onclick="execDaumPostcode()" class=btnadd value="우편번호 찾기"><br>
               	도로명주소<input class="underline"   type=text size=60px; id="roadAddress" readonly placeholder="도로명주소"><br>
                상세주소 &nbsp;&nbsp;<input class="underline" type=text size=60px; id="detailAddress" readonly placeholder="상세주소"><br>
                <input type = hidden id="payorder_id"></div> -->
                
                <input type="text" id="postcode" name=postcode class="address" style="width:150px;" placeholder="우편번호">
			<input type="button" onclick="execDaumPostcode()" class=btnadd value="우편번호 찾기"><br>
			<input type="text" id="roadAddress" name=roadAddress style="width:300px;" class="address" readonly placeholder="도로명주소"><br>
			<span id="guide" style="color:#999;display:none"></span>
			<input type="text" id="detailAddress" name=detailAddress style="width:300px;" class="address" placeholder="상세주소">
			
			</div>
		</div>
		<button id=employee_insert>등록</button>
	</div>

</div>

<footer>

</footer>

</body>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/js/addressapi.js"></script>


<script>
$(document)
.ready(function(){
	handleImageUpload();
})
// select 직접입력 
	// 이메일
	
	
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
	// 근무형태
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
	function employee_eng(e)  {
		e.value = e.value.replace(/[^A-Za-z]/ig, '')
	}

// 사진 등록, 출력
	function handleImageUpload() {
		  var imageInput = document.getElementById('imageInput');
		  var imageContainer = document.getElementById('imageContainer');
		  imageInput.addEventListener('change', function(event) {
			var file = event.target.files[0];
			var reader = new FileReader();
			reader.onload = function(e) {
		    	imageContainer.style.backgroundImage = 'url(' + e.target.result + ')';
			};
		    reader.readAsDataURL(file);
		  });
	}handleImageUpload();
	
// 사원정보 insert (employee_insert)
	$('#employee_insert').on('click',function(){
		$.ajax({url:'/employee_insert',  type:'post', dataType:'text',
			data:{ member_id:$('#employee_team2').val(),
					order_price:$('#employee_position2').val(),
					qty:$('#employee_form2').val(),
					prod_id:$('#employee_kname').val(),
					asdf:asdf,
					},
			beforeSend:function(){
				let team = $.trim($('#employee_team2').val());
				if(team==''||team==null){
				   alert('부서명 미기입하셨습니다');
					return false;
				}
				let position = $.trim($('#employee_position2').val());
				if(position==''||position==null){
					alert('직급명 미기입하셨습니다.');
					return false;
				}
				let form = $.trim($('#employee_form2').val());
				if(form==''||form==null){
					alert('근무형태 미기입하셨습니다.');
					return false;
				}
				let kname = $.trim($('#employee_kname').val());
				if(kname==''||kname==null){
					alert('사원명(한글) 미기입하셨습니다.');
					return false;
				}
			},
			success:function(data){
				if(data=='ok'){
					alert(kname+" "+position+"님의 정보가 정상적으로 등록되었습니다.");
				} else{
					alert("오류");
				}
		}})
	})	

// 부서명 불러오기
	/* function loadData(){
		$.ajax({url:'/employee_team0',
				 type:'post',
				 dataType:'json',
				 data:{},
				 success:function(data){
					 $('#asdf').empty();
					 let option+= '<option value="1">직접입력</option>'; 
					 for(let i=0; i<data.length; i++){
						 let team0 = data[i];
						 let option+= '<option value="'+부서명+'">'+부서명+'</option>'; 
						 $('#select_team option:selected').append(option);
					 }
	}})} */
</script>
</html>