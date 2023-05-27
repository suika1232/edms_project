<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link type="text/css" rel="stylesheet" href="/resources/css/hwSignin.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<title>HWSignin</title>
</head>
<body>
<div class="body">
	<div class="title">Welcome! <br> HumanGroupware!</div>
	<div class="Name">
		UserNAME
		<input type=text id=name placeholder="UserName..." size=20>
	</div>
	<div class="ID">
		ID
		<input type=text id=emp_id  placeholder="User ID..." size=20>
		<div id=hiddenID></div>
	</div>
	<div class="PW">
		PW
		<input type=password id=passcode1 placeholder="비밀번호 입력" size=20>
		<div id=hiddenPW></div>
	</div>
	<div class="RE-PW">
		RE-PW 
		<input type=password id=passcode2 placeholder="비밀번호 재입력" size=20>
		<div id=hiddenRE-PW></div> 
	</div>
	<div class="Mobile">
		Mobile 
		<input type=text id=mobile placeholder="ex) 010xxxxxxxx" size=25>
		<div id=hiddenMobile></div>
	</div>
	<div class="Email">
		Email <input type=text id=email placeholder="ex) admin@a.com" size=30>
				<div id=hiddenEmail></div>
	</div>
	<div class="Gender">
		Gender <br>
		<input type=radio value=men name=gender>남성
		<input type=radio value=woman name=gender>여성
	</div>
	<br>
	<div class="Date">
		Birth Date <br><br> 
		<input type=date id=date>
	</div>
	<div class="btn">
		<button id=ok>완료</button>
		<button id=x>취소</button>
	</div>
</div>
</body>
<script src='https://code.jquery.com/jquery-latest.js'></script>
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
/*취소버튼을 누르면 메인으로 돌아가는 코드입니다.*/
.on('click','#x',function(){
	alert("회원가입이 취소되었습니다");
	window.location.href = '/main';
})
/*회원가입 ajax를 이용해 insert 하는 부분*/
.on('click', '#ok', function () {
	gender = $("input[type=radio]:checked").val();
	console.log(gender);
	if ($('#name').val() == '' || $('#emp_id').val() == '' || $('#passcode1').val() == '' ||
	        $('#email').val() == '' || $('#mobile').val() == '' || $('#date').val() == '') {
	        alert("빈 공간 없이 입력해주세요!");
	        return false;
	}
	
    $.ajax({
        url: 'InsertEmp',
        type: 'post',
        data: {
            name: $('#name').val(),
            emp_id: $('#emp_id').val(),
            passcode1: $('#passcode1').val(),
            email: $('#email').val(),
            mobile: $('#mobile').val(),
            date: $('#date').val().replace(/-/g, ''),
            gender: gender
        },
        dataType: 'text',
        success: function (data) {
            if (data == "ok") {
                alert("회원가입 성공하셨습니다! 로그인 후 이용해주세요");
                window.location.href = '/login';
            } else {
                alert("회원가입을 실패했습니다...");
                return false;
            }
        }
    });
});
/*ajax를 이용하여 아이디 중복 검사하는 부분
 * idc == ID duplicate check
 */
$("#emp_id").keyup(function(){
	let idc = /^[a-zA-Z0-9]{4,12}$/;
	let id = $('#emp_id').val();
	
	$.ajax({
		url:'Emp_idc',
		data: { emp_id : $('#emp_id').val()},
		type: 'post',
		dataType: 'text',
		beforeSend: function(){
			if($('#emp_id').val()==""){
				$('#hiddenID').val('fail');
				$('#hiddenID').html('<a style="color: red;">아이디를 입력해주세요!</a>');
				return false;
			}
			if(idc.test(id)){
				console.log("ok",id);
			} else {
				$('#hiddenID').val('fail');
				$('#hiddenID').html('<a style="color:red;">영문 대소문자, 숫자를 혼합하여 4자리 이상 입력해주세요</a>');
				return false;
			}
		},
		success: function(data) {
			console.log('data:' + data);
			if(data == "ok"){
				$('#hiddenID').val('ok');
				$('#hiddenID').html('<a style="color:blue;">사용 가능한 아이디입니다!</a>');
			} else {
				$('#hiddenID').val("fail");
				$('#hiddenID').html('<a style="color:red;">사용 불가한 아이디입니다!</a>');
			}
		}
	})
})
/* 비밀번호가 8~14 글자가 있는지 확인하고 영문 숫자 섞어 사용하는 코드이다. 
 * pdc == passcode duplicate check
 */
