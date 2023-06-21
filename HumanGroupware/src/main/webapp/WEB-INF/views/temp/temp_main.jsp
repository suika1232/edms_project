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
	<div class="title_container">
		<div class=title_box1><a href="/temp/temp_main">Human<br>GroupWare</a></div>
		<div class=title_box2></div>
		<div class=title_box3>
		<div class="gap"></div>
			사원 찾기<br><input type=text id=Search_Emp placeholder="Search.." size=8>
			<button id=Search_EmpBtn>
				<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  				<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
				</svg>
			</button>
		</div>
	</div>
	<!-- 사원찾기 dialog -->
	<div class="emp_dialog" id="emp_dialog" style="display:none">
		<div class="emp_info" id="emp_info"></div>
	</div>
	<div class="container-left">
		<div class="Mysession_container">
			<div id="MY_box">
  				<% if(session.getAttribute("emp_id") != null && session.getAttribute("emp_id")!="") { %>
    					<img id="emp_img">
    					<div id="emp_name"></div>
    					<div id="emp_position"></div>
    					<div id="emp_depart"></div>
    			<div id="My_box1">
      				<a href='/employee/mypage'>마이페이지</a>
      				<a href='/employee/logout'>로그아웃</a>
    			</div>
  				<% } else { %>
    				로그인 후 <br>이용해주세요!
    				<div class="My_box2">
      					&nbsp;<a href='/employee/login'>로그인</a>
      					<a href="/employee/signin">회원가입</a><br>
    				</div>
  				<% } %>
			</div>
		</div>
		<div class="Category_container">
			<div id="Category_box1">
  				<svg id="box1" xmlns="http://www.w3.org/2000/svg" width="50" height="100" fill="currentColor" class="bi bi-chat-left-dots-fill" viewBox="0 0 16 16">
    				<path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H4.414a1 1 0 0 0-.707.293L.854 15.146A.5.5 0 0 1 0 14.793V2zm5 4a1 1 0 1 0-2 0 1 1 0 0 0 2 0zm4 0a1 1 0 1 0-2 0 1 1 0 0 0 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"/>
  				</svg>
  				<div id="linkContainer">
    				<a href="/New" id='newMsg'>새로 쓰기</a>
    				<a href="/receive" id='receive'>받은 편지함</a>
    				<a href="/send" id='send'>보낸 편지함</a>
    				<a href="/tom" id='tom'>휴지통</a>
  			  </div>
		  </div>
		<div id="Category_box2">
			<svg xmlns="http://www.w3.org/2000/svg" width="50" height="100" fill="currentColor" class="bi bi-clipboard2-check-fill" viewBox="0 0 16 16">
  				<path d="M10 .5a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5.5.5 0 0 1-.5.5.5.5 0 0 0-.5.5V2a.5.5 0 0 0 .5.5h5A.5.5 0 0 0 11 2v-.5a.5.5 0 0 0-.5-.5.5.5 0 0 1-.5-.5Z"/>
  				<path d="M4.085 1H3.5A1.5 1.5 0 0 0 2 2.5v12A1.5 1.5 0 0 0 3.5 16h9a1.5 1.5 0 0 0 1.5-1.5v-12A1.5 1.5 0 0 0 12.5 1h-.585c.055.156.085.325.085.5V2a1.5 1.5 0 0 1-1.5 1.5h-5A1.5 1.5 0 0 1 4 2v-.5c0-.175.03-.344.085-.5Zm6.769 6.854-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708.708Z"/>
			</svg>
			<div id="linkContainer2">
        <a href="/edms/draft" id='draft'>기안하기</a>
				<a href="/edms/list" id='list'>결재목록</a>
        <a href="/edms/reject" id='reject'>반려문서함</a>
			</div>
		</div>
		<div id="Category_box3">
			<svg xmlns="http://www.w3.org/2000/svg" width="50" height="100" fill="currentColor" class="bi bi-people-fill" viewBox="0 0 16 16">
  				<path d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1H7Zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Zm-5.784 6A2.238 2.238 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.325 6.325 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1h4.216ZM4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5Z"/>
			</svg>
			<div id="linkContainer3">
				<a href="/board/free" id='free'>자유 게시판</a>
				<a href="/board/notice" id='notice'>공지사항</a>
			</div>
		</div>
		<div id="Category_box4">
			<svg xmlns="http://www.w3.org/2000/svg" width="50" height="100" fill="currentColor" class="bi bi-journal-text" viewBox="0 0 16 16">
  				<path d="M5 10.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z"/>
  				<path d="M3 0h10a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-1h1v1a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v1H1V2a2 2 0 0 1 2-2z"/>
  				<path d="M1 5v-.5a.5.5 0 0 1 1 0V5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0V8h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0v.5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1z"/>
			</svg>
			<div id="linkContainer4">
			<%int position=0; %>
			<%if(session.getAttribute("emp_id")!=null) {%>
			
			 <% position = (int)session.getAttribute("emp_position"); %>
			<%} %>
			<%if (position>1){ %>  
				<a href="/MyWorkLog">작성한 일지</a>
				<a href="/depWorkLog">부서일지</a>
				<a href="/WorkLog">일지 작성</a>
				<a href="/Taskhome">받은 업무보고</a>
				<a href="/requestTask">작성한 업무</a>
				<a href="/writeReport">업무 작성</a>
			<%}else{%>
				<a href="/MyWorkLog">작성한 일지</a>
				<a href="/WorkLog">일지 작성</a>
				<a href="/Taskhome">보고한 업무</a>
				<a href="/requestTask">지시받은 업무</a>
				<a href="/writeReport">업무보고서 작성</a>
			<%} %> 
			</div>
		</div>
		<div id="Category_box5">
			<svg xmlns="http://www.w3.org/2000/svg" width="50" height="100" fill="currentColor" class="bi bi-person-gear" viewBox="0 0 16 16">
  				<path d="M11 5a3 3 0 1 1-6 0 3 3 0 0 1 6 0ZM8 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4Zm.256 7a4.474 4.474 0 0 1-.229-1.004H3c.001-.246.154-.986.832-1.664C4.484 10.68 5.711 10 8 10c.26 0 .507.009.74.025.226-.341.496-.65.804-.918C9.077 9.038 8.564 9 8 9c-5 0-6 3-6 4s1 1 1 1h5.256Zm3.63-4.54c.18-.613 1.048-.613 1.229 0l.043.148a.64.64 0 0 0 .921.382l.136-.074c.561-.306 1.175.308.87.869l-.075.136a.64.64 0 0 0 .382.92l.149.045c.612.18.612 1.048 0 1.229l-.15.043a.64.64 0 0 0-.38.921l.074.136c.305.561-.309 1.175-.87.87l-.136-.075a.64.64 0 0 0-.92.382l-.045.149c-.18.612-1.048.612-1.229 0l-.043-.15a.64.64 0 0 0-.921-.38l-.136.074c-.561.305-1.175-.309-.87-.87l.075-.136a.64.64 0 0 0-.382-.92l-.148-.045c-.613-.18-.613-1.048 0-1.229l.148-.043a.64.64 0 0 0 .382-.921l-.074-.136c-.306-.561.308-1.175.869-.87l.136.075a.64.64 0 0 0 .92-.382l.045-.148ZM14 12.5a1.5 1.5 0 1 0-3 0 1.5 1.5 0 0 0 3 0Z"/>
			</svg>
			<div id="linkContainer5">
				<a href="/employee/inquiry" id='inquiry'>사원 조회</a>
				<a href="/employee/registration" id='registration'>사원 부서 변경</a>
				<a href="/employee/organization" id='organization'>조직도</a>
				<a href="/attendance/current" id='current'>사원 근태 현황</a>
			</div>
		</div>
		<div id="Category_box6">
			<svg xmlns="http://www.w3.org/2000/svg" width="50" height="100" fill="currentColor" class="bi bi-calendar-week-fill" viewBox="0 0 16 16">
  			<path d="M4 .5a.5.5 0 0 0-1 0V1H2a2 2 0 0 0-2 2v1h16V3a2 2 0 0 0-2-2h-1V.5a.5.5 0 0 0-1 0V1H4V.5zM16 14V5H0v9a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2zM9.5 7h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5zm3 0h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5zM2 10.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1zm3.5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5z"/>
			</svg>
			<!-- <div id="linkContainer6">
				<a href="/?/?">(일정)아직 구현중..</a>
			</div> -->
		</div>
	</div>
	</div>
	<div class="col float-md-end video-warp" style="height: 1000px;">
		<iframe id="View" src="/employee/main" style="height: 100%;"></iframe>
  </div>
