<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/bootstrap-css/bootstrap.min.css">
<link rel="stylesheet" href="/css/note/ReceiveMg.css?after">
<title>Insert title here</title>
</head>
<body>
<% int userno = (int)session.getAttribute("emp_no");%>
<div class="flexContainer">
	<input type="hidden" id="userId" value=<%=userno %>>
	<div class="tableBox">	
		<div style="margin-left:50px;"><strong>받은편지함</strong></div>	
		<table id="receiveMessageList" class="table">
			<tr><td><input type = checkbox id=kingCheckBox onclick = "selectAll(this)"></td>
				<td><button id="deleteMessage" class="btn btn-light">삭제</button></td>
				<td>보낸사람</td>
				<td>내용요약</td>	
				<td>받은날짜</td>
			</tr>
		</table>
		<nav aria-label="Page navigation example">
  			<ul class="pagination" id="pageButtonBox">
  			</ul>
		</nav>
		<select class=selectBox>
			<option>5</option>
			<option>10</option>
			<option>20</option>
			<option>30</option>
		</select>&nbsp	
		<strong id="totalMessage" class="totalMessage"></strong>
	</div>
</div>

</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
<script src="/js/bootstrap-js/bootstrap.bundle.min.js"></script>
<script src="/js/note/ReceiveMg.js"></script>
</html>