$('#passcode1').keyup(function(){
	let pdc = /^[a-zA-Z0-9]{8,14}$/;
	let passcode = $('#passcode1').val();
	
	if(pdc.test(passcode) && !/\s/.test(passcode)){
		$('#hiddenPW').val('ok');
		$('#hiddenPW').html('<a style="color:blue;">사용가능한 비밀번호 입니다!</a>');
	} else if(passcode.length < 8){
		$('#hiddenPW').val('fail');
		$('#hiddenPW').html('<a style="color:red;">영문과 숫자를 혼합하여 8~14자리 이하의 비밀번호를 입력해주세요</a>');
	} else if(/\s/.test(passcode)){
		$('#hiddenPW').val('fail');
		$('#hiddenPW').html('<a style="color:red;">공백을 넣을 수 없습니다!</a>');
	} else {
		$('#hiddenPW').val('fail');
		$('#hiddenPW').html('<a style="color:blue;">사용불가한 비밀번호입니다!</a>');
	}	
})
/* 비밀번호가 같은지 확인하는 코드입니다.
 * passcode1 == passcode2
 */
$('#passcode2').keyup(function(){
	if($('#passcode2').val() == $('#passcode1').val()){
		$('#hiddenRE-PW').val('ok');
		$('#hiddenRE-PW').html('<a style="color:blue;">비밀번호가 일치합니다!</a>');
	}else{
		$('#hiddenRE-PW').val('fail');
		$('#hiddenRE-PW').html('<a style="color:red;">비밀번호가 일치하지 않습니다!</a>');
	}
})
/* Mobile 번호가 11개만 들어가고 -없이 전화번호만 입력하게 하는 코드입니다.
 * mdc == Mobile duplicate check
 */
$('#mobile').keyup(function(){
	let mdc = /^[0-9]{11}$/;
	let mobile = $('#mobile').val();
	
	if(mdc.test(mobile) && !/\s/.test(mobile)){
		$('#hiddenMobile').val('ok');
		$('#hiddenMobile').html('<a style="color:blue;">유효한 번호입니다!</a>');
	} else if(mobile.length <11){
		$('#hiddenMobile').val('fail');
		$('#hiddenMobile').html('<a style="color:red;">번호는 - 없이 12글자 이내로 입력하세요!</a>');
	} else if(/\s/.test(mobile)){
		$('#hiddenMobile').val('fail');
		$('#hiddenMobile').html('<a style="color:red;">공백 없이 입력해주세요!</a>');
	} else {
		$('#hiddenMobile').val('fail');
		$('#hiddenMobile').html('<a style="color:red;">유효하지 않은 번호입니다 ㅜㅜ</a>');
	}
})
/* Email 양식에 맞는지 확인하는 코드입니다.
 * edc == Email duplicate check
 */
 $('#email').keyup(function(){
	 let email = $('#email').val();
	 let edc = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	 
	 if(edc.test(email)){
		 $('#hiddenEmail').val('ok');
		 $('#hiddenEmail').html('<a style="color:blue;">올바른 이메일입니다!</a>');
	 } else if(/\s/.test(mobile)){
		 $('#hiddenEmail').val('fail');
		 $('#hiddenEmail').html('<a style="color:red;">공백 없이 입력하고 양식에 맞게 입력하세요!</a>');
	 } else {
		 $('#hiddenEmail').val('fail');
		 $('#hiddenEmail').html('<a style="color:red;">잘못된 이메일입니다!</a>');
	 }
 })
/*Date에서 오늘 날짜 이후로 선택 못하게 하는 코드입니다*/
let today = new Date().toISOString().split('T')[0];
document.getElementById('date').setAttribute('max', today);

</script>
</html>