</body>
<script src='https://code.jquery.com/jquery-latest.js'></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
$(document)
.ready(function(){
	MainList();
})
// //편지 새로 쓰기
// .ready(function(){
//   $('#newMsg').click(function(event){
//     event.preventDefault(); // 기본 동작 방지

//     let $this = $(this); // 클릭된 요소 저장
//     let href = $this.attr('href');

//     $.ajax({
//       url: '/Main_Session',
//       data: {emp_id: $('#emp_id').val()},
//       dataType: 'text',
//       type: 'post',
//       success: function(data){
//         if (data === 'ok') {
//           let iframe = $('#View');
//           iframe.attr('src', href); 
//         } else {
//           alert("로그인 후 이용해주세요!");
//         }
//       },
//       error: function(jqXHR, textStatus, errorThrown) {
//         console.log('Error: ' + textStatus);
//         console.log('Error Detail:', errorThrown);
//       }
//     })
//   })
// })
// //받은 편지함
// .ready(function(){
//   $('#receive').click(function(event){
//     event.preventDefault(); // 기본 동작 방지

//     let $this = $(this); // 클릭된 요소 저장
//     let href = $this.attr('href');

//     $.ajax({
//       url: '/Main_Session',
//       data: {emp_id: $('#emp_id').val()},
//       dataType: 'text',
//       type: 'post',
//       success: function(data){
//         if (data === 'ok') {
//           let iframe = $('#View');
//           iframe.attr('src', href); 
//         } else {
//           alert("로그인 후 이용해주세요!");
//         }
//       },
//       error: function(jqXHR, textStatus, errorThrown) {
//         console.log('Error: ' + textStatus);
//         console.log('Error Detail:', errorThrown);
//       }
//     })
//   })
// })
// //보낸 편지함
// .ready(function(){
//   $('#send').click(function(event){
//     event.preventDefault(); // 기본 동작 방지

