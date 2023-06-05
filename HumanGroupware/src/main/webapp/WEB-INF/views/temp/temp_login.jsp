<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/bootstrap-css/bootstrap.min.css">
    <title>임시 로그인</title>
</head>
<style>
    #form-div{
        margin: 0 auto;
        width: 400px;
        position: relative;
        top: 250px;
    }
    #form-div button{
        margin-left: 5px;
    }

</style>
<body>
    <form method="post" action="/testlogin">
    <div class="container justify-content-center" id="form-div">
        <div class="form-floating mb-3">
        <input type="text" class="form-control" 
               name="loginId" id="loginId" required autocomplete="off">
        <label for="loginId">Id를 입력하세요</label>
        </div>
        <div class="form-floating mb-3">
        <input type="password" class="form-control" 
               name="loginPw" id="loginPw" required autocomplete="off">
        <label for="loginPw" class="form-label">Password를 입력하세요</label>
        </div>
        <div class="d-flex align-items-end flex-row-reverse mb-3">
            <button type="submit" class="btn btn-primary" id="btnSubmit">로그인</button>
            <button type="reset" class="btn btn-primary" id="btnReset">취소</button>
        </div>
    </div>
    </form>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="/js/bootstrap-js/bootstrap.bundle.min.js"></script>
<script>
$(document)
.on("click", "#btnReset", ()=>{
    document.location="/temp/home";
})
</script>
</html>