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
    <title>글보기</title>
</head>
<style>
    .table td:first-child{
        width: 100px;
    }
    .table tr:last-child td{
        height: 300px;
    }
    #btnDiv button{
        margin-left: 5px;
    }
</style>
<body>  
    <div class="container">
        <input type="hidden" id="boardId" value="${boardId}">
        <input type="hidden" id="boardCategory" value="${boardCategory}">
        <table class="table">
            <tr><td>제목</td><td class="text-center">${boardTitle}</td></tr>
            <tr><td>작성자</td><td class="text-center">${empName}</td></tr>
            <tr><td>작성일</td><td class="text-center">${boardCreated}</td></tr>
            <tr><td>내용</td><td class="text-center">${boardContent}</td></tr>
        </table>
        <div class="d-flex flex-row-reverse" id="btnDiv">
            <button type="button" class="btn btn-primary" id="btnDelete">삭제</button>
            <button type="button" class="btn btn-primary" id="btnUpdate">수정</button>
            <button type="button" class="btn btn-primary" id="btnReturn">목록</button>
        </div>
    </div>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="/js/bootstrap-js/bootstrap.bundle.min.js"></script>
<script>
$(document)
.on("click", "#btnReturn", ()=>{
    document.location="/board/${categoryName}";
})
.on("click", "#btnDelete", ()=>{
    if(!confirm("삭제합니까?")) return;
    $.ajax({
        url: "/boardDelete",
        type: "post",
        data: {boardId:$("#boardId").val()},
        dataType: "text",
        success: (data) =>{
            if(data == "complete") $("#btnReturn").trigger("click");
            else alert("삭제 실패");
        }
    })
})
.on("click", "#btnUpdate", ()=>{
    if(!confirm("수정합니까?")) return;
    let boardId = parseInt($("#boardId").val());
    document.location="/boardUpdate/"+boardId;
    
})
</script>
</html>