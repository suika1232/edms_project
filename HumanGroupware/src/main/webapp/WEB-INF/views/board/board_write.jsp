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
    <link rel="stylesheet" href="/css/summernote-css/summernote-lite.css">
    <title>글쓰기</title>
</head>
<style>
    h3{
        text-align: center;
    }
    button{
        margin-top: 5px;
        margin-left: 10px;
    }
</style>
<body>
    
    <h3 id="pageTitle"></h3>
    <div class="d-flex justify-content-center">
        <form method="post" action="/boardInsert" id="postForm">
            <input type="hidden" id="flag" name="flag" value="n">
            <input type="hidden" id="boardID" name="boardId" value="${boardId}">
            <input type="hidden" id="boardCategory" name="boardCategory">
            <table>
                <tr>
                    <td>제목</td>
                    <td>
                        <input class="form-control" type="text" id="boardTitle" 
                            name="boardTitle" required autofocus>
                    </td>
                </tr>
                <tr>
                    <td>내용</td>
                    <td>
                        <textarea id="boardContent" name="boardContent" hidden></textarea>
                        <div id="boardEditor"></div>
                    </td>
                </tr>
            </table>
            <div class="d-flex justify-content-end">
                <button class="btn btn-primary" type="reset" id="btnReset">취소</button>
                <button class="btn btn-primary" type="submit" id="btnSubmit">저장</button>
            </div> 
        </form>
    </div>
    
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="/js/bootstrap-js/bootstrap.bundle.min.js"></script>
<script src="/js/summernote-js/summernote-lite.js"></script>
<script src="/js/summernote-js/lang/summernote-ko-KR.js"></script>
<script>
$(document)
.ready( ()=>{
    let category = "${category}";
    if(category == "notice") {
        $("#boardCategory").val("notice");
        $("#pageTitle").text("공지작성");
    }
    else {
        $("#boardCategory").val("free");
        $("#pageTitle").text("게시글작성")
    }
    console.log("카테고리:"+$("#boardCategory").val());

    $("#boardEditor").summernote({
        height: 400,
        toolbar: [
            ['style', ['bold', 'italic', 'underline', 'clear']],
            ['font', ['strikethrough', 'superscript', 'subscript']],
            ['fontsize', ['fontsize']],
            ['color', ['color']],
            ['para', ['ul', 'ol', 'paragraph']],
            ['height', ['height']]
        ],
        lang: "ko-KR",
        placeholder: "내용을 입력하세요"
    })
    let flag = '<%=(String)request.getAttribute("flag")%>';
    console.log("flag:"+flag);
    if(flag == "y"){
        $("#boardTitle").val('<%=(String)request.getAttribute("boardTitle")%>');
        $("#boardEditor").summernote("code", '<%=(String)request.getAttribute("boardContent")%>');
        $("#flag").val("y");
    }

})
.on("submit", "#postForm", ()=>{
    let content = $("#boardEditor").summernote("code");
    $("#boardContent").val(content);
})
.on("click" ,"#btnReset", ()=>{
    document.location="/board/"+$("#boardCategory").val();
})
</script>
</html>