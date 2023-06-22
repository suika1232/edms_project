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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <title>글보기</title>
</head>
<style>
    .table td:first-child{
        width: 100px;
    }
    .table tr:nth-child(4) td{
        height: 300px;
    }
    #btnDiv button{
        margin-left: 5px;
    }
    .hide-btn{
        display: none;
    }
    textarea{
        resize: none;
    }
    .commentDiv{
        border-bottom: 1px groove #dee2e6;
    }
    .commentDiv i:hover{
        cursor: pointer;
    }
    .comment-header, .comment-bottom{
        font-size: small;
    }
    body::-webkit-scrollbar {
    width: 8px;
    }

    body::-webkit-scrollbar-thumb {
        height: 30%;
        background: #0d6efd; 
        
        border-radius: 10px;
    }
    body::-webkit-scrollbar-track {
        background: lightgray; 
    }
    
</style>
<body>  
    <div class="container">
        <input type="hidden" id="boardId" value="${boardId}">
        <!-- <input type="hidden" id="boardCategory" value="${boardCategory}"> -->
        <input type="hidden" id="boardWriter" value="${boardWriter}">
        <table class="table">
            <tr><td>제목</td><td class="text-center">${boardTitle}</td></tr>
            <tr><td>작성자</td><td class="text-center">${empName}</td></tr>
            <tr><td>작성일</td><td class="text-center">${boardCreated}</td></tr>
            <tr><td>내용</td><td class="text-center">${boardContent}</td></tr>
            <tr><td>첨부파일</td>
                <td>
                    <% String filePath = (String)request.getAttribute("boardFilePath"); %> 
                    <% if(filePath != null){ %>
                        <a href="/board/download/${boardId}">${boardFileName}</a>
                    <% } %>
                </td>
            </tr>
        </table>
        <div class="d-flex flex-row-reverse" id="btnDiv">
            <button type="button" class="btn btn-primary hide-btn" id="btnDelete">삭제</button>
            <button type="button" class="btn btn-primary hide-btn" id="btnUpdate">수정</button>
            <button type="button" class="btn btn-primary" id="btnReturn">목록</button>
        </div>
        <% String category = (String)request.getAttribute("categoryName");%>
        <% if(!category.equals("notice")){ %>
        <div class="mb-3">
          <label for="comment" class="form-label"></label>
          <textarea class="form-control" name="comment" id="comment" rows="3" required></textarea>
        </div>
        <div class="mb-3 d-flex flex-row-reverse">
            <button type="button" class="btn btn-primary" id="btnComment">댓글작성</button>
        </div>
        <% } %>
        <c:forEach items="${commentList}" var="comment" varStatus="status">
            <div class="container flex-column mb-3 commentDiv">
                <div class="row">
                    <div class="col comment-header" style="font-weight: bold;">${comment.emp_name}</div>
                    <c:if test="${emp_no==comment.writer}">
                        <div class="col-1 justify-content-end">
                            <i class="bi bi-x" id="comment${comment.comment_no}" onclick="delComment(this)"></i>
                        </div>
                    </c:if>
                </div>
                <div class="row mt-2 mb-2">
                    <div class="col">${comment.content}</div>
                </div>
                <div class="row">
                    <div class="col comment-bottom">${comment.created}</div>
                </div>
            </div>
        </c:forEach>
    </div>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="/js/bootstrap-js/bootstrap.bundle.min.js"></script>
<script>
$(document)
.ready(()=>{
    let loginUser = '<%=session.getAttribute("emp_no")%>';
    if(loginUser != "null"){
        let writer = $("#boardWriter").val();
        if(writer == parseInt(loginUser)){
            $("#btnDiv button").removeClass("hide-btn");
        } 
    }else{
        console.log(loginUser)
        $("#comment").css("display", "none");
        $("#btnComment").addClass("hide-btn");
    }

})
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
.on("click", "#btnComment", ()=>{
    let loginUser = '<%=session.getAttribute("emp_no")%>';
    $.ajax({
        url: "/addComment",
        type: "post",
        dataType: "text",
        data: {boardId:$("#boardId").val(),
                writer:loginUser,
                content:$("#comment").val()},
        success: (data)=>{
            console.log(data);
            if(data == "fail"){
                alert("댓글 작성중 오류가 발생했습니다.");
                return;
            }
            document.location.reload();
        }
    })
})

function delComment(ths){
    let commentId = $(ths).attr("id").replace("comment", "");
    console.log(commentId);
    if(!confirm("댓글을 삭제합니까?")) return;
    $.ajax({
        url: "/deleteComment",
        type: "post",
        data: {commentId: commentId},
        success: (data)=>{
            if(data == "fail"){
                alert("댓글 삭제중 오류가 발생했습니다.");
                return
            }
            document.location.reload();
        }
    })
}
</script>
</html>