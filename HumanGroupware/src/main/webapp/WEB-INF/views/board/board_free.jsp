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
    <title>자유게시판</title>
</head>
<style>
    h3{
        text-align: center;
    }
</style>
<body>
    <input type="hidden" id="curPage">
    <input type="hidden" id="totalPage">
    <h3>자유게시판</h3>
    <table id="freeTable" class="table">
        <thead>
            <tr>
                <th>번호</th><th>제목</th><th>작성자</th>
                <th>작성</th><th>수정</th><th>댓글</th>
                <th>조회</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
    <nav aria-label="Page navigation" id="pageNav">
      <ul class="pagination justify-content-center">
      </ul>
    </nav>
    <% String userId = (String)session.getAttribute("loginUser");%>
    <% if(userId != null){ %>
        <div class="d-flex justify-content-end">
            <button type="button" class="btn btn-primary" id="btnNewPost">글쓰기</button>
        </div>
    <% } %>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="/js/bootstrap-js/bootstrap.bundle.min.js"></script>
<script>
$(document)
.ready( () => {
    $("#curPage").val("1");
    getBoardList(1);

    let userId = '<%=(String)session.getAttribute("loginUser")%>';
    console.log("로그인 유저:"+userId);
})
.on("click", "#btnNewPost", () => {
    document.location="/board/write/free";
})
function toPage(ths){
    let page = $(ths).text();
    $("#curPage").val(page);
    getBoardList(page);
}
function firstPage(){
    let curPage = parseInt($("#curPage").val());
    if(curPage > 1) getBoardList(curPage-1);
}
function lastPage(){
    let curPage = parseInt($("#curPage").val());
    let maxPage = parseInt($("#totalPage").val());
    if(curPage < maxPage) getBoardList(curPage+1);
}
function getBoardList(curPage){
    
    $.ajax({
        url: "/boardlist/free/"+curPage,
        type: "post",
        dataType: "JSON",
        success: (data) => {
            $("#freeTable tbody").empty();
            let total = 0;
            if(data.length == 0){
                $("#freeTable").after(
                    "<div class='d-flex justify-content-center'>작성된 글이 없습니다.</div>");
            }
            for(let i=0; i<data.length; i++){
                let post = "<tr><td>"+data[i]["boardNo"]+"</td><td>"+
                    "<a href=/board/view/"+data[i]["boardId"]+">"+
                    data[i]["boardTitle"]+"</td><td>"+
                    data[i]["empName"]+"</td><td>"+
                    data[i]["boardCreated"]+"</td><td>"+
                    data[i]["boardUpdated"]+"</td><td>"+
                    data[i]["commentCount"]+"</td><td>"+
                    data[i]["boardHit"]+"</td></tr>"
                $("#freeTable tbody").append(post);
                total = data[i]["totalPage"];
            }
            $("#pageNav ul").empty();
            let nav = "";
            if(total > 1) {
                nav += "<li class='page-item'>"+
                        "<a class='page-link' aria-label='Previous'"+
                        " onclick=firstPage()>"+
                        "<span aria-hidden='true'>&laquo;</span></a>";
            }
            for(let i=1; i<=total; i++){
                nav += "<li class='page-item'>"; 
                nav += "<a class='page-link' onclick=toPage(this)>"+i;
                nav += "</a></li>";
                $("#pageNav>ul").append(nav);
                nav = "";
            }
            if(total > 1) {
                nav += "<li class='page-item'>"+
                        "<a class='page-link' aria-label='Next'"+
                        " onclick=lastPage()>"+
                        "<span aria-hidden='true'>&raquo;</span></a>";
                $("#pageNav>ul").append(nav);
            }
            if(total > 1){
                if(curPage == 1) $("#pageNav li:first-child").addClass("disabled");
                if(curPage == total) $("#pageNav li:last-child").addClass("disabled");
                $("#pageNav li:eq("+curPage+")").addClass("active");
            }else{
                $("#pageNav li:eq(0)").addClass("active");
            }
            $("#curPage").val(curPage);
            $("#totalPage").val(total);
        }
    })
}
</script>
</html>