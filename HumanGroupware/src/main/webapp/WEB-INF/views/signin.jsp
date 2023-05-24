<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<div>회원가입!</div>
<div><input type=hidden id=emp_no></div>
<div>NAME : <input type=text id=name></div>
<div>ID : <input type=text id=emp_id></div>
<div id=hiddenID></div>
<div>PW : <input type=password id=passcode1></div>
<div>RE-PW : <input type=password id=passcode2></div>
<div>Mobile : <input type=text id=mobile></div>
<div>Email : <input type=text id=email></div>
<div>
Gender : <input type=radio value=men name=gender>남성
<input type=radio value=woman name=gender>여성
</div>
<div>Birth Date : <input type=date id=date></div>
<button id=ok>완료</button>
<button id=x>취소</button>
</body>
<script src='https://code.jquery.com/jquery-latest.js'></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
$(document)
.on('click','#x',function(){
	alert("회원가입이 취소되었습니다");
	window.location.href = '/main';
})
/*회원가입 ajax를 이용해 insert 하는 부분*/
.on('click', '#ok', function () {
	gender = $("input[type=radio]:checked").val();
	console.log(gender);
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
                alert("Insert 실패");
            }
        }
    });
});
/*ajax를 이용하여 아이디 중복 검사하는 부분*/
$('#emp_id').keyup(function(){
	let idc = RegExp(/^[a-zA-Z0-9]{4,12}$/);
	let id=$('#emp_id').val();
	
	$.ajax({
		url:'Emp_idc',
		data:{idc :$('#emp_id').val()},
		dataType:"text",
		type:'post',
		beforeSend:function(){
			if($('#emp_id').val()==""){
				$('#hiddenID').val("fail")
				$('#hiddenID').html('<a style="color:red";>아이디를 입력해주세요</a>');
				return false;
			}
			if(idc.test(id)){
				console.log("ok");
			} else{
				$('#hiddenID').val("fail")
				$('#hiddenID').html('<a style="color:red";>영문 대소문자, 숫자를 혼합하여 4자리 이상입력헤주세요</a>');
				return false;
			}
		},
		success:function(data){
			console.log(data);
			if(data =="ok"){
				$('#hiddenID').val("ok")
				$('#hiddenID').html('<a style="color:blue";>사용가능한 아이디입니다!</a>')
			} else{
				$('#hiddenID').val("fail")
				$('#hiddenID').html('<a style="color:red";>사용 불가한 아이디입니다!</a>')
			}
		}
	})
})
</script>
</html>