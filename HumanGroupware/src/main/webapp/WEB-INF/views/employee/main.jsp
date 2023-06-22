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
			<div id="Work">
			</div>
		</div>
	</div>
	<div class="container_right4">
  		<div class="commute_box">
    		<div class="commute_title">출퇴근</div>
    		<div class="commute">
      			<input type=hidden id="name_input">
      			<input type=hidden id="id_value">
      			<button id="start_id">출근</button>
      			<button id="end_id">퇴근</button>
    		</div>
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
	TaskList();
	var now = new Date();
	var year = now.getFullYear();
	var month = ('0'+(now.getMonth()+1)).slice(-2);
	var date = ('0'+(now.getDate())).slice(-2);
	var fulldate = (year+'-'+month+'-'+date);
	var hr = ('0'+now.getHours()).slice(-2);
	var min = ('0'+now.getMinutes()).slice(-2);
	var sec = ('0'+now.getSeconds()).slice(-2);
	var time1 = (hr+min+sec);
	var time = parseInt(time1);
	// 현재날짜
	$('#name_input').val(fulldate);
	// param 값 ( 퇴근 )
	var param = 0;
	// 야근시간
	var timeEnd = 0;
})
.ready(function(){
	loadatt_id();
})
/* 출근 */
$('#start_id').on('click',function(){
	loadattdance_chack();
})
   
/* 퇴근 */
$('#end_id').on('click', function(){
     // 현재 시간 ( 퇴근 )
     let now = new Date();
     let year = now.getFullYear();
     let month = ('0'+(now.getMonth()+1)).slice(-2);
     let date = ('0'+(now.getDate())).slice(-2);
     let fulldate = (year+'-'+month+'-'+date);
     let hr = ('0'+now.getHours()).slice(-2);
     let min = ('0'+now.getMinutes()).slice(-2);
     let sec = ('0'+now.getSeconds()).slice(-2);
     let time1 = (hr+min+sec);
     time = parseInt(time1);
     if(time < 175000){
         // 조퇴
         param = 2;
         timeEnd = 0;
         loadEnd_time();
     }else if( time > 182000){
         // 야근
         param = 3;
         timeEnd = time-110000;
         timeEnd = '0'+timeEnd;
         loadEnd_time();
     }else {
         // 정상 퇴근
         param = 1;
         timeEnd = 0;
         loadEnd_time();
     }
  })
// 사원 번호 불러오기 ( select )
function loadatt_id(){
   	$.ajax({url:'/id_load_select',
          	type:'post',
          	dataType:'json',
          	data:{emp_id:'${emp_id}'},
          	success:function(data){
             	for(let i=0; i<data.length; i++){
                	id = data[i];
                	let emp_no = id['emp_no'];
                	$('#id_value').val(emp_no);
                	console.log(emp_no);
                }
	}}
	)
}  
// 정상 퇴근
function loadEnd_time(){
    $.ajax({url:'/attendance_end_id',
          	type:'post',
          	dataType:'text',
          	data:{emp_no:$('#id_value').val(),
                  param: param,
                  night_time: timeEnd},
          	success:function(data){
             	if(data=='ok'){
                	var result = confirm("퇴근하시겠습니까?")
                	if(!result){
                   		alert('취소되었습니다.');
                   		return false;
                	} else{
                   		alert('퇴근등록 되었습니다.');
                	}
             	} else{
                	alert("오류");
             	}}
		})
	}
//출근 1회 제한
function loadattdance_chack(){
   	$.ajax({url:'/attendance_chack',
          	type:'post',
          	dataType:'json',
          	data:{emp_no: $('#id_value').val(),
                  attend_date:$('#name_input').val(),
                  emp_id:'${emp_id}'},
   			success:function(data){
      			if(data == 1){
         			alert("현재 출근 상태입니다.");   
      			} else if (data == 0){
         			alert("출근 등록 처리중입니다.");
         			loadChack();
      			}
   			}
   		})
   }
//출근 등록
function loadChack(){
      	$.ajax({url:'/attendance_start_id',  
         	type:'post', 
         	dataType:'text',
         	data:{emp_no:$('#id_value').val()},
         	success:function(data){
            	if(data=='ok'){
               		alert(' 정상 출근 등록되었습니다.');
            	} else{
               		alert("오류");
            	}
         }
   	})
}
//메인페이지에서 자유게시판 내용을 가져오는 기능입니다.
function FreeList() {
	$.ajax({
    	url: '/Board_Free',
    	data: {},
    	dataType: 'json',
    	type: 'post',
    	success: function(data) {
      	if (data.length == 0) {
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
  	$.ajax({
      url: '/Main_Session',
      data: {emp_id: $('#emp_id').val()},
      dataType: 'text',
      type: 'post',
      success: function(data){
        if (data == 'ok') {
          
        } else {
        	let loginMessage = "<tr><td colspan='3' id='NotLogin'>로그인 후 보실 수 있습니다.</td></tr>";
            $('#board_free').append(loginMessage);
        }
      },
      error: function(jqXHR, textStatus, errorThrown) {
        console.log('Error: ' + textStatus);
        console.log('Error Detail:', errorThrown);
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
	$.ajax({
      url: '/Main_Session',
      data: {emp_id: $('#emp_id').val()},
      dataType: 'text',
      type: 'post',
      success: function(data){
        if (data == 'ok') {
          
        } else {
        	let loginMessage = "<tr><td colspan='3' id='NotLogin'>로그인 후 보실 수 있습니다.</td></tr>";
            $('#board_notice').append(loginMessage);
        }
      },
      error: function(jqXHR, textStatus, errorThrown) {
        console.log('Error: ' + textStatus);
        console.log('Error Detail:', errorThrown);
      }
    })
}
//메인페이지에서 업무 내용을 가져오는 기능입니다.
function TaskList() {
	let type = "R_Task"
	$.ajax({
		url: '/Main_Task',
		dataType: 'json',
		type: 'post',
		success: function (data) {
			if (data.length == 0) {
				return false;
			}
			for (let i = 0; i < Math.min(data.length, 5); i++) {
				let work = '<tr><td>' + data[i].task_name + '</td>' +
					'<td>' + data[i]["emp_name"] + '</td>' +
					"<td><a href='/detail/" + type + "/" + data[i]["task_id"] +"/"+ data[i]["emp_no"] + "'>"
					+ data[i].task_content + "</a></td>" +
					'<td>' + data[i]["task_started"] + ' ~<br>' + data[i]["task_limit"] + '</td>'
					+ '</tr>';
				$('#Work').append(work);
			}
			
		}
	})
	$.ajax({
	      url: '/Main_Session',
	      data: {emp_id: $('#emp_id').val()},
	      dataType: 'text',
	      type: 'post',
	      success: function(data){
	        if (data == 'ok') {
	          
	        } else {
	        	let loginMessage = "<tr><td colspan='3' id='NotLogin'>로그인 후 보실 수 있습니다.</td></tr>";
	            $('#Work').append(loginMessage);
	        }
	      },
	      error: function(jqXHR, textStatus, errorThrown) {
	        console.log('Error: ' + textStatus);
	        console.log('Error Detail:', errorThrown);
	      }
	    })
}
</script>
</html>