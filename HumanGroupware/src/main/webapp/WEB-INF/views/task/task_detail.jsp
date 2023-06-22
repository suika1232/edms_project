<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true"%>
<%@ page import="java.util.Map" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/bootstrap-css/bootstrap.min.css">
<title>Insert title here</title>
<style>
.flexContainer{display:flex;}
.tableBox{width:95%;}
#content{ width:600px; height:400px;}
input{border:none; margin-left: 50px;}
</style>
</head>
<%
    Map<String, Object> userInfoMap = (Map<String, Object>) session.getAttribute("userInfoMap");
    String userName = (String) userInfoMap.get("emp_name");
    int depart=(int)userInfoMap.get("emp_depart");
    int userid=(int)userInfoMap.get("emp_no");
    int managerNum = (int)userInfoMap.get("managerNum");
    String managerName = (String)userInfoMap.get("managerName");
    String departName = (String)userInfoMap.get("dep_name");
%>
<input type="hidden" value = <%=userid %> id=userID>
<input type="hidden" value = <%=depart %> id=userDepart>
<input type="hidden" value = <%=userName %> id=userName>
<body>
<div class="flexContainer">
	<div class="tableBox">
	<% String type = (String)request.getAttribute("type"); %>
	<% String human = (String)request.getAttribute("human"); %>
	<%if(type.equals("S_Task")){ %>
		<div id="tableContainer">
			<table id="detailTask" class="table">
				<tr>
					<td>업무명<input type="text" id="title" value="${sto.task_name}"></td>
				</tr>
				<tr>
					<td>진행자<input type="text" id="writer" value="<c:out value="${human}"/>"></td>
				</tr>
				<tr>
					<td>업무기한<input type="date" id="startDate" value="${sto.task_started}">~<input type="date" id="endDate"  value="${sto.task_limit}"></td>
				</tr>
				<tr>
					<td>내용<textarea id="content">${sto.task_content}</textarea></td>
				</tr>
				<tr>
					<td><button id="returnBtn" value="Task">이전</button></td>
				</tr>
			</table>
		</div>
	<%}else if(type.equals("R_Task")){ %>
		<div id="tableContainer">
			<table id="detailTask" class="table">
				<tr>
					<td>업무명<input type="text" id="title"value="${sto.task_name}"></td>
				</tr>
				<tr>
					<td>지시자<input type="text" id="drafter" value="<c:out value="${human}"/>"></td>
				</tr>
				<tr>
					<td>업무기한<input type="date" id="startDate"value="${sto.task_started}">~<input type="date" id="endDate"value="${sto.task_limit}"></td>
				</tr>
				<tr>
					<td>내용<textarea id="content" readonly>${sto.task_content}</textarea></td>
				</tr>
				<tr>
					<td><button id="returnBtn" value="Task">이전</button></td>
				</tr>
			</table>
		</div>
	<%}else if(type.equals("S_Task_Report")){ %>
		<div id="tableContainer">
			<table id="detailReport" class="table">
				<tr>
					<td colspan="2">제목<input type="text" id="title" value="${sto.tr_title}"></td>
				</tr>
				<tr>
					<td>작성자<input type="text" id="writer"value="<c:out value="${human}"/>"></td><td>작성일<input type="date" id="createDate" value="${sto.tr_created}"></td>
				</tr>
				<tr>
					<td colspan="2">내용<textarea id="content">${sto.tr_content}</textarea></td>
				</tr>
				<tr>
					<td colspan="2"><button id="returnBtn" value="Report">이전</button></td>
				</tr>
			</table>
		</div>
	<%}else{ %>
		<div id="tableContainer">
			<table id="detailReport" class="table">
				<tr>
					<td colspan="2">제목<input type="text" id="title" value="${sto.tr_title}"></td>
				</tr>
				<tr>
					<td>작성자<input type="text" id="writer"value="<c:out value="${human}"/>"></td><td>작성일<input type="date" id="createDate"value="${sto.tr_created}"></td>
				</tr>
				<tr>
					<td colspan="2">내용<textarea id="content">${sto.tr_content}</textarea></td>
				</tr>
				<tr>
					<td colspan="2"><button id="returnBtn" value="Report">이전</button></td>
				</tr>
			</table>
		</div>
	<%} %>
	</div>
</div>
</body>
<script src ="http://code.jquery.com/jquery-latest.js"></script>
<script src="/js/bootstrap-js/bootstrap.bundle.min.js"></script>
<script>
$(document)
.ready(function(){
	
})
.on("click","#returnBtn",function(){
	let value = $(this).val()
	returnpage(value)
})

function returnpage(value){
	if(value==="Task"){
		document.location="/requestTask"
	}else{
		document.location="/Taskhome"
	}
}
</script>
</html>