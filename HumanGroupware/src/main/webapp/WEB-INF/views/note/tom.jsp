<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/bootstrap-css/bootstrap.min.css">
<link rel="stylesheet" href="/css/note/tom.css?after">
<title>Insert title here</title>
</head>
<body>
<% String name = (String)session.getAttribute("emp_name");%>
<% int userno = (int)session.getAttribute("emp_no");%>
<div class="flexContainer container justify-content-center">
	<input type="hidden" id="userId" value=<%=userno%>>
		
	<div class="tableBox">
	<div style="margin-left:50px;"><strong>휴지통</strong></div>
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
<script src="/js/bootstrap-js/bootstrap.bundle.min.js"></script>
<script src="/js/note/tom.js"></script>
</html>