//     let $this = $(this); // 클릭된 요소 저장
//     let href = $this.attr('href');

//     $.ajax({
//       url: '/Main_Session',
//       data: {emp_id: $('#emp_id').val()},
//       dataType: 'text',
//       type: 'post',
//       success: function(data){
//         if (data === 'ok') {
//           let iframe = $('#View');
//           iframe.attr('src', href); 
//         } else {
//           alert("로그인 후 이용해주세요!");
//         }
//       },
//       error: function(jqXHR, textStatus, errorThrown) {
//         console.log('Error: ' + textStatus);
//         console.log('Error Detail:', errorThrown);
//       }
//     })
//   })
// })
// // 휴지통
// .ready(function(){
//   $('#tom').click(function(event){
//     event.preventDefault(); // 기본 동작 방지

//     let $this = $(this); // 클릭된 요소 저장
//     let href = $this.attr('href');

//     $.ajax({
//       url: '/Main_Session',
//       data: {emp_id: $('#emp_id').val()},
//       dataType: 'text',
//       type: 'post',
//       success: function(data){
//         if (data === 'ok') {
//           let iframe = $('#View');
//           iframe.attr('src', href); 
//         } else {
//           alert("로그인 후 이용해주세요!");
//         }
//       },
//       error: function(jqXHR, textStatus, errorThrown) {
//         console.log('Error: ' + textStatus);
//         console.log('Error Detail:', errorThrown);
//       }
//     })
//   })
// })
// //자유게시판
// .ready(function(){
//   $('#free').click(function(event){
//     event.preventDefault(); // 기본 동작 방지

