<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HWLogin</title>
</head>
<body>
<div>
	<div class="title">Welcome! <br> HumanGroupware!</div>
	<div> ID <input type=text id=id placeholder="User ID..." size=20></div>
	<div> PW <input type=password id=PW placeholder="비밀번호를 입력해주세요..." size=20></div>
	<div>ID 찾기</div><div>PW 찾기</div>
	<div>
		<button id="ok">완료</button>
	</div>
	<div>
		<button id="x">취소</button>
	</div>
</div>
</body>
<script src='https://code.jquery.com/jquery-latest.js'></script>
<script>
$(document)
.on('click','#x',function(){
	alert("로그인이 취소되었습니다");
	window.location.href = '/main';
})
</script>
</html>