<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/bootstrap-css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <title>template</title>
</head>
<style>
    #templateDocument table{
        border-collapse: collapse; 
        text-align: center;
    }
    #templateLeaveHead td, #templateLeaveBody td{
        border: 1px solid black;
        height: 55px;
    }
    #templateLeaveHead > tbody > tr:nth-child(1) > td:nth-child(1){
        border: none;
    }
    #templateLeaveHead > tbody > tr:nth-child(1) > td:nth-child(2){
        border-bottom: none;
        width: 40px;
    }
    #templateLeaveHead > tbody > tr:nth-child(2) > td{
        border-bottom: none;
        width: 100px;
    }
    #templateLeaveBody > tbody > tr > td:first-child{
        width: 100px;
    }
    #templateLeaveBody > tbody > tr:nth-child(5) > td:nth-child(2){
        height: 200px;
    }
    #templateLeaveBody > tbody > tr:nth-child(7) > td{
        height: 150px;
    }
    #templateLeaveBody > tbody > tr:nth-child(5) > td:nth-child(2){
        height: 80px;
    }
    #templateLeaveBody input[type=text]{
        width: 45px;
    }
    #templateLeaveBody > tbody > tr:nth-child(n+1):nth-child(-n+3) > td:nth-child(2){
        text-align: start;
        vertical-align: middle;
    }
    #templateLeaveBody textarea{
        outline: none; resize: none; width: 400px; height: 190px; 
        display: block; border: none;
    }
    #modalBody table span{
        color:blue;
    }
    #modalBody table span:hover{
        color:purple;
        cursor: pointer;
    }
    #writer, #approverMidName, #approverFinalName, #leavePeriod{
        width: 50px; padding: 0; outline: none; border: none;
    }
    #writeYear, #writeMonth, #writeDay{
        padding: 0; outline: none; border: none; text-align: right;
    }
    #writeYear{
        width: 60px;
    }
    #writeMonth, #writeDay{
        width: 35px; 
    }
    #leavePeriodDiv input[type=text]{
        outline: none; border: none; text-align: right; background-color: rgb(247, 245, 245);
    }
    #loaExpense{
        width: 460px; height: 50px; border: none; outline: none;
    }
    #loaExpense::-webkit-inner-spin-button,
    #loaExpense::-webkit-outer-spin-button{
        -webkit-appearance: none; margin: 0;
    }
</style>
<body>
<form id="approvalForm" method="post" action="/edmsSend/loa">
<div class="table-responsive-md">
    <table class="table">
        <tbody>
            <tr class="">
                <td scope="row" style="width: 155px;">제목</td>
                <td>
                    <div class="">
                        <input type="text" class="form-control form-control-sm align-middle" 
                                name="edmsTitle" id="edmsTitle"
                                style="width: 500px;">
                    </div>
                </td>
            </tr>
            <tr class="">
                <td scope="row" style="width: 155px;">결재선지정</td>
                <td>
                    <div class="">
                        <select class="form-select form-select-sm d-inline-block align-middle" 
                        name="selectApprover" id="selectApprover"
                        style="width: 140px;">
                        <option selected hidden>결재자 선택</option>
                        <option value="mid">중간승인자</option>
                        <option value="final">최종승인자</option>
                        </select>
                        <button type="button" class="btn btn-primary btn-sm d-inline-block align-middle"
                                id="btnApprovalLine">선택</button>
                    </div>
                </td>
            </tr>
            <tr>
                <td scope="row" style="width: 155px;">참조</td>
                <td>
                    <div class="">
                        <div id="edmsRef" class="d-inline-block align-middle fs-6" style="width: 465px; height: 62px; padding: 4px 8px; background-color: #fff; outline: 1px solid #ced4da; border-radius: 3px;"></div>
                        <button type="button" class="btn btn-primary btn-sm d-inline-block align-middle"
                            id="btnSelectRef">선택</button>
                    </div>
                    <input type="hidden" id="edmsRefList" name="edmsRefList">
                </td>
            </tr>
        </tbody>
    </table>
</div>
<div class="d-flex justify-content-center" id="templateDocument">
    <table>
        <tr>
            <td style="padding: 0; margin: 0; width: 600px; vertical-align: bottom;">
                <table id="templateLeaveHead" style="width: 600px;">
                    <tr>
                        <td rowspan="2">
                            <div style="padding: 0; margin: 0; width: 334px;">
                                <p style="font-size: 30px;">품의서</p>
                            </div>
                        </td>
                        <td rowspan="2" style="vertical-align: middle">
                            <p>결</p>
                            <p>재</p>
                        </td>
                        <td>작성</td>
                        <td>팀장</td>
                        <td>부서장</td>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" id="writer" name="writer" value="${empName}" readonly>
                            <input type="hidden" id="writerId" name="writerId" value="${empNo}" readonly>
                        </td>
                        <td>
                            <input type="text" id="approverMidName" readonly>
                            <input type="hidden" id="midId" name="midId" readonly>
                        </td>
                        <td>
                            <input type="text" id="approverFinalName" readonly>
                            <input type="hidden" id="finalId" name="finalId" readonly>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="padding: 0; margin: 0; width: 600px; vertical-align: top;">
                <table id="templateLeaveBody" style="width: 600px;">
                    <tr>
                        <td>소속</td>
                        <td>&emsp;${empDepart}</td>
                    </tr>
                    <tr>
                        <td>직위</td>
                        <td>&emsp;${empPosition}</td>
                    </tr>
                    <tr>
                        <td>성명</td>
                        <td>&emsp;${empName}</td>
                    </tr>
                    <tr>
                        <td>작성일</td>
                        <td>
                            <input type="number" id="writeYear" name="writeYear" value="${year}" readonly> 년 
                            <input type="number" id="writeMonth" name="wirteMonth" value="${month}" readonly> 월 
                            <input type="number" id="writeDay" name="writeDay" value="${day}" readonly> 일
                        </td>
                    </tr>
                    <tr>
                        <td>사유</td>
                        <td><textarea id="loaDetail" name="loaDetail"></textarea></td>
                    </tr>
                    <tr>
                        <td>예상비용</td>
                        <td class="text-start">
                            <input type="number" id="loaExpense" name="loaExpense">
                            &nbsp;원
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="border-bottom: none;">
                            <p>위와 같은 사유로 품의서를 제출하오니 허락하여 주시기 바랍니다.</p>
                            <br>
                            <p>
                                <input type="number" id="writeYear" name="writeYear" value="${year}" readonly> 년 
                                <input type="number" id="writeMonth" name="wirteMonth" value="${month}" readonly> 월 
                                <input type="number" id="writeDay" name="writeDay" value="${day}" readonly> 일
                            </p>           
                        </td>
                    </tr>
                    <tr>
                        <td style="border-right: none; border-top: none;"></td>
                        <td style="border-left: none; border-top: none; text-align: end;">
                            <p style="margin-right: 50px;">성명 : ${empName} (인)</p>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>