//     let $this = $(this); // 클릭된 요소 저장
//     let href = $this.attr('href');

//     $.ajax({
//       url: '/Main_Session',
//       data: {emp_id: $('#emp_id').val()},
//       dataType: 'text',
//       type: 'post',
//       success: function(data){
//         if (data === 'ok') {
//           let iframe = $('#View');
//           iframe.attr('src', href); 
//         } else {
//           alert("로그인 후 이용해주세요!");
//         }
//       },
//       error: function(jqXHR, textStatus, errorThrown) {
//         console.log('Error: ' + textStatus);
//         console.log('Error Detail:', errorThrown);
//       }
//     })
//   })
// })
// //공지사항
// .ready(function(){
//   $('#notice').click(function(event){
//     event.preventDefault(); // 기본 동작 방지

//     let $this = $(this); // 클릭된 요소 저장
//     let href = $this.attr('href');

//     $.ajax({
//       url: '/Main_Session',
//       data: {emp_id: $('#emp_id').val()},
//       dataType: 'text',
//       type: 'post',
//       success: function(data){
//         if (data === 'ok') {
//           let iframe = $('#View');
//           iframe.attr('src', href); 
//         } else {
//           alert("로그인 후 이용해주세요!");
//         }
//       },
//       error: function(jqXHR, textStatus, errorThrown) {
//         console.log('Error: ' + textStatus);
//         console.log('Error Detail:', errorThrown);
//       }
//     })
//   })
// })
// // 기안하기
// .ready(function(){
//   $('#draft').click(function(event){
//     event.preventDefault(); // 기본 동작 방지

//     let $this = $(this); // 클릭된 요소 저장
//     let href = $this.attr('href');

//     $.ajax({
//       url: '/Main_Session',
//       data: {emp_id: $('#emp_id').val()},
//       dataType: 'text',
//       type: 'post',
//       success: function(data){
//         if (data === 'ok') {
//           let iframe = $('#View');
//           iframe.attr('src', href); 
//         } else {
//           alert("로그인 후 이용해주세요!");
//         }
//       },
//       error: function(jqXHR, textStatus, errorThrown) {
//         console.log('Error: ' + textStatus);
//         console.log('Error Detail:', errorThrown);
//       }
//     })
//   })
// })
// // 결재 목록
// .ready(function(){
//   $('#list').click(function(event){
//     event.preventDefault(); // 기본 동작 방지

//     let $this = $(this); // 클릭된 요소 저장
//     let href = $this.attr('href');

//     $.ajax({
//       url: '/Main_Session',
//       data: {emp_id: $('#emp_id').val()},
//       dataType: 'text',
//       type: 'post',
//       success: function(data){
//         if (data === 'ok') {
//           let iframe = $('#View');
//           iframe.attr('src', href); 
//         } else {
//           alert("로그인 후 이용해주세요!");
//         }
//       },
//       error: function(jqXHR, textStatus, errorThrown) {
//         console.log('Error: ' + textStatus);
//         console.log('Error Detail:', errorThrown);
//       }
//     })
//   })
// })
// // 사원 조회
// .ready(function(){
//   $('#inquiry').click(function(event){
//     event.preventDefault(); // 기본 동작 방지

//     let $this = $(this); // 클릭된 요소 저장
//     let href = $this.attr('href');

//     $.ajax({
//       url: '/Main_Session',
//       data: {emp_id: $('#emp_id').val()},
//       dataType: 'text',
//       type: 'post',
//       success: function(data){
//         if (data === 'ok') {
//           let iframe = $('#View');
//           iframe.attr('src', href); 
//         } else {
//           alert("로그인 후 이용해주세요!");
//         }
//       },
//       error: function(jqXHR, textStatus, errorThrown) {
//         console.log('Error: ' + textStatus);
//         console.log('Error Detail:', errorThrown);
//       }
//     })
//   })
// })
// // 사원 부서 변경
// .ready(function(){
//   $('#registration').click(function(event){
//     event.preventDefault(); // 기본 동작 방지

