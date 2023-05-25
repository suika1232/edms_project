<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>글쓰기</title>
</head>
<style>
    #boardTitle{
        width: 250px;
        height: 30px;
        margin-bottom: 5px;
    }
    textarea{
        resize: none;
        width: 250px;
        height: 200px;
    }
</style>
<body>
    <%  String userAuth = (String) request.getAttribute("userAuth");
        if(userAuth.equals("admin")){ %>
        <h3>공지작성</h3>
        <input type="hidden" id="userAuth" value="admin">
    <% } else { %>
        <h3>게시물작성</h3>
        <input type="hidden" id="userAuth" value="user">
    <% } %>
    <form method="post" action="/board_insert">
        <input type="hidden" id="boardCategory" name="boardCategory" readonly>
        제목
        <input type="text" id="boardTitle" name="boardTitle" required><br>
        내용
        <textarea name="boardContent" required></textarea><br>
        <button type="reset" id="btnReset">취소</button>
        <button type="submit" id="btnSubmit">저장</button>
    </form>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.ready(()=>{
    console.log("세션정보:"+$("#userAuth").val());
    if($("#userAuth").val() == "admin") $("#boardCategory").val("notice");
    else $("#boardCategory").val("free");
    console.log("카테고리:"+$("#boardCategory").val());
})
.on("click" ,"#btnReset", ()=>{
    document.location="/board/free";
})
</script>
</html>