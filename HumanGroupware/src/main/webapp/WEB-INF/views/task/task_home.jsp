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
<link rel="stylesheet" href="/css/summernote/summernote-lite.css">
<title>Insert title here</title>
</head>
<style>
.flexcontainer{display:flex; height:1000px; width:2000px;}
.tableBox{width:1000px;}
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
<input type="hidden" value = <%=userid %> id=userID>
<input type="hidden" value = <%=depart %> id=userDepart>
<input type="hidden" value = <%=userName %> id=userName>
<input type="hidden" value = <%=managerNum %> id=managerNum>
	<div class="flexcontainer">
<%if(userid == managerNum) {%>
		<div class="tableBox">
			<table id="ReceiveReportList" class="table">
				<tr><td><strong>보고 받은 업무</strong></td></tr>
				<tr>
					<td>업무 이름</td>
					<td>작성자</td>
					<td>내용</td>
					<td>기간</td>
				</tr>
			</table>
			<div id="pageButtonBox"></div>
		</div>
<%} else{%>
		<div class="tableBox">
			<table id="SendReportList" class="table">
				<tr><td><strong>작성한 업무보고</strong></td></tr>
				<tr>
					<td>업무 이름</td>
					<td>지시자</td>
					<td>내용</td>
					<td>작성일</td>
				</tr>
			</table>
			<div id="pageButtonBox"></div>
		</div>
<%} %>
</div>
</body>
<script src ="http://code.jquery.com/jquery-latest.js"></script>
<script src="/js/bootstrap-js/bootstrap.bundle.min.js"></script>
<script src="/js/summernote/summernote-lite.js"></script>
<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
<script>
$(document)
.ready(()=>{
	checkManager()
	selectReport()
})
.on("click","#SendReportList tr:gt(1) td:nth-child(3)",function(){
	
	let type = "S_Task_Report"
	
	
	
	let tr_id =$(this).parent("tr").find("input[name=id]").val()
	let userID =$(this).parent("tr").find("input[name=num]").val()
	
	document.location="/detail/"+type+"/"+tr_id+"/"+userID
	
})
.on("click","#ReceiveReportList tr:gt(1) td:nth-child(3)",function(){
	
	let type = "R_Task_Report"
	
	let tr_id =$(this).parent("tr").find("input[name=id]").val()
	let userID =$(this).parent("tr").find("input[name=num]").val()
	
	
	document.location="/detail/"+type+"/"+tr_id+"/"+userID
	
})
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

function selectReport(){
	$.ajax({url:"/selectReport",
			type:"post",
			dataType:"json",
			data:{userID:$("#userID").val(),
				  managerNum:$("#managerNum").val()},
			success:function(data){
				for(let i=0; i<data.length; i++){
					let li=data[i]
					let tb=""
					tb += "<tr>";
					tb += "<td><input type='hidden' value=" + li["writerNum"] + " name='num'>" + li["title"] + "</td>";
					tb += "<td><input type='hidden' value=" + li["tr_id"] + " name='id'>" + li["human"] + "</td>";
					tb += "<td>" + li["content"] + "</td>";
					tb += "<td>" + li["created"] + "</td>";
					tb += "</tr>";

					
					if($("#userID").val()==$("#managerNum").val()){
						$("#ReceiveReportList").append(tb)
					}else{
						$("#SendReportList").append(tb)	
					}
					
				}
			}
	})
}

</script>

</html>