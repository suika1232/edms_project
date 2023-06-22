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
    					<div id="position_name"></div>
    					<div id="dep_name"></div>
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
			<% position = session.getAttribute("emp_position") == null ? 0 : (int)session.getAttribute("emp_position");
				} %>
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
				<a href="/attendance/byEmployee" id='byEmp'>사원 근태 현황</a>
				<% int depId = session.getAttribute("emp_depart") != null ? (int)session.getAttribute("emp_depart") : 0; %>
				<% if(depId == 27){%>
					<a href="/employee/registration" id='registration'>사원 부서 변경</a>
					<a href="/employee/organization" id='organization'>부서/직급 등록</a>
				<% }%>
			</div>
		</div>
	</div>
	</div>
	<div class="col float-md-end video-warp" style="height: 800px;">
		<iframe id="View" src="/employee/main" style="height: 100%;"></iframe>
  </div>
  <div class="footer_container">
		<div class="footer_box1">
			Company : HumanGroupWare <br>
			대표 : 박선우 박정훈 한지은 김상호 <br>
			대표전화 : 041-561-1122 <br>
			팩스 : 041-561-1126 <br>
			이메일 : humangroupware@a.com <br>
			사업자 등록번호 : 667-81-02135
		</div>
		<div class="footer_box2">
			<svg xmlns="http://www.w3.org/2000/svg" width="48px" height="48px" fill="currentColor" class="bi bi-instagram" viewBox="0 0 16 16">
  				<path d="M8 0C5.829 0 5.556.01 4.703.048 3.85.088 3.269.222 2.76.42a3.917 3.917 0 0 0-1.417.923A3.927 3.927 0 0 0 .42 2.76C.222 3.268.087 3.85.048 4.7.01 5.555 0 5.827 0 8.001c0 2.172.01 2.444.048 3.297.04.852.174 1.433.372 1.942.205.526.478.972.923 1.417.444.445.89.719 1.416.923.51.198 1.09.333 1.942.372C5.555 15.99 5.827 16 8 16s2.444-.01 3.298-.048c.851-.04 1.434-.174 1.943-.372a3.916 3.916 0 0 0 1.416-.923c.445-.445.718-.891.923-1.417.197-.509.332-1.09.372-1.942C15.99 10.445 16 10.173 16 8s-.01-2.445-.048-3.299c-.04-.851-.175-1.433-.372-1.941a3.926 3.926 0 0 0-.923-1.417A3.911 3.911 0 0 0 13.24.42c-.51-.198-1.092-.333-1.943-.372C10.443.01 10.172 0 7.998 0h.003zm-.717 1.442h.718c2.136 0 2.389.007 3.232.046.78.035 1.204.166 1.486.275.373.145.64.319.92.599.28.28.453.546.598.92.11.281.24.705.275 1.485.039.843.047 1.096.047 3.231s-.008 2.389-.047 3.232c-.035.78-.166 1.203-.275 1.485a2.47 2.47 0 0 1-.599.919c-.28.28-.546.453-.92.598-.28.11-.704.24-1.485.276-.843.038-1.096.047-3.232.047s-2.39-.009-3.233-.047c-.78-.036-1.203-.166-1.485-.276a2.478 2.478 0 0 1-.92-.598 2.48 2.48 0 0 1-.6-.92c-.109-.281-.24-.705-.275-1.485-.038-.843-.046-1.096-.046-3.233 0-2.136.008-2.388.046-3.231.036-.78.166-1.204.276-1.486.145-.373.319-.64.599-.92.28-.28.546-.453.92-.598.282-.11.705-.24 1.485-.276.738-.034 1.024-.044 2.515-.045v.002zm4.988 1.328a.96.96 0 1 0 0 1.92.96.96 0 0 0 0-1.92zm-4.27 1.122a4.109 4.109 0 1 0 0 8.217 4.109 4.109 0 0 0 0-8.217zm0 1.441a2.667 2.667 0 1 1 0 5.334 2.667 2.667 0 0 1 0-5.334z"/>
			</svg>
			<svg xmlns="http://www.w3.org/2000/svg" width="48px" height="48px" fill="currentColor" class="bi bi-twitter" viewBox="0 0 16 16">
  				<path d="M5.026 15c6.038 0 9.341-5.003 9.341-9.334 0-.14 0-.282-.006-.422A6.685 6.685 0 0 0 16 3.542a6.658 6.658 0 0 1-1.889.518 3.301 3.301 0 0 0 1.447-1.817 6.533 6.533 0 0 1-2.087.793A3.286 3.286 0 0 0 7.875 6.03a9.325 9.325 0 0 1-6.767-3.429 3.289 3.289 0 0 0 1.018 4.382A3.323 3.323 0 0 1 .64 6.575v.045a3.288 3.288 0 0 0 2.632 3.218 3.203 3.203 0 0 1-.865.115 3.23 3.23 0 0 1-.614-.057 3.283 3.283 0 0 0 3.067 2.277A6.588 6.588 0 0 1 .78 13.58a6.32 6.32 0 0 1-.78-.045A9.344 9.344 0 0 0 5.026 15z"/>
			</svg>
			<svg xmlns="http://www.w3.org/2000/svg"  viewBox="0 0 48 48" width="48px" height="48px"><path fill="#263238" d="M24,4C12.402,4,3,11.611,3,21c0,5.99,3.836,11.245,9.618,14.273l-2.219,7.397	c-0.135,0.449,0.366,0.82,0.756,0.56l8.422-5.615C21.004,37.863,22.482,38,24,38c11.598,0,21-7.611,21-17S35.598,4,24,4z"/><path fill="#ffca28" d="M15,18H9c-0.552,0-1-0.448-1-1v0c0-0.552,0.448-1,1-1h6c0.552,0,1,0.448,1,1v0	C16,17.552,15.552,18,15,18z"/><path fill="#ffca28" d="M25,26v-9c0-0.552,0.448-1,1-1h0c0.552,0,1,0.448,1,1v9c0,0.552-0.448,1-1,1h0	C25.448,27,25,26.552,25,26z"/>
				<path fill="#ffca28" d="M32,26v-9c0-0.552,0.448-1,1-1l0,0c0.552,0,1,0.448,1,1v9c0,0.552-0.448,1-1,1l0,0	C32.448,27,32,26.552,32,26z"/><path fill="#ffca28" d="M32.621,21.207l4.914-4.914c0.391-0.391,1.024-0.391,1.414,0v0c0.391,0.391,0.391,1.024,0,1.414	l-4.914,4.914c-0.391,0.391-1.024,0.391-1.414,0l0,0C32.231,22.231,32.231,21.598,32.621,21.207z"/><path fill="#ffca28" d="M36.078,20.665l3.708,4.717c0.341,0.434,0.266,1.063-0.168,1.404l0,0	c-0.434,0.341-1.063,0.266-1.404-0.168l-3.708-4.717c-0.341-0.434-0.266-1.063,0.168-1.404v0	C35.108,20.156,35.737,20.231,36.078,20.665z"/>
				<path fill="#ffca28" d="M30,27h-4c-0.552,0-1-0.448-1-1v0c0-0.552,0.448-1,1-1h4c0.552,0,1,0.448,1,1v0	C31,26.552,30.552,27,30,27z"/><path fill="#ffca28" d="M23.933,25.642l-3.221-9c-0.145-0.379-0.497-0.611-0.878-0.629c-0.111-0.005-0.54-0.003-0.641-0.001	c-0.392,0.007-0.757,0.241-0.906,0.63l-3.221,9c-0.198,0.516,0.06,1.094,0.576,1.292s1.094-0.06,1.292-0.576L17.42,25h4.16	l0.486,1.358c0.198,0.516,0.776,0.773,1.292,0.576S24.131,26.157,23.933,25.642z M18.136,23l1.364-3.812L20.864,23H18.136z"/><path fill="#ffca28" d="M13,18h-2v8c0,0.552,0.448,1,1,1h0c0.552,0,1-0.448,1-1V18z"/>
			</svg>
			<svg xmlns="http://www.w3.org/2000/svg" width="48px" height="48px" fill="currentColor" class="bi bi-line" viewBox="0 0 16 16">
  				<path d="M8 0c4.411 0 8 2.912 8 6.492 0 1.433-.555 2.723-1.715 3.994-1.678 1.932-5.431 4.285-6.285 4.645-.83.35-.734-.197-.696-.413l.003-.018.114-.685c.027-.204.055-.521-.026-.723-.09-.223-.444-.339-.704-.395C2.846 12.39 0 9.701 0 6.492 0 2.912 3.59 0 8 0ZM5.022 7.686H3.497V4.918a.156.156 0 0 0-.155-.156H2.78a.156.156 0 0 0-.156.156v3.486c0 .041.017.08.044.107v.001l.002.002.002.002a.154.154 0 0 0 .108.043h2.242c.086 0 .155-.07.155-.156v-.56a.156.156 0 0 0-.155-.157Zm.791-2.924a.156.156 0 0 0-.156.156v3.486c0 .086.07.155.156.155h.562c.086 0 .155-.07.155-.155V4.918a.156.156 0 0 0-.155-.156h-.562Zm3.863 0a.156.156 0 0 0-.156.156v2.07L7.923 4.832a.17.17 0 0 0-.013-.015v-.001a.139.139 0 0 0-.01-.01l-.003-.003a.092.092 0 0 0-.011-.009h-.001L7.88 4.79l-.003-.002a.029.029 0 0 0-.005-.003l-.008-.005h-.002l-.003-.002-.01-.004-.004-.002a.093.093 0 0 0-.01-.003h-.002l-.003-.001-.009-.002h-.006l-.003-.001h-.004l-.002-.001h-.574a.156.156 0 0 0-.156.155v3.486c0 .086.07.155.156.155h.56c.087 0 .157-.07.157-.155v-2.07l1.6 2.16a.154.154 0 0 0 .039.038l.001.001.01.006.004.002a.066.066 0 0 0 .008.004l.007.003.005.002a.168.168 0 0 0 .01.003h.003a.155.155 0 0 0 .04.006h.56c.087 0 .157-.07.157-.155V4.918a.156.156 0 0 0-.156-.156h-.561Zm3.815.717v-.56a.156.156 0 0 0-.155-.157h-2.242a.155.155 0 0 0-.108.044h-.001l-.001.002-.002.003a.155.155 0 0 0-.044.107v3.486c0 .041.017.08.044.107l.002.003.002.002a.155.155 0 0 0 .108.043h2.242c.086 0 .155-.07.155-.156v-.56a.156.156 0 0 0-.155-.157H11.81v-.589h1.525c.086 0 .155-.07.155-.156v-.56a.156.156 0 0 0-.155-.157H11.81v-.589h1.525c.086 0 .155-.07.155-.156Z"/>
			</svg>
		</div>
		<div class="footer_box3">
			평일 : 오전 9시 ~ 오후 18시 <br>
			공휴일 및 주말은 영업안합니다.
		</div>
		<div class="footer_box4">
			개인정보 처리방침  |  이용약관
			Ⓒ 2023 HumanGroupWare.
		</div>
	</div>
</body>
<script src='https://code.jquery.com/jquery-latest.js'></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
$(document)
.ready(function(){
	MainList();
})
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
            let departElement = $('<p>').text('부서: ' + empData.dep_name);
            let positionElement = $('<p>').text('직급: ' + empData.position_name);

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
	      $('#position_name').text('직급: ' + empData.position_name);
	      $('#dep_name').text('부서: ' + empData.dep_name);
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