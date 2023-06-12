<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/note/tom.css">
<title>Insert title here</title>
</head>
<body>
<div class="flexContainer">
	 <div class="b-example-divider b-example-vr"></div>
	  <div class="d-flex flex-column flex-shrink-0 p-3 bg-light" style="width: 280px;" id="sideBar">
	      <span class="fs-4">MESSAGE</span>
	    <hr>
	    <ul class= nav >
	      <li class="nav-item">
	        <a href="/New" class="nav-link" id="newMg">
	          <svg class="bi pe-none me-2" width="16" height="16"></svg>
	          New Message
	        </a>
	      </li>
	      <li>
	        <a href="/send" class="nav-link">
	          <svg class="bi pe-none me-2" width="16" height="16"></svg>
	          Message SendBox 
	        </a>
	      </li>
	      <li>
	        <a href="/receive" class="nav-link">
	          <svg class="bi pe-none me-2" width="16" height="16"></svg>
	          Message ReceiveBox
	        </a>
	      </li>
	      <li>
	        <a href="/tom" class="nav-link">
	          <svg class="bi pe-none me-2" width="16" height="16"></svg>
	        Tomb of Message
	        </a>
	      </li>
	    </ul>
	    <hr>
	    <div class="dropdown">
	      <a href="#" class="d-flex align-items-center link-dark text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
	        <img src="https://github.com/mdo.png" alt="" width="32" height="32" class="rounded-circle me-2">
	        <strong>mdo</strong>
	      </a>
	      <ul class="dropdown-menu text-small shadow">
	        <li><a class="dropdown-item" href="#">MyWork_LogList</a></li>
	        <li><a class="dropdown-item" href="#">UserInfo</a></li>
	        <li><hr class="dropdown-divider"></li>
	        <li><a class="dropdown-item" href="#">Sign out</a></li>
		      </ul>
	    </div>
	</div>
	<input type="hidden" id="userId" value="5">
	
	<div class=tableBox>
		<div  class=pagetitle><Strong>asd</Strong></div>
		<div id=setableBox>
			<div class="Aclub"><b>보낸 메시지</b>&nbsp<b id="se_recover"> 복구 </b>&nbsp<b id="se_hardDelete"> 삭제 </b></div>
			<table class="table" id="setable">
				<tr>
					<td><input type="checkbox" onclick=selectAll(this)></td>
					<td>받는사람</td>
					<td>내용요약</td>	
					<td>보낸날짜</td>
				</tr>
			</table>				
			<nav aria-label="Page navigation example">
				<ul class="pagination" id="SendPageBox">
				</ul>
			</nav>	
		</div>
		<div id=RetableBox>
			<div class="Bclub"><b>받은 메시지</b>&nbsp<b id="re_recover"> 복구 </b>&nbsp<b id="re_hardDelete"> 삭제 </b></div>
			<table class="table" id="Retable">
				<tr>
					<td><input type="checkbox" onclick=selectAll2(this) ></td>
					<td>보낸사람</td>
					<td>내용요약</td>	
					<td>받은날짜</td>
				</tr>
			</table>
			<nav aria-label="Page navigation example">
				<ul class="pagination" id="ReceivePageBox">
				</ul>
			</nav>
		</div>
	</div>
</div>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="/js/bootstrap.bundle.min.js"></script>
<script src="/js/note/tom.js"></script>
</html>
