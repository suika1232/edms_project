<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/bootstrap-css/bootstrap.min.css">
<link rel="stylesheet" href="/css/note/SendMg.css?after">
<title>Insert title here</title>
</head>
<body>
<% String name = (String)session.getAttribute("emp_name");%>
<% int userno = (int)session.getAttribute("emp_no");%>
<div class="flexContainer">
	  <input type="hidden" id="userId" value=<%=userno %>>	
	<div class="tableBox">	
		<div style="margin-left:50px;"><strong>보낸편지함</strong></div>	
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