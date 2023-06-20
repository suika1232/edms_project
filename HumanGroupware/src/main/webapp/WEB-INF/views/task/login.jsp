<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
ID: <input type="text" id="loginID">
PW: <input type="password" id="loginPW">
<button id="btnLogin">로그인</button>
<script src ="http://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.on("click","#btnLogin",function(){
	$.ajax({url:"/login",
			type:"post",
			dataType:"text",
			data:{userID:$("#loginID").val(),
				  userPW:$("#loginPW").val()},
			beforeSend:function(){
				console.log("아이디 : "+$("#loginID").val()+"비밀번호 : "+$("#loginPW").val())
			},
			success:function(){
				document.location="/WorkLog"	
			}
	})
})
</script>
</body>
</html>