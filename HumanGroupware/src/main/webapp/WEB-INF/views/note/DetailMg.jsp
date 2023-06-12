<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/bootstrap-css/bootstrap.min.css">
<link rel="stylesheet" href="/css/note/DetailMg.css">
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
	<div id="detailContentDg" class=detailDg>	
		<% int value = (int)request.getAttribute("value");%>
		<%=value %>
		<%if(value == 1){ %>
			<c:forEach var="info" items="${info}">
				<div><input type ="hidden" id="sender_id" value="${info.sender_id}" readonly></div>
				<div class=div1><div class=div1-1>보낸사람</div><input type ="text" id="sender" value="${senderName}" readonly></div>
				<div class=div2><div class=div2-1>받은날짜</div><input type ="text" id="sendDate" value ="${info.note_senddate}" readonly></div>
				<div class=div3><div class=div3-1>상세내용</div><textarea id="detailContent" readonly>"${info.note_content}"</textarea></div>
				<div class=div4>
					<button id="reply" onclick = "reply()" class="btn btn-light">답장</button> 
					<button id="returnPage" class="btn btn-light">이전</button>
					<input type ="hidden" id= "val" value="${value}">
				</div>
				<!-- <div><button id="reply" onclick = "reply()">답장</button> 
				<button id="reply" onclick = "returnPage()">이전</button></div> -->
			</c:forEach>
		<% }else if(value == 2 || value == 3){ %>
			<c:forEach var="info" items="${info}">
				<div><input type ="hidden" id="receiver_id" value="${info.note_recipient}" readonly></div>
				<div class=div1><div class=div1-1>받는사람</div><input type ="text" id="receiver" value="${receiverName}" readonly></div>
				<div class=div2><div class=div2-1>보낸날짜</div><input type ="text" id="sendDate" value ="${info.note_senddate}" readonly></div>
				<div class=div3><div class=div3-1>상세내용</div><textarea id="detailContent" readonly>"${info.note_content}"</textarea></div>
				<div class=div4> 
					<button id="returnPage" class="btn btn-light">이전</button>
					<input type ="hidden" id= "val" value="${value}">
				</div>
			</c:forEach>
		<% }else if(value == 4){ %>
			<c:forEach var="info" items="${info}">
				<div><input type ="hidden" id="receiver_id" value="${info.sender_id}" readonly></div>
				<div class=div1><div class=div1-1>보낸사람</div><input type ="text" id="receiver" value="${senderName}" readonly></div>
				<div class=div2><div class=div2-1>받은날짜</div><input type ="text" id="sendDate" value ="${info.note_senddate}" readonly></div>
				<div class=div3><div class=div3-1>상세내용</div><textarea id="detailContent" readonly>"${info.note_content}"</textarea></div>
				<div class=div4> 
					<button id="returnPage" class="btn btn-light">이전</button>
					<input type ="hidden" id= "val" value="${value}">
				</div>
			</c:forEach>
		<%} %>	
	</div>
</div>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="/js/bootstrap-js/bootstrap.bundle.min.js"></script>
<script src="/js/note/DetailMg.js"></script>
</html>