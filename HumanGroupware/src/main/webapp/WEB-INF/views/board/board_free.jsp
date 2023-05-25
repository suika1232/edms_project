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
.ready( () => {
    getBoardList();
})
.on("click", "#btnNewPost", () => {
    let userAuth = '<%=(String)session.getAttribute("userAuth")%>'
    console.log(userAuth)
    document.location="/board/newpost/free";
})
function getBoardList(){
    $.ajax({
        url: "/boardlist/free",
        type: "post",
        dataType: "JSON",
        success: (data) => {
            $("#freeTable tr:gt(0)").empty();
            for(let i=0; i<data.length; i++){
                let post = "<tr><td>"+data[i]["boardId"]+"</td><td>"+
                    data[i]["boardtitle"]+"</td><td>"+data[i]["boardWriter"]+"</td><td>"
                    data[i]["boardCreated"]+"</td><td>"+data[i]["boardHit"]+"</td></tr>"
                $("#freeTable").append(post);
            }
        }
    })
}
</script>
</html>