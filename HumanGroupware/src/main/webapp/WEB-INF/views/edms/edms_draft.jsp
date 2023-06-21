<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
    <link rel="stylesheet" href="/css/bootstrap-css/bootstrap.min.css">
    <title>기안작성</title>
</head>
<style>
</style>
<body>
<div class="container-fluid">
    <div class="">
        <table class="table">
            <tbody>
                <tr class="">
                    <td scope="row" style="width: 155px; height: 50px;">구분</td>
                    <td>
                        <div class="">
                            <select class="form-select form-select-sm" 
                                name="selectTemplate" id="selectTemplate"
                                style="width: 140px;">
                                <option selected hidden>양식선택</option>
                                <option value="leave">휴가신청서</option>
                                <option value="loa">품의서</option>
                            </select>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="d-flex">
        <iframe id="templateView" src="" frameborder="0" style="width: 100%; height: 90vh;"></iframe>
    </div>
</div>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="/js/bootstrap-js/bootstrap.bundle.min.js"></script>
<script>
$(document)
.on("change", "#selectTemplate", ()=>{
    let selected = $("#selectTemplate").find("option:selected").val();
    console.log(selected);
    $("#templateView").attr("src", "/edms/template/"+selected);
})
</script>
</html>