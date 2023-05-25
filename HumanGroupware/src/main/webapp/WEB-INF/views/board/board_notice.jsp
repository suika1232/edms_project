<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <title>공지사항</title>
</head>
<style>
    /* #noticeTable{
        border-collapse: collapse;
    }
    #noticeTable td{
        border: 1px solid black;
        width: 100px;
        height: 30px;
        text-align: center;
    } */
</style>
<body>
    <h3>공지사항</h3>
    <table id="noticeTable" class="table">
        <thead>
            <tr>
                <th>번호</th><th>제목</th><th>작성자</th><th>작성일</th><th>조회</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
    <nav aria-label="Page navigation">
      <ul class="pagination justify-content-center">
        <li class="page-item disabled">
          <a class="page-link" href="#" aria-label="Previous">
            <span aria-hidden="true">&laquo;</span>
          </a>
        </li>
        <li class="page-item active" aria-current="page"><a class="page-link" href="#">1</a></li>
        <li class="page-item"><a class="page-link" href="#">2</a></li>
        <li class="page-item"><a class="page-link" href="#">3</a></li>
        <li class="page-item">
          <a class="page-link" href="#" aria-label="Next">
            <span aria-hidden="true">&raquo;</span>
          </a>
        </li>
      </ul>
    </nav>
    <button type="button" class="btn btn-primary" id="btnNewPost">글쓰기</button>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="/js/bootstrap.bundle.min.js"></script>
<script>
$(document)
.ready(()=>{
    getBoardList();
})
.on("click", "#btnNewPost", function(){
    let userAuth = '<%=(String)session.getAttribute("userAuth")%>'
    console.log(userAuth)
    if(userAuth != "admin"){
        alert("작성 권한이 없습니다.");
        return;
    }
    document.location="/board/newpost/notice";
})
function getBoardList(){
    $.ajax({
        url: "/boardlist/notice",
        type: "post",
        dataType: "JSON",
        success: (data) => {
            $("#noticeTable tbody").empty();
            for(let i=0; i<data.length; i++){
                let post = "<tr><td>"+data[i]["boardId"]+"</td><td>"+
                    "<a href=/board/view/"+data[i]["boardId"]+">"+
                    data[i]["boardTitle"]+"</td><td>"+
                    data[i]["empName"]+"</td><td>"+
                    data[i]["boardCreated"]+"</td><td>"+
                    data[i]["boardHit"]+"</td></tr>"
                $("#noticeTable tbody").append(post);
            }
        }
    })
}
</script>
</html>