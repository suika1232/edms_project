<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/bootstrap-css/bootstrap.min.css">
    <title>결재목록</title>
</head>
<style>
</style>
<body>
<h3 style="text-align: center;">결재목록</h3>
<table id="edmsListTable" class="table table-sm table-hover text-center">
    
    <thead>
        <tr>
            <th>번호</th><th>분류</th><th>제목</th>
            <th>기안자</th><th>부서</th><th>기안일</th>
            <th>상태</th>
        </tr>
    </thead>
    <tbody></tbody>
</table>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="/js/bootstrap-js/bootstrap.bundle.min.js"></script>
<script>
$(document)
.ready(()=>{
    getEdmsList();
})
function getEdmsList(){
    $.ajax({
        url: "/getEdmsList/all",
        type: "post",
        dataType: "json",
        success: (data)=>{
            $("#edmsListTable tbody").empty();
            console.table(data);
            data.forEach(edms => {
                let str = "<tr><td>"+edms["edmsId"]+"</td>";
                str += "<td>"+edms["edmsCategory"]+"</td>"
                str += "<td>"+"<a href='/edms/view/"+edms["edmsId"]+"'>"+edms["edmsTitle"]+"</a></td>";
                str += "<td>"+edms["empName"]+"</td>";
                str += "<td>"+edms["depName"]+"</td>";
                str += "<td>"+edms["edmsDate"]+"</td>";
                let status = edms["edmsStatus"];
                str += "<td><span>"+edms["edmsStatus"]+"</span></td>";    
                
                $("#edmsListTable tbody").append(str);

                setStatusColor();
            });
        }
    })
}
function setStatusColor(){
    $("#edmsListTable tbody").find("span").each(function(i, el){
        let span = $(this);
        let status = span.text();
        if(status == "결재대기"){
            span.css("color", "#0d6efd");
        }else if(status == "완료"){
            span.css("color", "green");
        }else span.css("color", "red");
    });
}
</script>
</html>