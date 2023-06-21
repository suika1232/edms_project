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
</head>
<style>
.flexContainer{
	display:flex;
}
.tableBox {
	width:95%;
}
input{ outline:none; border:none;}
</style>
<body>
<%
    Map<String, Object> userInfoMap = (Map<String, Object>) session.getAttribute("userInfoMap");
    String userName = (String) userInfoMap.get("emp_name");
    int depart=(int)userInfoMap.get("emp_depart");
    int userid=(int)userInfoMap.get("emp_no");
    int managerNum = (int)userInfoMap.get("managerNum");
    String managerName = (String)userInfoMap.get("managerName");
    String departName = (String)userInfoMap.get("dep_name");
%>
<input type="hidden" id="managerNum" value =<%=managerNum %>>
<input type="hidden" id="userName" value =<%=userName %>>
<input type="hidden" id="userID" value =<%=userid %>>
<div class="flexContainer"> 
<%if(userid==managerNum){%>
	<div class="tableBox">
			<table id="SendTask" class="table">
				<tr><td><strong>작성한 업무함</strong></td></tr>
				<tr>
					<td>업무 이름</td>
					<td>수행자</td>
					<td>내용</td>
					<td>업무 기한</td>
				</tr>
			</table>
			<div id="pageButtonBox"></div>
	</div>
<%}else {%>
	<div class="tableBox">
			<table id="ReceiveTask" class="table">
				<tr><td><strong>지시받은 업무함</strong></td></tr>
				<tr>
					<td>업무 이름</td>
					<td>지시자</td>
					<td>내용</td>
					<td>업무 기한</td>
				</tr>
			</table>
			<div id="pageButtonBox"></div>
	</div>
<%} %>
</div>

</body>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="/js/bootstrap-js/bootstrap.bundle.min.js"></script>
<script>
$(document)
.ready(function(){
	selectTask()
	checkManager()
})
.on("click","#SendTask tr:gt(1) td:nth-child(3)",function(){
	
	let type = "S_Task"
	
	let t_id = $(this).parent("tr").find("input[name='task_Num']").val()
	let userID=$("#userID").val()
	
	document.location="/detail/"+type+"/"+t_id+"/"+userID
	
})
.on("click","#ReceiveTask tr:gt(1) td:nth-child(3)",function(){
	
	let type = "R_Task"

	let t_id = $(this).parent("tr").find("input[name='task_Num']").val()
	let userID=$("#userID").val()
	
	document.location="/detail/"+type+"/"+t_id+"/"+userID
})
function selectTask(){
	$.ajax({url:"/selectTasks",
			type:"post",
			dataType:"json",
			data:{userID:$("#userID").val(),
				 managerNum:$("#managerNum").val()},
			success:function(data){
				for(let i=0; i<data.length; i++){
					let li = data[i]
					let tb = "<tr>"
					
					tb+= "<td><input type='hidden' value="+li["task_id"]+" name='task_Num'>"+li["task_name"]+"</td>"
					tb+= "<td>"+li["task_human"]+"</td>"
					tb+= "<td>"+li["task_content"]+"</td>"
					tb+= "<td>"+li["task_started"]+"~"+li["task_limit"]+"</td></tr>"
					
					if($("#userID").val()==$("#managerNum").val()){
						$("#SendTask").append(tb)
					}else{
						$("#ReceiveTask").append(tb)	
					}
					
				}				
			}
	})
}
function checkManager(){
	
	let manager = $("#managerNum").val()
	
	if(manager==$("#userID").val()||manager==100){		
		let tag1 = "<li><a href='/depWorkLog' class='link-dark d-inline-flex text-decoration-none rounded'>부서일지</a></li>"
		$("#btn1").append(tag1)
		let tag2=  "<li><a href='#' class='link-dark d-inline-flex text-decoration-none rounded'>휴지통</a></li>"
		$("#btn1").append(tag2)
		let tag3 = "  <li><a href=''#' class='link-dark d-inline-flex text-decoration-none rounded'>휴지통</a></li>"
		$("#btn2").append(tag3)
	}		
}
</script>
</html>