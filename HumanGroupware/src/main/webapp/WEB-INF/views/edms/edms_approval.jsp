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
    <title>approval</title>
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
    #approverName {
        border: none; outline: none;
    }
    #modalBody table td:first-child{
        width:80px;
    }
    .displayNone{
        display: none;
    }
    #edmsInfoTable input[type=text]{
        border: none; outline: none;
    }
    .signNamePosition{
        position: relative;
        top: 24px;
    }
    .signImg{
        width: 50px;
        height: 50px;
        opacity: 0.6;
        margin: 0 0;
        position: relative;
        bottom: 15px;
    }
</style>
<body>
<input type="hidden" id="loginUser" value="${loginUser.emp_no}">
<input type="hidden" id="edmsStep" value="${edmsStep}">
<div class="table-responsive-md">
    <table class="table" id="edmsInfoTable">
        <tbody>
            <tr class="">
                <td scope="row" style="width: 155px;">번호</td>
                <td>
                    <input type="text" id="edmsId" value="${edmsId}" readonly>
                </td>
            </tr>
            <tr>
                <td scope="row" style="width: 155px;">분류</td>
                <td>
                    <input type="text" id="edmsCategory" value="${edmsCategory}" readonly>
                </td>
            </tr>
            <tr class="">
                <td scope="row" style="width: 155px;">제목</td>
                <td>${edmsTitle}</td>
            </tr>
            <tr class="">
                <td scope="row" style="width: 155px;">기안일</td>
                <td>${edmsDate}</td>
            </tr>
            <tr class="">
                <td scope="row" style="width: 155px;">상태</td>
                <td>
                    <input type="text" id="edmsStatus" value="${edmsStatus}" readonly>
                </td>
            </tr>
            <% 
                String edmsStatus = (String)request.getAttribute("edmsStatus");
                if(edmsStatus.equals("반려")){ %>
            <tr>
                <td scope="row" style="width: 155px;">사유</td>
                <td>
                    <%=request.getAttribute("edmsReason")%>
                </td>
            </tr>

            <%  } %>
        </tbody>
    </table>
</div>
<% String edmsCategory = (String)request.getAttribute("edmsCategory"); %>
<div class="d-flex justify-content-center" id="templateDocument">
    <table>
        <tr>
            <td style="padding: 0; margin: 0; width: 600px; vertical-align: bottom;">
                <table id="templateLeaveHead" style="width: 600px;">
                    <tr>
                        <td rowspan="2">
                            <div style="padding: 0; margin: 0; width: 334px;">
                                <% if(edmsCategory.equals("휴가")){ %>
                                <p style="font-size: 30px;">휴가신청서</p>
                                <% }else{ %>
                                <p style="font-size: 30px;">품의서</p>
                                <% } %>
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
                            
                            <input type="text" id="writer" name="writer" value="${empName}" class="signNamePosition" readonly>
                            <img src="/img/확인.png" class="signImg">
                            <input type="hidden" id="writerId" name="writerId" value="${empNo}" readonly>
                        </td>
                        <td>
                            <input type="text" id="approverMidName" value="${midName}" readonly>
                            <input type="hidden" id="midId" value="${midId}" readonly>
                            <input type="hidden" id="midCheck" value="${midCheck}" readonly>
                        </td>
                        <td>
                            <input type="text" id="approverFinalName" value="${finalName}" readonly>
                            <input type="hidden" id="finalId" value="${finalId}" readonly>
                            <input type="hidden" id="finalCheck"  value="${finalCheck}" readonly>
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
                    <% if(edmsCategory.equals("휴가")){ %>
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
                        <td style="font-size: 14px; text-align: center;">
                            <div id="leavePeriodDiv" class="text-start d-inline-block">
                                <% 
                                    String startDate = (String)request.getAttribute("leaveStart");
                                    String endDate = (String)request.getAttribute("leaveEnd");
                                    String[] startArr = startDate.split("-");
                                    String[] endArr = endDate.split("-");
                                %>
                                <%=startArr[0]+"년 "+startArr[1]+"월 "+startArr[2]+" 일 부터" %>
                                &nbsp;~&nbsp;
                                <%=endArr[0]+"년 "+endArr[1]+"월 "+endArr[2]+" 일 까지" %>
                                &nbsp;${leavePeriod}일간
                            </div>
                        </td>
                    </tr>
                    <% }else{ %>
                    <% String date = (String)request.getAttribute("edmsDate");
                       String[] dateAr = date.split("-"); %>
                    <tr>
                        <td>작성일</td>
                        <td class="text-start">
                            &nbsp;
                            <%=dateAr[0]%>&nbsp;년 
                            <%=dateAr[1]%>&nbsp;월  
                            <%=dateAr[2]%>&nbsp;일 
                        </td>
                    </tr>
                    <% } %>
                    <tr>
                        <td>사유</td>
                        <td><textarea id="edmsDetail" name="edmsDetail" readonly>${detail}</textarea></td>
                    </tr>
                    <% if(edmsCategory.equals("품의")){ %>
                    <tr>
                        <td>예상비용</td>
                        <td class="text-start">
                            &nbsp;${loaExpense}&nbsp;원
                        </td>
                    </tr>
                    <% } %>
                    <tr>
                        <td colspan="2" style="border-bottom: none;">
                            <br>
                            <%if(edmsCategory.equals("휴가")){ %>
                            <p>위와 같이 휴가를 신청하오니 허락하여 주시기 바랍니다.</p>
                            <% }else{ %>
                            <p>위와 같은 사유로 품의서를 제출하오니 허락하여 주시기 바랍니다.</p>
                            <% } %>
                            <br>
                            <p>
                                <% 
                                    String edmsDate = (String)request.getAttribute("edmsDate");
                                    String[] edmsArr = edmsDate.split("-");
                                %>
                                <%=edmsArr[0]+"년 "+edmsArr[1]+"월 "+edmsArr[2]+" 일" %>
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
        <tr>
            <td>
                <div class="d-flex gap-2 mb-5 mt-3 justify-content-end">
                    <button type="button" id="btnReturn" class="btn btn-primary">뒤로</button>
                    <button type="button" id="btnOpenModal" class="btn btn-primary" data-bs-toggle="modal" 
                    data-bs-target="#modalId" disabled>결재</button>
                </div>
            </td>
        </tr>
    </table>
