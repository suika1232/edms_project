<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link type="text/css" rel="stylesheet" href="/resources/css/hwLogin.css">
<title>HWLogin</title>
</head>
<body>
<div class="body">
	<div class="title">Welcome! <br> HumanGroupware!</div>
	<div class="ID"> ID <input type=text id=emp_id value="${login }" placeholder="User ID..." size=20></div>
	<div class="PW"> PW <input type=password id=emp_password placeholder="비밀번호를 입력해주세요..." size=20></div>
	<div class="Signin"><a href="signin">회원가입</a></div>
	<div class="find"><span id=findId>ID 찾기</span>&nbsp;&nbsp;&nbsp;
	<span id=findPW>PW 찾기</span></div>
	<div class=btn>
		<button id="ok">완료</button>
		<button id="x">취소</button>
	</div>
</div>

<!-- 아이디 찾기 dialog -->
<div class="IDdialog" id="IDdialog" style="display:none">
	<div class="n_idia">이름을 입력해주세요! <input type=text id=FIN placeholder="UserName..." size=20></div>
	<div class="m_idia">전화번호를 입력해주세요! <input type=text id=FIM placeholder="ex)010xxxxxxxx" size=20></div>
	<div class="e_idia">이메일을 입력해주세요! <input type=text id=FIE placeholder="ex) admin@a.com" size=20></div>
	<div class="btn_idia">
		<button id=FII value="아이디 찾기">확인</button>
		<button id=FIP value="비밀번호 찾기">비밀번호 찾기</button>
	</div>
	<div id="FIC"></div>
</div>
<!-- 비밀번호 찾기 dialog -->
<div class="PWdialog" id="PWdialog" style="display:none">
	<div class="n_pdia">
		이름을 입력해주세요! 
		<input type=text id=FPN placeholder="UserName..." size=20></div>
	<div class="i_pdia">
		아이디를 입력해주세요! 
		<input type=text id=FPI placeholder="User ID..." size=20></div>
	<div class="n_pdai">
		전화번호를 입력해주세요! 
		<input type=text id=FPM placeholder="ex)010xxxxxxxx" size=20>
	</div>
	<div class="btn_pdia">
		<button id=FPP>확인</button>
		<button id=FPID>아이디 찾기</button>
	</div>
	<div id="FPC"></div>
