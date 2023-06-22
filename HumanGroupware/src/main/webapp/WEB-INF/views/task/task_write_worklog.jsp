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
div.editable {
    width: 800px;
    height: 900px;
    border: 1px solid #dcdcdc;
    overflow-y: auto;
}
.texttitle{text-align:center;height:80px;}
.reporttable{ width:750;height:500px;}
.reporttable input{border:none;}
.intextarea{width:600px; height:450px;}
.flexContainer{display:flex; flex-direction: row;}
.sidebar {flex-shrink: 0;width: 280px;padding: 15px;background-color: #fff;}
.form{position:relative; margin-left:140px;}
.date-input-container {display: flex;align-items: center;}
.date-input-container input[type="date"] {margin-right: 5px;}
.reportAttr{position:relative; margin-left:20px;}
.reportAttr:focus{outline:none;}
.date-input-container label {margin-right: 5px;}
#section {flex-grow: 1;padding: 15px; width:1000px; height:1000px;}
#title {border:none; width:80%;}
#type {border:none; width:80%;}
#depart {position:relative; border:none; width:80%; margin-left:50px;}
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-lboi{border-color:inherit;text-align:left;vertical-align:middle}
.tg .tg-9wq8{border-color:inherit;text-align:center;vertical-align:middle}
.tg .tg-uzvj{border-color:inherit;font-weight:bold;text-align:center;vertical-align:middle}
.tg .tg-g7sd{border-color:inherit;font-weight:bold;text-align:left;vertical-align:middle}
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
<input type="hidden" value = <%=userName %> id=userName>
<div class="flexContainer">
	<div id=section>
		<table class="table">
			<tr><td><div>제목<input type="text" id="title"></div></td></tr>
			<tr><td><div>종류<select class=reportAttr>
							<option selected hidden>종류선택</option>
							<option data-value="2">일일업무</option>
							<option>주간업무</option>
							<option>월간업무</option>
							</select>
			</div></td></tr>
			<tr><td><div>부서<input type="text" id="departName" value=<%=departName %>><input type="hidden" id="departNum" value=<%=depart%>></div></td></tr>
			<tr><td><div class="date-input-container"><label for="start_date">업무일</label><input type="date" id="start_date"><span>~</span><input type="date" id="end_date"></div></td></tr>
		</table>
		<!-- <div class="editable" contenteditable="true"> 
		</div> -->
		<div id=templateBox></div>
			<div class="button-container">
	  			<button id="insert_WorkLog">작성</button>
			    <button id="cancel">이전</button>
			</div>
		</div>
	</div>
</body>
<script src ="http://code.jquery.com/jquery-latest.js"></script>
<script src="/js/bootstrap-js/bootstrap.bundle.min.js"></script>
<script>
$(document)
.ready(function(){
	checkManager()
})
.on("change",".reportAttr",function(){
	let repNo = $(this).children("option:selected").data("value");

	if(repNo==2){
		$.ajax({url:"/getReport",
				type:"post",
				dataType:"json",
				data:{repNo:repNo},
				error:function(){
					alert("에러")
				},
				success:function(data){
					$("#templateBox").empty()
					$("#templateBox").append(data.tag)
					$("style").append(data.style)
					$("#inputDepart").val($("#departName").val())		
					$("#content").attr("placeholder", "일일 업무 내용 작성");
					$("#writer").val($("#userName").val())
				}
		})
	}
	
})
.on("change","#start_date",function(){
	if($(".reportAttr").children("option:selected").val()=="일일업무"){
		$("#end_date").val($(this).val())
		$("#inputDate").val($(this).val())	
	}
	
})
.on("click","#insert_WorkLog",function(){
	let value=0
	if($(".reportAttr").children("option:selected").val()=="일일업무"){
		value=2
		insertDailyWork(value)	
	}
	
})

function insertDailyWork(value){
	$.ajax({url:"/insertReport",
			type:"post",
			data:{userID:$("#userID").val(),
				  title:$("#title").val(),
				  depart:$("#departNum").val(),
				  created:$("#inputDate").val(),
				  content:$("#content").val(),
				  notes:$("#area1").val(),
				  reportNo:value
				  },
			success:function(data){
				document.location="/MyWorkLog";
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