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
    .sidebar{
        height: 100vh;
        box-shadow: 5px 5px 5px lightgray;
    }
    .login-btn{
        border: 1px solid #0d6efd; 
        border-radius: 8px; 
        text-align: center; 
        background-color: #0d6efd;
    }
</style>
<body>
<!-- <nav class="nav justify-content-start bg-primary">
    <% String userId = (String)session.getAttribute("loginUser");%>
    <% if(userId == null){ %>
    <a class="nav-link text-white" href="/temp/login">Login</a>
    <% } %>
    <% if(userId != null){ %>
    <div style="display: flex; align-items: center; font-weight: bold; color: white;">
        환영합니다&nbsp;
        <%=session.getAttribute("userName")%>
        &nbsp;님
    </div>    
    <a class="nav-link text-white" href="#" onclick="logout()">Logout</a>
    <% } %>
    
    
</nav> -->


<!-- <div class="flex-column col-md-2 bg-white float-md-start" id="navbar">
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
</div> -->

<div class="container-fluid">
    <div class="row flex-nowrap fixed-top">
        <div class="col-md-2 sidebar bg-light float-md-start">
            <div class="d-flex flex-column align-items-center">
                <a href="#" class="navbar-brand text-center d-block">HumanGroupWare</a>
            </div>
            <div class="card">
              <div class="card-body text-center">
                <% String id = (String)session.getAttribute("loginUser");%>
                <% if(id == null){ %>
                <a class="nav-link text-white login-btn" href="/temp/login">Login</a>
                <% } %>
                <% if(id != null){ %>
                    환영합니다<br>
                    <%=session.getAttribute("userName")%>
                    &nbsp;님
                <a class="nav-link text-white login-btn" href="#" 
                    onclick="logout()">Logout</a>
                <% } %>
              </div>
            </div>
            <div>
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
        <div class="col float-md-end video-warp">
            <iframe id="sectionView" src="/board/notice" style="width: 100%; height: 100%;"></iframe>
        </div>
    </div>
</div>



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
            window.location.reload();
        },
        error: (err)=>{
            console.log(err);
        }
    })
}

</script>
</html>