<div class="d-flex gap-2 mt-5 justify-content-center">
    <button type="submit" name="btnSubmit" id="btnSubmit" class="btn btn-primary">상신</button>
</div>
</form>
<!-- 모달 열기 -->
<button type="button" id="btnOpenModal" class="btn btn-primary btn-sm" data-bs-toggle="modal" 
    data-bs-target="#modalId" style="display: none;">
  Launch
</button>
<!-- 모달 -->
<div class="modal fade" id="modalId" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" role="dialog" aria-labelledby="modalTitleId" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTitle"></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="modalBody">
                <table></table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" 
                    data-bs-dismiss="modal" id="btnModalClose">닫기</button>
                <!-- <button type="button" class="btn btn-primary" id="btnModalConfirm">확인</button> -->
            </div>
        </div>
    </div>
</div>

</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="/js/bootstrap-js/bootstrap.bundle.min.js"></script>
<script>
$(document)
.on("click", "#btnApprovalLine", function(){
    let approvalLine = $("#selectApprover option:selected").val();
    let lineStep = $("#selectApprover option:selected").text();
    console.log(approvalLine);
    if(approvalLine == "mid" || approvalLine == "final"){
        $("#modalTitle").text(lineStep+" 선택");
        $("#btnOpenModal").trigger("click");
        
        $.ajax({
            url: "/edms/emplist",
            type: "post",
            dataType: "json",
            success: (data)=>{
                console.table(data);
                $("#modalBody table").empty();
                data.forEach(el => {
                    let str = "<tr><td><span data-name="+el["empName"];
                    str += " data-id="+el["empNo"]+">";
                    str += "["+el["empDepart"]+"]";
                    str += el["empName"]+" "+el["empPosition"];
                    str += "</span></td></tr>";
                    $("#modalBody table").append(str);
                });
                $("#modalBody span").attr("onclick", "empInfo(this)");
            }
        })
    }else{
        alert("먼저 결재자를 선택해주세요");
        return;
    }
})
.on("submit", "#approvalForm", ()=>{
    if($("#edmsTitle").val().trim()==""){
        alert("제목을 작성해야 합니다.");
        return false;
    }
    if(!confirm("상신 합니까?")) return false;
    let refList = [];
    $("#edmsRef a").each(function(i, el){
        refList.push($(el).data("value"));
    })
    if(refList.length > 0){
        $("#edmsRefList").val(refList);
    }
})
.on("click", "#btnSelectRef", ()=>{
    $.ajax({
            url: "/edms/emplist",
            type: "post",
            dataType: "json",
            success: (data)=>{
                console.table(data);
                $("#modalBody table").empty();
                data.forEach(el => {
                    let str = "<tr><td><span data-name="+el["empName"];
                    str += " data-id="+el["empNo"]+">";
                    str += "["+el["empDepart"]+"]";
                    str += el["empName"]+" "+el["empPosition"];
                    str += "</span></td></tr>";
                    $("#modalBody table").append(str);
                    $("#modalBody span").attr("onclick", "refSelect(this)");
                });
            }, complete: ()=>{
                $("#modalTitle").text("참조자 선택");
                $("#btnOpenModal").trigger("click");
            }
        })
})
function empInfo(ths){
    let selectedApprovalLine = $("#selectApprover option:selected").val();
    if(selectedApprovalLine == "mid"){
        $("#approverMidName").val($(ths).data("name"));
        $("#midId").val($(ths).data("id"));
        $("#btnModalClose").trigger("click");
    }else if(selectedApprovalLine == "final"){
        $("#approverFinalName").val($(ths).data("name"));
        $("#finalId").val($(ths).data("id"));
        $("#btnModalClose").trigger("click");
    }
}
function refSelect(ths){
    let count = 1;
    let flag = true
    $("#edmsRef").find("a").each(function(i, el){
        count += 1;
        if($(el).data("value") == $(ths).data("id")){
            $(el).remove();
            count -= 1;
            flag = false;
            return;
        }
    })
    let a = $("<a>",{ href: "#"}).css("font-size", "12px")
    a.attr("id", "a"+$(ths).data("id"));
    a.attr("data-value",$(ths).data("id"));
    a.text($(ths).text());

    if(flag){
        if(count == 1){
        $("#edmsRef").append(a);
        }else if(count > 1){
            $("#edmsRef").append(a);
        }
    }
}
</script>
</html>