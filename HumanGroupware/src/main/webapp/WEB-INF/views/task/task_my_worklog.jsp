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
<style>
.tableContainer{display:flex;}
.modal-dialog.modal-fullsize {
  width: auto;
  height: auto;
  margin: 0;
  padding: 0;
}
</style>
</head>
<body>

<div class="tableContainer">
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
	<table id="loglist"class="table">
		<tr><td><strong>일지 보관함</strong><button id="updateWorkLog" class="btn btn-light">삭제</button></td></tr>
		<tr>
			<td><input type=checkbox onclick="selectAll(this)"></td>
			<td>업무명</td>
			<td>작성자</td>
			<td>내용요약</td>
			<td>작성일</td>
		</tr>
	</table>
</div>
<div id="div"></div>
<button id="start" onclick="document.location='/WorkLog'"></button>
<%
    Map<String, Object> userInfoMap = (Map<String, Object>) session.getAttribute("userInfoMap");
    String userName = (String) userInfoMap.get("emp_name");
    int depart=(int)userInfoMap.get("emp_depart");
    int userid=(int)userInfoMap.get("emp_no");
    int managerNum = (int)userInfoMap.get("managerNum");
    String managerName = (String)userInfoMap.get("managerName");
    String departName = (String)userInfoMap.get("dep_name");
%>>
<input type="hidden" value = <%=userid %> id=userID>
<input type="hidden" value = <%=depart %> id=userDepart>
<input type="hidden" value = <%=userName %> id=userName>
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
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
</body>
<script src ="http://code.jquery.com/jquery-latest.js"></script>
<script src="/js/bootstrap-js/bootstrap.bundle.min.js"></script>
<script>
$(document)
.ready(function(){
	getUserReportList()
	checkManager()
})
.on("click","#loglist tr:gt(1) td:nth-child(4)",function(){
	
	let workNo = $(this).parent("tr").find("td:nth-child(1)").find("input[type=checkbox]").val()
	alert(workNo)
	let repNo = $(this).parent("tr").find("td:nth-child(2)").find("input[type=hidden]").attr("id")
	alert(repNo)
	openModal(repNo,workNo) 
})
.on("click","#updateWorkLog",function(){
	let workNo = ""
	let lengths = $("input[name='juniorCheckBox']:checked").length
	alert(lengths)
	for(let i = 0; i<lengths; i++){
		if(i==lengths-1){
			workNo += $("input[name='juniorCheckBox']:checked:eq("+i+")").val()	
			break;
		}
		workNo += $("input[name='juniorCheckBox']:checked:eq("+i+")").val() +  ","
	}
	$.ajax({url:"/updateWorkLog",
			type:"post",
			data:{workNo:workNo},
			success:function(data){
				document.location="/WorkLog"
			}
	})
})
function getUserReportList(){
	$.ajax({url:"/getWorkList",
			type:"post",
			dataType:"json",
			data:{userID:$("#userID").val()},
			beforeSend:function(){
				console.log($("#userID").val())
			},
			success:function(data){
				$("#loglist tr:gt(1)").remove()
				$("#pageDiv").empty()
				for(let i=0; data.length; i++){
					let li = data[i]
					let tb = "<tr>"
					tb+="<td><input type = checkbox name='juniorCheckBox' value="+li["WorkNum"]+"></td>" 
					tb+= "<td><input type='hidden' id="+li["rep_no"]+">"+li["title"]+"</td>"
					tb+= "<td>"+$("#userName").val()+"</td>"
					tb+= "<td>"+li["content"]+"</td>"
					tb+= "<td>"+li["created"]+"</td></tr>"
					
				$("#loglist").append(tb)
				}
							
			}
	})
}
function openModal(repNo,workNo){
	alert("리포트번호"+repNo)
	alert("가져온 번호2"+workNo)
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
			$("#inputDate").val(data[0]["created"]),
			console.log("제목: "+data[0]["title"]+" 부서 "+data[0]["departName"])
		}
	})
}
function selectAll(selectAll){  	
	const checkboxes = document.getElementsByName("juniorCheckBox");
	checkboxes.forEach((checkbox) => {
 		checkbox.checked = selectAll.checked;
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