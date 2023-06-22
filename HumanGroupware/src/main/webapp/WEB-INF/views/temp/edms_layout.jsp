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
    <title>EDMS</title>
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
    .list-group-item:hover{
        cursor: pointer;
    }
</style>
<body>
<div class="container-fluid">
    <div class="row d-flex flex-nowrap fixed-top">
        <div class="col-md-2 sidebar bg-light float-md-start ms-2">
            <div class="d-flex flex-column align-items-center">
                <a href="#" class="navbar-brand text-center d-block">EDMS</a>
            </div>
            <div class="card">
              <div class="card-body text-center">
                <% String id = (String)session.getAttribute("emp_id");%>
                <% if(id == null){ %>
                <a class="nav-link text-white login-btn" href="/edms/login">Login</a>
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
            <br>
            <div class="d-flex flex-column">
                <ul class="list-group">
                    <li class="list-group-item" id="list-notice" 
                        onclick="changeView('notice')">
                        <i class="bi bi-info-circle"></i>공지사항
                    </li>
                    <li class="list-group-item" id="list-free" 
                        onclick="changeView('free')">
                        <i class="bi bi-people"></i>자유게시판
                    </li>
                </ul>
                <br>
                <ul class="list-group">
                    <li class="list-group-item" id="list-draft" 
                        onclick="changeView('draft')">
                        <i class="bi bi-pencil-square"></i>기안하기
                    </li>
                    <li class="list-group-item" id="list-list" 
                        onclick="changeView('list')">
                        <i class="bi bi-list-check"></i>결재목록
                    </li>
                    <li class="list-group-item" id="list-reject" 
                        onclick="changeView('reject')">
                        <i class="bi bi-list-check"></i>반려문서함
                    </li>
                </ul>
            </div>
        </div>
        <div class="col float-md-end video-warp">
            <iframe id="sectionView" src="/board/notice" style="width: 99%; height: 100%;"></iframe>
        </div>
    </div>
</div>



</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="/js/bootstrap-js/bootstrap.bundle.min.js"></script>
<script>

function changeView(menu){
    if(menu == "notice" || menu == "free"){
        $("#sectionView").attr("src", "/board/"+menu);
    }else if(menu == "draft" || menu == "list" || menu == "reject"){
        let loginSession = '<%=(String)session.getAttribute("emp_id")%>'
        if(loginSession == "null"){
            alert("로그인이 필요합니다.");
            return false;
        }
        $("#sectionView").attr("src", "/edms/"+menu);
    }
    $(".list-group-item").removeClass("active");
    $("#list-"+menu).addClass("active");
    
}
function logout(){
    if(!confirm("로그아웃 합니까?")) return;
    $.ajax({
        url: "/edmslogout",
        type: "post",
        success: ()=>{
            alert("로그아웃 되었습니다.");
            document.location="/edms/login";
        },
        error: (err)=>{
            console.log(err);
        }
    })
}

</script>
</html>