</div>
<div class="modal fade" id="modalId" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" role="dialog" aria-labelledby="modalTitleId" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-md" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title" id="modalTitle">결재처리</h6>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="modalBody">
                <div class="table table">
                    <table style="width: inherit; border-color: lightgray; height: 200px;">
                        <tr>
                            <td scope="row">결재자</td>
                            <td><input type="text" class="form-control form-control-sm"
                                     id="approverName" value="[${loginUser.dep_name}] ${loginUser.emp_name} ${loginUser.position_name}" readonly></td>
                        </tr>
                        <tr>
                            <td scope="row">결재처리</td>
                            <td>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" 
                                        name="approvalCheck" id="checkConfirm" value="승인">
                                    <label class="form-check-label" for="checkConfirm">승인</label>
                                  </div>
                                  <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" 
                                        name="approvalCheck" id="checkReject" value="반려">
                                    <label class="form-check-label" for="checkReject">반려</label>
                                  </div>
                            </td>
                        </tr>
                        <tr>
                            <td scope="row">처리내용</td>
                            <td>
                                <input type="text"
                                    class="form-control form-control-sm"
                                    id="approverOpinion" placeholder="처리내용 입력">
                            </td>
                        </tr>
                        <!-- <tr>
                            <td scope="row">전결처리</td>
                            <td><input type="checkbox" id=""></td>
                        </tr> -->
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="btnConfirm">확인</button>
            </div>
        </div>
    </div>
</div>

</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="/js/bootstrap-js/bootstrap.bundle.min.js"></script>
<script>
$(document)
.ready(()=>{
    let edmsCategory = $("#edmsCategory").val();
    console.log("문서 카테고리: "+edmsCategory)
    if(edmsCategory == "휴가"){
        let leaveCategory = '<%=(String)request.getAttribute("leaveCategory")%>';
        console.log(leaveCategory);
        $("input[name=leaveCategory]").each(function(i, el){
            if($(el).val() != leaveCategory){
                $(el).attr("disabled", true);
            }else $(el).prop("checked", true);
        })
        $("#templateLeaveBody > tbody > tr:nth-child(6) > td:nth-child(2)")
        .css("height", "200px");
    
    }else if(edmsCategory == "품의"){
        $("#templateLeaveBody > tbody > tr:nth-child(7) > td")
        .css("height", "55px");
    }
    let loginUser = '<%=(int)session.getAttribute("emp_no")%>';
    console.log(loginUser);
    if($("#edmsStatus").val() == "결재대기"){
        if(loginUser == $("#midId").val() || loginUser == $("#finalId").val()){
        $("#btnOpenModal").attr("disabled", false);
        }
    }
    approverSign($("#midCheck"));
    approverSign($("#finalCheck"));
    
    $("#modalBody table tr:nth-child(3)").addClass("displayNone");
})
.on("change", "input[name=approvalCheck]", function(){
    if($(this).is(":checked") && $(this).attr("id") == "checkReject"){
        $("#modalBody table tr:nth-child(3)").removeClass("displayNone");
    }else{
        $("#modalBody table tr:nth-child(3)").addClass("displayNone");
    }
})
.on("click", "#btnReturn", ()=>{
    document.location="/edms/list";
})
.on("click", "#btnConfirm", ()=>{

    let approver = $("#loginUser").val();
    console.log(approver);
    let receive = $("input[name=approvalCheck]:checked").val();
    console.log(receive);
    let reason = $("#approverOpinion").val();
    console.log(reason);

    $.ajax({
        url: "/edms/approval/"+$("#edmsId").val(),
        type: "post",
        data:{approver: approver, receive: receive, reason: reason},
        dataType: "text",
        success: (data)=>{
            if(data == "complete") alert("결재 처리 완료");
            else alert("결재 도중 오류가 발생했습니다.");
            $("#btnReturn").trigger("click");
        }
    })
})
function approverSign(approverCheck){
    let check = $(approverCheck).val();
    let id = $(approverCheck).attr("id");
    console.log(check)
    console.log(id);

    if(check == "y"){
        let signImg = $("<img>",{
            src: "/img/확인.png"
        }).css({
            width: "50px",
            height: "50px",
            opacity: "0.6",
            margin: "0 0",
            position: "relative",
            bottom: "15px"
        })
        $(approverCheck).before(signImg);
        if(id == "midCheck"){
            $("#approverMidName").addClass("signNamePosition");
        }else if(id == "finalCheck"){
            $("#approverFinalName").addClass("signNamePosition");
        }
    }
}
</script>
</html>