</div>
</body>
<script src='https://code.jquery.com/jquery-latest.js'></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
$(document)
/*별똥별 내려가게 하는 코드입니다*/
.ready(function() {
	function createStar() {
		var star = $('<div class="star"></div>');
		star.css({
			left: Math.random() * 100 + '%',
			top: Math.random() * 100 + '%',
			animationDelay: Math.random() * 5 + 's'
		});
		$('body').append(star);
		setTimeout(function() {
			star.remove();
		}, 5000);
	}
	setInterval(createStar, 500);
})
// 취소 버튼을 누르면 메인으로 돌아갑니다.
.on('click','#x',function(){
	alert("로그인이 취소되었습니다");
	window.location.href = '/employee/main';
})
// 로그인 정보를 입력하고 확인을 누르면 맞으면 main 틀리면 다시 입력하게 합니다.
.on('click','#ok',function(){
	if($('#emp_id').val() =="" || $('#emp_password').val()==""){
		alert("아이디와 비밀번호를 입력해주세요!");
		return false;
	}
	$.ajax({
		url: '/employee/login_session',
		data: {emp_id:$('#emp_id').val(),emp_password:$('#emp_password').val()},
		type:'post',
		dataType: 'text',
		success : function(data){
			if(data == "ok"){
				alert("로그인 되셨습니다!");
				document.location = '/employee/main';
			}else{
				alert("로그인 정보가 일치하지 않습니다")
			}
		}
	})
})
// 아이디 찾기 dialog창 입니다.
.on('click','#findId',function(){
	$('#IDdialog').dialog({
		title: '아이디 찾기',
		modal: true,
		width: 500
	})
})
// 아이디 찾기 코드입니다.
.on('click','#FII', function(){
	if($('#FIN').val() =="" || $('#FIM').val()=="" || $('#FIE').val()==""){
		alert("정보를 찾기 위해서 빈공간 없이 입력해주세요!");
		return false;
	}
	$.ajax({
		url:'/emp_findID',
		data: {FIN: $('#FIN').val(),
			   FIM: $('#FIM').val(),
			   FIE: $('#FIE').val()},
		dataType: 'json',
		type: 'post',
		beforeSend: function(){
			$('#FIC').empty();
		},
		success:function(data){
			if(data != ""){
				$('#FIC').append('<div>검색하신 아이디는'+data.length+'개 입니다</div>');
				for(let i=0; i<data.length; i++){
					$('#FIC').append("<input type=text readonly value="+data[i]['IDdialog']+'><br>');
				}
				$('#FIC').append("<div id=FIP>비밀번호 찾기</div>");
			} else if(data==""){
				alert("해당하는 아이디가 없습니다");
			} 
		}
	})
})
//아이디 찾기 기능에서 모바일 번호를 숫자만 입력 받을 수 있게 만든 코드입니다.
.on('input','#FIM',function(){
	this.value = this.value.replace(/[^0-9]/g, '');
})
// 아이디 찾기 기능에서 비밀번호 찾기로 이동하는 코드입니다.
.on('click','#FIP',function(){
	$('#IDdialog').dialog('close');
	$('#findPW').trigger('click');
	
	$('#FIN').val('');
	$('#FIM').val('');
	$('#FIE').val('');
	
	$('#FIC').empty();
})
// 비밀번호 찾기 dialog창 입니다.
.on('click','#findPW',function(){
	$('#PWdialog').dialog({
		title: '비밀번호 찾기',
		modal : true,
		width: 500
	})
})
//비밀번호 찾기 dialog창에서 비밀번호 찾기 코드입니다.
.on('click','#FPP',function(){
	$('#FPC').empty();
	if($('#FPN').val() == "" || $('#FPI').val()== "" || $('#FPM').val()== ""){
		alert("정보를 찾기 위해서 빈공간 없이 입력해주세요!");
		return false;
	}
	$.ajax({
		url:'/emp_findPW',
		data: {FPN : $('#FPN').val(),
			   FPI : $('#FPI').val(),
			   FPM : $('#FPM').val()},
		dataType: 'text',
		type: 'post',
		success:function(data){
			if(data == "ok"){
				$('#FPC').append("PW ");
				$('#FPC').append("<input type=password id='PWC' placeholder='비밀번호 입력' size=20>");
				$('#FPC').append("<div id=pwhidden></div>");
				$('#FPC').append("RE-PW ");
				$('#FPC').append("<input type=password id='REPWC' placeholder='비밀번호 재입력' size=20>");
				$('#FPC').append("<div id=REPWhidden></div>");
				$('#FPC').append("<div><button id=change>변경</button></div>");
			} else{
				alert('해당하는 정보가 없습니다.');
			}
		}
	})
})
//비밀번호 찾기 dialog 창에서 FPM을 숫자만 넣을 수 있게 만든 코드입니다.
.on('input','#FPM',function(){
	this.value = this.value.replace(/[^0-9]/g, '');
})
// 비밀번호 찾기 dialog  창에서 비밀번호를 변경하는 버튼 코드입니다.
.on('click','#change',function(){
	if($('#PWC').val()=="" || $('#REPWC').val() ==""){
		alert('비밀번호를 입력해주세요!')
		return false;
	}
	$.ajax({
		url:'/Emp_PwChange',
		data:{ PWC: $('#PWC').val(),
			   REPWC: $('#REPWC').val(),
			   FPI : $('#FPI').val()},
		type:'post',
		dataType:'text',
		success:function(data){
			if(data=="ok"){
				alert("비밀번호가 변경되었습니다");
				document.location.href = "login";
			} else if(data=="checkfalse"){
				alert("비밀번호가 서로 다릅니다");
			}else{
				alert("실패하였습니다");
			}
		}
	})
})
// 비밀번호 찾기 dialog 창에서 비밀번호가 서로 일치하는지 확인하는 코드입니다.
.on('keyup','#REPWC',function(){
	if($('#REPWC').val() == $('#PWC').val()){
		$('#REPWhidden').val('ok');
		$('#REPWhidden').html('<a style="color:blue;">비밀번호가 일치합니다!</a>');
	} else{
		$('#REPWhidden').val('ok');
		$('#REPWhidden').html('<a style="color:red;">비밀번호가 일치하지않습니다!</a>');
	}
})
// 비밀번호 찾기 dialog 창에서 비밀번호가 8~14 글자가 있는지 확인하고 영문 숫자 섞어 사용하는 코드입니다.
.on('keyup','#PWC',function(){
	let pdc = /^[a-zA-Z0-9]{8,14}$/;
	let passcode = $('#PWC').val();
	
	if(pdc.test(passcode) && !/\s/.test(passcode)){
		$('#pwhidden').val('ok');
		$('#pwhidden').html('<a style="color:blue;">사용가능한 비밀번호 입니다!</a>');
	} else if(passcode.length < 8){
		$('#pwhidden').val('fail');
		$('#pwhidden').html('<a style="color:red;">영문과 숫자를 혼합하여 8~14자리 이하의 비밀번호를 입력해주세요</a>');
	} else if(/\s/.test(passcode)){
		$('#pwhidden').val('fail');
		$('#pwhidden').html('<a style="color:red;">공백을 넣을 수 없습니다!</a>');
	} else {
		$('#pwhidden').val('fail');
		$('#pwhidden').html('<a style="color:blue;">사용불가한 비밀번호입니다!</a>');
	}	
})
//비밀번호 찾기 dialog창에서 아이디 찾기 dialog창으로 이동하는 코드입니다.
.on('click','#FPID',function(){
	$('#PWdialog').dialog('close');
	$('#findId').trigger('click');
	
	$('#FPN').val('');
	$('#FPI').val('');
	$('#FPM').val('');
	
	$('#FPC').empty();
})
</script>
</html>