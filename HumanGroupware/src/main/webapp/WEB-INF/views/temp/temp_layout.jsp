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
    <title>Test Home</title>
</head>
<style>
</style>
<body>
<nav class="nav justify-content-start bg-primary">
    <% String userId = (String)session.getAttribute("loginUser");%>
    <% if(userId == null){ %>
    <a class="nav-link text-white" href="/temp/login">Login</a>
    <% } %>
    <% if(userId != null){ %>
    <a class="nav-link text-white" href="#" onclick="logout()">Logout</a>
    <% } %>
    
    
</nav>
<div class="flex-column col-md-2 bg-white float-md-start" id="navbar">
    <div class="panel panel-info">
        <ul class="list-group">
            <li class="list-group-item">
                <a href="#" onclick="changeView('notice')">
                    <i class="bi bi-info-circle"></i>공지사항</a>
            </li>
            <li class="list-group-item">
                <a href="#" onclick="changeView('free')">
                    <i class="bi bi-people"></i>자유게시판</a>
            </li>
        </ul>
    </div>
</div>
<section class="float-md-none">
    <iframe id="sectionView" src="/board/notice" style="width: 850px; height: 800px;"></iframe>
</section>

</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="/js/bootstrap-js/bootstrap.bundle.min.js"></script>
<script>

function changeView(menu){
    $("#sectionView").attr("src", "/board/"+menu);
}
function logout(){
    if(!confirm("로그아웃 합니까?")) return;
    $.ajax({
        url: "/testlogout",
        type: "post",
        success: ()=>{
            alert("로그아웃 되었습니다.");
        },
        error: (err)=>{
            console.log(err);
        },
        complete: ()=>{
            window.location.reload();
        }
    })
}

</script>
</html>