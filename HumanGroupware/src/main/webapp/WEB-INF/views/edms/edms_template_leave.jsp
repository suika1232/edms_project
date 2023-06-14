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
    #templateLeaveBody > tbody > tr:nth-child(6) > td:nth-child(2){
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
</style>
<body>
<div class="table-responsive-md">
    <table class="table">
        <tbody>
            <tr class="">
                <td scope="row" style="width: 155px;">제목</td>
                <td>
                    <div class="">
                        <input type="text" class="form-control form-control-sm" 
                                name="edmsTitle" id="edmsTitle"
                                style="width: 500px;">
                    </div>
                </td>
            </tr>
            <tr class="">
                <td scope="row" style="width: 155px;">결재선지정</td>
                <td>
                    <div class="">
                        <select class="form-select form-select-sm d-inline-block" 
                        name="selectApprover" id="selectApprover"
                        style="width: 140px;">
                        <option selected hidden>결재자 선택</option>
                        <option value="mid">중간승인자</option>
                        <option value="final">최종승인자</option>
                        </select>
                        <button type="button" class="btn btn-primary btn-sm d-inline-block"
                                id="btnApprovalLine">선택</button>
                    </div>
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
                                <p style="font-size: 30px;">휴가신청서</p>
                            </div>
                        </td>
                        <td rowspan="2" style="vertical-align: middle">
                            <p>결</p>
                            <p>재</p>
                        </td>
                        <td>작성</td>
                        <td>팀장</td>
                        <td>파트장</td>
                    </tr>
                    <tr>
                        <td>${empName}</td>
                        <td><btn></td>
                        <td></td>
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
                        <td>구분</td>
                        <td>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" 
                                    name="leaveCategory" id="leaveCategory1" value="연차">
                                <label class="form-check-label" for="leaveCategory1">연차</label>
                            </div>
                              <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" 
                                    name="leaveCategory" id="leaveCategory2" value="반차">
                                <label class="form-check-label" for="leaveCategory2">반차</label>
                            </div>
                              <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" 
                                    name="leaveCategory" id="leaveCategory3" value="병가">
                                <label class="form-check-label" for="leaveCategory3">병가</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" 
                                    name="leaveCategory" id="leaveCategory4" value="공가">
                                <label class="form-check-label" for="leaveCategory4">공가</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" 
                                    name="leaveCategory" id="leaveCategory5" value="기타">
                                <label class="form-check-label" for="leaveCategory5">기타</label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>일시</td>
                        <td style="font-size: 12px; text-align: center;">
                            <div class="text-start d-inline-block">
                                <input type="text"> 년 
                                <input type="text"> 월 
                                <input type="text"> 일부터
                                <br>~<br>
                                <input type="text"> 년 
                                <input type="text"> 월 
                                <input type="text"> 일까지 
                                &lt;<span id="vacDays"></span> 일간&gt;
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>사유</td>
                        <td><textarea id="vacReason"></textarea></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="border-bottom: none;">
                            <p>위와 같이 휴가를 신청하오니 허락하여 주시기 바랍니다.</p>
                            <br>
                            <p>${year} 년 ${month} 월 ${day} 일</p>           
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
    <button type="button" name="btnSubmit" id="btnSubmit" class="btn btn-primary">상신</button>
</div>
<!-- Modal trigger button -->
<button type="button" id="btnOpenModal" class="btn btn-primary btn-sm" data-bs-toggle="modal" 
    data-bs-target="#modalId" style="display: none;">
  Launch
</button>

<!-- Modal Body -->
<!-- if you want to close by clicking outside the modal, delete the last endpoint:data-bs-backdrop and data-bs-keyboard -->
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
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary">확인</button>
            </div>
        </div>
    </div>
</div>

</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="/js/bootstrap-js/bootstrap.bundle.min.js"></script>
<script>
$(document)
.on("click", "#btnApprovalLine", ()=>{
    let approvalLine = $("#selectApprover option:selected").val();
    let lineStep = $("#selectApprover option:selected").text();
    console.log(approvalLine);
    if(approvalLine == "mid" || approvalLine == "final"){
        $("#modalTitle").text(lineStep+" 선택");
        $("#btnOpenModal").trigger("click");
        
        $.ajax({
            url: "/edms/emplist",
            type: "post",
            data:{},
            dataType: "json",
            success: (data)=>{
                console.table(data);
                $("#modalBody table").empty();
                data.forEach(el => {
                    let str = "<tr><td><span data-value='"+el["empNo"]+"'>";
                    str += "["+el["empDepart"]+"]";
                    str += el["empName"]+" "+el["empPosition"];
                    str += "</span></td></tr>";
                    $("#modalBody table").append(str);
                });
                $("#modalBody span").attr("onclick", "empInfo(this)");
            }
        })
    }
})
function empInfo(ths){
    let selectApprover = $(ths).data("value");
    console.log(selectApprover);
}
</script>
</html>