<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/bootstrap-css/bootstrap.min.css">
<link rel="stylesheet" href="/css/note/SendMg.css">
<title>Insert title here</title>
</head>
<body>
<% String name = (String)session.getAttribute("emp_name");%>
<% int userno = (int)session.getAttribute("emp_no");%>
<div class="flexContainer">
 <!-- <div class="b-example-divider b-example-vr"></div>
	  <div class="d-flex flex-column flex-shrink-0 p-3 bg-light" id="divT" style="width: 280px;" id="sideBar">
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
	  </div> -->
	  <input type="hidden" id="userId" value=<%=userno %>>	
	<div class="tableBox">	
		<table id="sendMessageList" class="table">
			<tr><td><input type = checkbox id="kingCheckBox" onclick = "selectAll(this)"></td>
				<td><button id="deleteMessageButton" class="btn btn-light">삭제</button></td>
				<td>받는사람</td>
				<td>내용요약</td>	
				<td>보낸날짜</td>
			</tr>
		</table>
		 <nav aria-label="Page navigation example">
  			<ul class="pagination" id="pageButtonBox">
  			</ul>
		</nav>
		<select class="liSelect" id="select">
			<option>5</option>
			<option>10</option>
			<option>20</option>
			<option>30</option>
		</select>&nbsp
		<strong id="totalMessage" class="totalMessage"></strong>
	 </div>
</div>
<script src = "https://code.jquery.com/jquery-latest.js"></script>
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="/js/bootstrap-js/bootstrap.bundle.min.js"></script>
<script src="/js/note/SendMg.js"></script>
</body>
</html>