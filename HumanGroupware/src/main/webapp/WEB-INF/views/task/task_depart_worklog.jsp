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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>Insert title here</title>
</head>
<style>
.tableContainer{display:flex;}
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
<input type="hidden" value="<%=depart %>" id="userDepart">
<input type="hidden" value="<%=userName %>" id="userName">
<input type="hidden" value="<%=userid %>" id="userID">
<div class="tableContainer">
	<table id="loglist"class="table">
		<tr><td><strong>부서 일지함</strong><button id="updateWorkLog" class="btn btn-light">삭제</button></td></tr>
		<tr>
			<td><input type=checkbox onclick="selectAll(this)"></td>
			<td>업무명</td>
			<td>작성자</td>
			<td>내용요약</td>
			<td>작성일</td>
		</tr>
	</table>
</div>
<div class="modal" tabindex="-1" id="detailLog">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">일지상세</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">이전</button>
      </div>
    </div>
  </div>
</div>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="/js/bootstrap-js/bootstrap.bundle.min.js"></script>
<script>
$(document)
.ready(function(){
	getWorkLog()
	checkManager()
})
.on("click","#loglist tr:gt(1) td:nth-child(4)",function(){
	
	let workNo = $(this).parent("tr").find("td:nth-child(1)").find("input[name=juniorCheckBox]").val()
	
	let repNo = $(this).parent("tr").find("td:nth-child(2)").find("input[type=hidden]").attr("id")
	
	openModal(repNo,workNo)
})
 function openModal(repNo,workNo){
	$('#detailLog').modal('show');
	getUserReport(repNo,workNo)
}
function getUserReport(repNo,workNo){
	$.ajax({url:"/getMyWorkLog",
		type:"post",
		dataType:"json",
		data:{repNo:repNo},
		success:function(data){
			$(".modal-body").empty()
			$(".modal-body").append(data.tag)
			$("style").append(data.tablestyle)
			getUserData(workNo)
		}
	})
}
function getUserData(workNo){
	$.ajax({url:"/getWorkData",
		type:"post",
		dataType:"json",
		data:{workNo:workNo,
			  userName:$("#userName").val()},
		success:function(data){
			$("#title").val(data[0]["title"]),
			$("#inputDepart").val(data[0]["departName"]),
			$("#writer").val(data[0]["writer"]),
			$("#content").val(data[0]["content"]),
			$("#area1").val(data[0]["notes"]),
			$("#inputDate").val(data[0]["created"])
		}
	})
}
function getWorkLog(){
	$.ajax({url:"/getDworkLog",
			type:"post",
			dataType:"json",
			data:{dep_id:$("#userDepart").val()},
			success:function(data){
				for(let i=0; i<data.length; i++){
					let li = data[i]
					let tb = "<tr>"
					tb+="<td><input type=checkbox name='juniorCheckBox' value="+li["WorkNo"]+"></td>"
					tb+= "<td><input type=hidden id="+li["rep_no"]+">"+li["title"]+"</td>"
					tb+= "<td>"+li["writer"]+"</td>"
					tb+= "<td>"+li["content"]+"</td>"
					tb+= "<td>"+li["created"]+"</td></tr>"
					
					$("#loglist").append(tb)
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
</body>
</html>