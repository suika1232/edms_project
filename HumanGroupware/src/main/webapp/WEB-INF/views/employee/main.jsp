<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link type="text/css" rel="stylesheet" href="/resources/css/hwMain.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<title>hwMain</title>
</head>
<body>
	<div class="container_right1">
		<div class="detail_container1">
			<div class="board_box1">
				<div id="board_title1">공지사항</div>
				<div id="board_notice"></div>
			</div>
		</div>
	</div>
	<div class="container_right2">
		<div class="detail_container2">
			<div class="board_box2">
				<div id="board_title2">자유 게시판</div>
				<div id="board_free"></div>
			</div>
		</div>
	</div>
	<div class="container_right3">
		<div class="Work_box">
			<div id="Work_title">업무</div>
			<div id="Work"></div>
		</div>
	</div>
</body>
<script src='https://code.jquery.com/jquery-latest.js'></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
$(document)
.ready(function(){
	FreeList();
	NoticeList();
})
//메인페이지에서 자유게시판 내용을 가져오는 기능입니다.
function FreeList() {
	$.ajax({
    	url: '/Board_Free',
    	data: {},
    	dataType: 'json',
    	type: 'post',
    	success: function(data) {
      	if (data.length == 0) {
        	console.log('No data');
        	return false;
      	}
      	for (let i = 0; i < Math.min(data.length, 5); i++) {
        	let free = "<tr><td><a href='/board/view/" + data[i]["board_id"] + "'>" 
        	+ data[i]["board_title"] + "</a></td>" +
          	"<td>" + data[i]["emp_name"] + "</td>" +
          	"<td>" + data[i]["board_created"] + "</td></tr>";
        	$('#board_free').append(free);
      		}
    	}
  	})
}
//메인페이지에서 공지사항 내용을 가져오는 기능입니다.
function NoticeList() {
	$.ajax({
		url:'/Board_Notice',
		data: {},
		dataType: 'json',
		type: 'post',
		success:function(data){
			if(data.length == 0){
				console.log('NO Data');
				return false;
			}
			for(let i=0; i< Math.min(data.length, 5); i++){
				let notice = "<tr><td><a href='/board/view/" + data[i]["board_id"] + "'>"
				+ data[i]["board_title"] + "</a></td>" +
				"<td>" + data[i]["emp_name"] + "</td>" +
	          	"<td>" + data[i]["board_created"] + "</td></tr>";
	          	$('#board_notice').append(notice);
			}
		}
	})
}
</script>
</html>