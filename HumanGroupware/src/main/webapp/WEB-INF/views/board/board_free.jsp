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
    <br>
    <table id="freeTable" class="table table-sm table-hover">
        <thead>
            <tr>
                <th>번호</th><th>제목</th><th>작성자</th>
                <th>작성</th><th>수정</th><th>댓글</th>
                <th>조회</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
    <div id="infoText"></div>
    <nav aria-label="Page navigation" id="pageNav">
      <ul class="pagination pagination-sm justify-content-center">
      </ul>
    </nav>
    <div class="d-flex flex-row align-items-center justify-content-between">
        <div class="d-flex justify-content-start">
                <select class="form-select form-select-sm" name="searchCategory" 
                    id="searchCategory" style="width: fit-content;">
                    <option selected value="all">전체보기</option>
                    <option value="title">제목</option>
                    <option value="content">내용</option>
                    <option value="writer">작성자</option>
                </select>
                <div class="input-group input-group-sm ms-1">
                    <input type="text" class="form-control" id="searchKeyword">
                    <button type="button" class="btn btn-primary" id="btnSearch">검색</button>
                </div>
        </div>
    <% String userId = (String)session.getAttribute("loginUser");%>
    <% if(userId != null){ %>
        <div class="d-flex justify-content-center">
            <button type="button" class="btn btn-primary text-nowrap" id="btnNewPost">글쓰기</button>
        </div>
    <% } %>
    </div>
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
.on("click", "#btnSearch", ()=>{
   getBoardList(1);
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
    let searchCategory = $("#searchCategory option:selected").val();
    let keyword = $("#searchKeyword").val().trim();
    if(keyword == undefined || keyword == "") keyword = "all";
    $.ajax({
        url: "/boardlist/free/"+curPage+"/"+searchCategory+"/"+keyword,
        type: "post",
        dataType: "JSON",
        success: (data) => {
            $("#freeTable tbody").empty();
            $("#infoText").empty();
            let total = 0;
            if(data.length == 0){
                $("#infoText").append(
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
            $("#freeTable tbody tr").addClass("bg-light");

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