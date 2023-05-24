<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Board - Free</title>
</head>
<style>
    #freeTable{
        border-collapse: collapse;
    }
    #freeTable td{
        border: 1px solid black;
        width: 100px;
        height: 30px;
        text-align: center;
    }
</style>
<body>
    자유게시판
    <table id="freeTable">
        <tr><td>번호</td><td>제목</td><td>작성자</td><td>작성일</td><td>조회</td></tr>
    </table>
    <button id="btnNewPost">글쓰기</button>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.on("click", "#btnNewPost", function(){
    $.ajax({
        url: "/hw/board/newpost",
        type: "post",
        data: {"category":category},
        success: function(){
            console.log("글쓰기성공");
        },
        error: function(error){
            console.log(error);
        }
    })
})
</script>
</html>