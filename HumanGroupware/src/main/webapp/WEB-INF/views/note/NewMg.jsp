<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/NewMg.css">
<title>Insert title here</title>
</head>
<body>
<div class="flexContainer"> 
	  <div class="b-example-divider b-example-vr"></div>
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
	  </div>
	<table class="table">
	<tr>
		<th>작성자</th><td><input type = text id ="mg_Writer"></td> 
	</tr>
	<tr>
		<th>받는사람</th><td><input type =text id="mg_Receiver" value="${senderName}" placeholder="찾기버튼을 눌러주세요"><button id = "serchUserButton" class="btn btn-light" onclick="openUserBox()">찾기</button></td>
	</tr>
	<tr>
		<th>내용</th><td><textarea id="mg_Content" placeholder = "1000자 이내로 작성"></textarea></td> 
	</tr>
	<tr><td class="hidden_td"><button id="sendButton" class="btn btn-light">작성</button><button id="cancelButton" class="btn btn-light">취소</button></td></tr>
	<tr><td class="hidden_td"><input type ="hidden" id="userId" value="${senderID}" style = border:none;><input type ="hidden" id="userNo" value = "5"></td></tr>
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
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<!-- <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script> -->
<script src="/js/bootstrap.bundle.min.js"></script>
<script src="/js/NewMg.js"></script>
</html>