//     let $this = $(this); // 클릭된 요소 저장
//     let href = $this.attr('href');

//     $.ajax({
//       url: '/Main_Session',
//       data: {emp_id: $('#emp_id').val()},
//       dataType: 'text',
//       type: 'post',
//       success: function(data){
//         if (data === 'ok') {
//           let iframe = $('#View');
//           iframe.attr('src', href); 
//         } else {
//           alert("로그인 후 이용해주세요!");
//         }
//       },
//       error: function(jqXHR, textStatus, errorThrown) {
//         console.log('Error: ' + textStatus);
//         console.log('Error Detail:', errorThrown);
//       }
//     })
//   })
// })
// // 조직도
// .ready(function(){
//   $('#organization').click(function(event){
//     event.preventDefault(); // 기본 동작 방지

//     let $this = $(this); // 클릭된 요소 저장
//     let href = $this.attr('href');

//     $.ajax({
//       url: '/Main_Session',
//       data: {emp_id: $('#emp_id').val()},
//       dataType: 'text',
//       type: 'post',
//       success: function(data){
//         if (data === 'ok') {
//           let iframe = $('#View');
//           iframe.attr('src', href); 
//         } else {
//           alert("로그인 후 이용해주세요!");
//         }
//       },
//       error: function(jqXHR, textStatus, errorThrown) {
//         console.log('Error: ' + textStatus);
//         console.log('Error Detail:', errorThrown);
//       }
//     })
//   })
// })
// // 사원 근태 현황
// .ready(function(){
//   $('#current').click(function(event){
//     event.preventDefault(); // 기본 동작 방지

//     let $this = $(this); // 클릭된 요소 저장
//     let href = $this.attr('href');

