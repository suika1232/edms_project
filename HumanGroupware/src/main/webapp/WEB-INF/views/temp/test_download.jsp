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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <title>파일 업/다운로드 테스트</title>
</head>
<body>
    <form class="d-flex flex-column container  w-25 mt-5"
        method="post" action="/testupload" enctype="multipart/form-data">
        <div class="row">
            <div class="col mb-3 justify-content-center">
                <input type="file" class="form-control form-control-sm" name="fileUpload" id="fileUpload" aria-describedby="fileHelpId">
                <div id="fileHelpId" class="form-text">테스트용 업로드</div>
            </div>
        </div>
        <div class="row">
            <div class="col mb-3 justify-content-end">
                <button type="submit" class="btn btn-primary btn-sm" id="btnSubmit">전송</button>
            </div>
        </div> 
    </form>

    <div class="d-flex flex-column container w-25 mt-5">
        <div class="row">
            <div class="col">
                <a href="/test/filedownload">파일 다운로드</a>
            </div>
        </div>
    </div>
    
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="/js/bootstrap-js/bootstrap.bundle.min.js"></script>
<script>
$(document)
</script>
</html>