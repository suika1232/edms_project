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
.flexContainer{
	display:flex;
}
input{ outline:none; border:none;}
textarea {width:600px; height:400px;}
</style>
</head>
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
	<div class="flex-shrink-0 bg-white" style="width: 280px;">
	    <a href="/" class="d-flex align-items-center pb-3 mb-3 link-dark text-decoration-none border-bottom">
	      <svg class="bi pe-none me-2" width="30" height="24"><use xlink:href="#bootstrap"></use></svg>
	      <span class="fs-5 fw-semibold">Task</span>
	    </a>
	    <ul class="list-unstyled ps-0">
	      <li class="mb-1">
	        <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#home-collapse" aria-expanded="true">
	          Work__Log
	        </button>
	        <div class="collapse show" id="home-collapse">
	          <ul id="btn1" class="btn-toggle-nav list-unstyled fw-normal pb-1 small">            
	            <li><a href="/MyWorkLog" class="link-dark d-inline-flex text-decoration-none rounded">내 업무일지</a></li>
	            <li><a href="/WorkLog" class="link-dark d-inline-flex text-decoration-none rounded">일지작성</a></li>
	          </ul>
	        </div>
	      </li>
	      <li class="mb-1">
	        <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#dashboard-collapse" aria-expanded="false">
	          Work__Report
	        </button>
	        <div class="collapse" id="dashboard-collapse">
	          <ul id="btn2"class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
	            <li><a href="/Taskhome" class="link-dark d-inline-flex text-decoration-none rounded">작성한 업무보고</a></li>
	            <li><a href="/requestTask" class="link-dark d-inline-flex text-decoration-none rounded">지시받은 업무</a></li>
	            <li><a href="/writeReport" class="link-dark d-inline-flex text-decoration-none rounded">작성하기</a></li>
	          </ul>
	        </div>
	      </li>
	      <li class="border-top my-3"></li>
	      <li class="mb-1">
	        <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#account-collapse" aria-expanded="false">
	          Account
	        </button>
	        <div class="collapse" id="account-collapse">
	          <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
	            <li><a href="/" class="link-dark d-inline-flex text-decoration-none rounded">New...</a></li>
	            <li><a href="#" class="link-dark d-inline-flex text-decoration-none rounded">Profile</a></li>
	            <li><a href="#" class="link-dark d-inline-flex text-decoration-none rounded">Settings</a></li>
	            <li><a href="#" class="link-dark d-inline-flex text-decoration-none rounded">Sign out</a></li>
	          </ul>
	        </div>
	      </li>
	    </ul>
	</div>
	<%if(userid==managerNum) {%>
		<table class="table">
		<tr>
			<th>제목</th><td><input type = text id ="ts_title"></td>
			<th>부서</th><td><input type =text id="ts_depart" value=<%=departName %> name=<%=depart %>></td> 
		</tr>
		<tr>
			<th>업무명</th><td><input type = text id="ts_TaskName"></td>
		</tr>
		<tr>
			<th>받는사람</th><td colspan=2><select id="ts_UserList"></select></td>
		</tr>
		<tr><th>업무기간</th><td><input type=date id="ts_start">~<input type=date id="ts_limit"></td></tr>
		<tr>
			<th>내용</th><td colspan=2><textarea id="ts_content" placeholder = "1000자 이내로 작성"></textarea></td> 
		</tr>
		<tr><td class="hidden_td" colspan=2><button id="sendButton1" class="btn btn-light">작성</button><button id="cancelButton" class="btn btn-light">취소</button></td></tr>
	</table>
	<%} else {%>
	<table class="table">
		<tr>
			<th>제목</th><td><input type = text id ="ts_title"></td>
			<th>부서</th><td><input type =text id="ts_depart" value=<%=departName %> name=<%=depart %>></td> 
		</tr>
		<tr>
			<th>업무명</th><td><select id="ts_TaskName"></select></td>
		</tr>
		<tr>
			<th>보고대상</th><td colspan=2><input type =text id="ts_Receiver" value=<%=managerName %> name=<%=managerNum%>></td>
		</tr>
		<tr><th>작성일</th><td><input type=date id="ts_created"></td></tr>
		<tr>
			<th>내용</th><td colspan=2><textarea id="ts_content" placeholder = "1000자 이내로 작성"></textarea></td> 
		</tr>
		<tr><td class="hidden_td" colspan=2><button id="sendButton2" class="btn btn-light">작성</button><button id="cancelButton" class="btn btn-light">취소</button></td></tr>
	</table>
	<% }%>
</div>
</body>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="/js/bootstrap-js/bootstrap.bundle.min.js"></script>
<script>
$(document)
.ready(function(){
	checkManager()
	if($("#userID").val()==$("#managerNum").val()){
		selectUser()
	}
		selectTask()	
})
.on("click","#sendButton1",function(){
	insertTask()
})
.on("click","#sendButton2",function(){
	insertTask_report()
})
function insertTask_report(){
	$.ajax({url:"/insertTask_report",
			type:"post",
			data:{userID:$("#userID").val(),
				  depart:$("#ts_depart").attr("name"),
				  task: $("#ts_TaskName").find(":selected").val(),
				  title:$("#ts_title").val(),
				  receiver:$("#ts_Receiver").attr("name"),
				  created:$("#ts_created").val(),
				  content:$("#ts_content").val()
				  },
			success:function(data){
				document.location="/Taskhome"
			}
	})
} 

function selectTask(){
	$.ajax({url:"/selectTask",
			type:"post",
			dataType:"json",
			data:{userID:$("#userID").val()},
			success:function(data){
				let op=""
				$("#ts_TaskName").empty()
				for(let i=0; i<data.length; i++){
					let li = data[i]
					 op += "<option value="+li["taskID"]+">"+li["taskName"]+"</option>"
				}
				$("#ts_TaskName").append(op)
			}
	})
}
//////////////////////////////////////////////////////////////////////////////////////
function selectUser(){
	$.ajax({url:"/selectUser",
			type:"post",
			dataType:"json",
			data:{departNum:$("#ts_depart").attr("name")},
			beforeSend:function(){
				console.log($("#ts_depart").attr("name"))
			},
			success:function(data){
				let op=""
					$("#ts_UserList").empty()
					for(let i=0; i<data.length; i++){
						let li = data[i]
						 op += "<option value="+li["emp_no"]+">"+li["emp_name"]+"</option>"
					}
					$("#ts_UserList").append(op)
				}
	})
}
function insertTask(){
	$.ajax({url:"/insertTask",
			type:"post",
			data:{title:$("#ts_title").val(),
				  depart:$("#ts_depart").attr("name"),
				  drafter:$("#userID").val(),
				  performer:$("#ts_UserList").val(),
				  start:$("#ts_start").val(),
				  limit:$("#ts_limit").val(),
				  content:$("#ts_content").val()
				  },
			success:function(data){
				document.location="/Taskhome"	
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