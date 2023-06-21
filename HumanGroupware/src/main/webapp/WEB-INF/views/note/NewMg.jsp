<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<% String name = (String)session.getAttribute("emp_name");%>
<% int userno = (int)session.getAttribute("emp_no");%>
<link rel="stylesheet" href="/css/bootstrap-css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/note/NewMg.css">
<title>Insert title here</title>
</head>
<body>
<div class="flexContainer"> 
	<table class="table">
	<tr>
		<th>작성자</th><td><input type = text id ="mg_Writer" value=<%=name %>></td> 
	</tr>
	<tr>
		<th>받는사람</th><td><input type =text id="mg_Receiver" value="${senderName}" placeholder="찾기버튼을 눌러주세요"><button id = "serchUserButton" class="btn btn-light" onclick="openUserBox()">찾기</button></td>
	</tr>
	<tr>
		<th>내용</th><td><textarea id="mg_Content" placeholder = "1000자 이내로 작성"></textarea></td> 
	</tr>
	<tr><td class="hidden_td"><button id="sendButton" class="btn btn-light">작성</button><button id="cancelButton" class="btn btn-light">취소</button></td></tr>
	<tr><td class="hidden_td"><input type ="hidden" id="userId" value="${senderID}" style = border:none;><input type ="hidden" id="userNo" value = <%=userno %>></td></tr>
	</table>
</div>
<div class="modal" tabindex="-1" id="userBox">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">사원 찾기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      	<select id="userSelect"></select>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">이전</button>
        <button type="button" class="btn btn-primary" id="okbutton">선택완료</button>
      </div>
    </div>
  </div>
</div>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<!-- <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script> -->
<script src="/js/bootstrap-js/bootstrap.bundle.min.js"></script>
<script src="/js/note/NewMg.js"></script>
</html>