//     $.ajax({
//       url: '/Main_Session',
//       data: {emp_id: $('#emp_id').val()},
//       dataType: 'text',
//       type: 'post',
//       success: function(data){
//         if (data === 'ok') {
//           let iframe = $('#View');
//           iframe.attr('src', href); 
//         } else {
//           alert("로그인 후 이용해주세요!");
//         }
//       },
//       error: function(jqXHR, textStatus, errorThrown) {
//         console.log('Error: ' + textStatus);
//         console.log('Error Detail:', errorThrown);
//       }
//     })
//   })
// })
//해당 url 숨기기
.ready(function() {
	$('#linkContainer').hide();
	$('#linkContainer2').hide();
	$('#linkContainer3').hide();
	$('#linkContainer4').hide();
	$('#linkContainer5').hide();
	$('#linkContainer6').hide();
	
  	$('#Category_box1').click(function() {
    	let linkContainer = $(this).find('#linkContainer');
    	linkContainer.toggle();
  	})
  	$('#Category_box2').click(function() {
    	let linkContainer = $(this).find('#linkContainer2');
    	linkContainer.toggle();
  	})
  	$('#Category_box3').click(function() {
    	let linkContainer = $(this).find('#linkContainer3');
    	linkContainer.toggle();
  	})
  	$('#Category_box4').click(function() {
    	let linkContainer = $(this).find('#linkContainer4');
    	linkContainer.toggle();
  	})
  	$('#Category_box5').click(function() {
    	let linkContainer = $(this).find('#linkContainer5');
    	linkContainer.toggle();
  	})
  	$('#Category_box6').click(function() {
    	let linkContainer = $(this).find('#linkContainer6');
    	linkContainer.toggle();
  	})
})
// 사이드메뉴 동작
.on("click", ".Category_container a", function(e){
  e.preventDefault(); // 기본 동작 방지

  let $this = $(this); // 클릭된 요소 저장
  let href = $this.attr('href');

  $.ajax({
    url: '/Main_Session',
    data: {emp_id: $('#emp_id').val()},
    dataType: 'text',
    type: 'post',
    success: function(data){
      if (data === 'ok') {
        let iframe = $('#View');
        iframe.attr('src', href); 
      } else {
        alert("로그인 후 이용해주세요!");
      }
    },
    error: function(jqXHR, textStatus, errorThrown) {
      console.log('Error: ' + textStatus);
      console.log('Error Detail:', errorThrown);
    }
  })
})
//해당 사원을 찾고 없으면 fail, 있으면 사진,이름,생년월일,모바일번호,이메일,직급,부서를 보여주는 기능이다. 
.on('click', '#Search_EmpBtn', function() {
    $('#emp_info').empty();
    let Search_Emp = $('#Search_Emp').val();

    if (Search_Emp == "" || Search_Emp == null) {
      alert('사원 이름을 입력해주세요!');
      return false;
    }

    $('#emp_dialog').dialog({
      title: '사원 찾기',
      modal: true,
      width: 500
    });

    $.ajax({
      url: '/Main_Search',
      data: {Search_Emp: Search_Emp},
      dataType: 'json',
      type: 'post',
      success: function(data) {
        if (data.length == 0) {
          alert("해당 사원이 없습니다...");
          $('#emp_dialog').dialog('close');
          return false;
        }

        if (data && data.length > 0) {
          $('#emp_info').empty();
          for (let i = 0; i < data.length; i++) {
            let empData = data[i];
            let empDiv = $('<div>').addClass('emp_item');

            let imgName = "";
            if (empData.emp_img) {
              imgName = empData.emp_img.split('/').pop();
            }
            let imgElement = $('<img>').attr('src', '/img/' + imgName);

            if (imgName == "") {
              let No_Img = $('<img>').attr('src', '/img/Not_img.jpg');
              empDiv.append(No_Img);
            } else {
              empDiv.append(imgElement);
            }

            let infoText = $('<div>').addClass('info-text');
            let nameElement = $('<p>').text('이름: ' + empData.emp_name);
            let birthElement = $('<p>').text('생년월일: ' + empData.emp_birth);
            let mobileElement = $('<p>').text('전화번호: ' + empData.emp_mobile);
            let emailElement = $('<p>').text('이메일: ' + empData.emp_email);
            let genderElement = $('<p>').text('성별: ' + empData.emp_gender);
            let departElement = $('<p>').text('부서: ' + empData.emp_depart);
            let positionElement = $('<p>').text('직급: ' + empData.emp_position);

            infoText.append(nameElement, birthElement, mobileElement, emailElement, genderElement, departElement, positionElement);
            empDiv.append(infoText);
            empDiv.appendTo('#emp_info');
          }
        }
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert('로그인 후 이용해주세요!');
        $('#emp_dialog').dialog('close');
        console.log('Error: ' + textStatus);
      }
    })
  })
.on("click","#Category_box4",function(){
	getUserInfo()
})
  function MainList() {
	  $.ajax({
	    url: '/Mypage_list',
	    type: 'POST',
	    dataType: 'json',
	    data: { emp_id: $('#emp_id').val() },
	    success: function(data) {
	      let empData = data[0];

	      $('#emp_name').text('이름: ' + empData.emp_name);
	      $('#emp_position').text('직급: ' + empData.emp_position);
	      $('#emp_depart').text('부서: ' + empData.emp_depart);
	      let imgName = "";
      		if (empData.emp_img) {
      	  		imgName = empData.emp_img.split('/').pop();
      		}
	      if (imgName == "undefined" || imgName == "") {
	    	  $('#emp_img').attr('src', '/img/Not_img.jpg');
	    	} else {
	    	  $('#emp_img').attr('src', '/img/' + imgName);
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown) {
	      console.log('Error: ' + textStatus);
	      console.log('Error Detail:', errorThrown);
	    }
	  });
	}
	function getUserInfo(){
		$.ajax({url:"/getUserInfo",
				type:"get"})
	}
</script>
</html>